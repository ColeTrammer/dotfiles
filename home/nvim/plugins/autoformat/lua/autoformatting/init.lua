local Path = require("plenary.path")

local disabled_filetypes = {}
local disabled_files = {}
local disabled_globally = false
local formatter_overrides = {}

---@return string
local function get_filetype()
  local filetype = vim.bo.ft or vim.bo.filetype
  return filetype
end

---@return string
local function get_file()
  local file = vim.fn.expand("%:p")
  return file
end

---@return boolean|nil
local function autoformatting_enabled_file()
  local file = get_file()
  return disabled_files[file]
end

---@return boolean|nil
local function autoformatting_enabled_filetype()
  local filetype = get_filetype()
  return disabled_filetypes[filetype]
end

---@return boolean
local function autoformatting_enabled()
  local file_enabled = autoformatting_enabled_file()
  if file_enabled ~= nil then
    return file_enabled
  end

  local filetype_enabled = autoformatting_enabled_filetype()
  if filetype_enabled ~= nil then
    return filetype_enabled
  end

  return not disabled_globally
end

---@return string[]|nil
local function formatter()
  local file = get_file()
  if formatter_overrides[file] ~= nil then
    return { formatter_overrides[file] }
  end
  return nil
end

---@param status boolean|nil
---@return string
local function display_icon(status)
  if status == nil then
    return " "
  elseif status then
    return ""
  else
    return ""
  end
end

local function display_status()
  local filetype_enabled = autoformatting_enabled_filetype()
  local file_enabled = autoformatting_enabled_file()
  local enabled = autoformatting_enabled()
  vim.notify(
    "Overall status: ["
      .. display_icon(enabled)
      .. "]\nGlobal Auto-Format: ["
      .. (display_icon(not disabled_globally))
      .. "]\nFile Type Auto-Format: ["
      .. (display_icon(filetype_enabled))
      .. "]\nFile Auto-Format: ["
      .. (display_icon(file_enabled))
      .. "]\nFormatter Override: ["
      .. (formatter() or { " " })[1]
      .. "]\n",
    vim.log.levels.info
  )
end

local data_path = string.format("%s/autoformatting", vim.fn.stdpath("data"))
local ensured_directory = false

local function ensure_directory()
  if ensured_directory then
    return
  end

  local path = Path:new(data_path)
  if not path:exists() then
    path:mkdir()
  end
  ensured_directory = true
end

---@param session string
---@return string
local function file_path(session)
  return string.format("%s/%s.json", data_path, session)
end

---@param session string
local function write_data(session)
  ensure_directory()

  Path:new(file_path(session)):write(
    vim.json.encode({
      filetypes = disabled_filetypes,
      files = disabled_files,
      globally_disabled = disabled_globally,
      formatters = formatter_overrides,
    }),
    "w"
  )
end

---@param session string
local function read_data(session)
  ensure_directory()

  local path = Path:new(file_path(session))
  if not path:exists() then
    write_data(session)
  end

  local string_data = path:read()
  if not string_data or string_data == "" then
    write_data(session)
  end

  local data = vim.json.decode(string_data)

  disabled_globally = data["globally_disabled"]
  disabled_files = data["files"] or {}
  disabled_filetypes = data["filetypes"] or {}
  formatter_overrides = data["formatters"] or {}
end

return {
  setup = function()
    local group = vim.api.nvim_create_augroup("autoformatting", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      group = group,
      callback = function(args)
        local bufnr = args.buf

        if autoformatting_enabled() then
          local conform = require("conform")
          conform.format({ timeout_ms = 500, lsp_fallback = true, formatters = formatter() }, function()
            vim.diagnostic.show(nil, bufnr)
          end)
        end
      end,
      desc = "Format on Save",
    })
  end,

  toggle_filetype = function()
    local filetype = get_filetype()
    if disabled_filetypes[filetype] == nil then
      disabled_filetypes[filetype] = disabled_globally
    elseif not disabled_filetypes[filetype] then
      disabled_filetypes[filetype] = true
    else
      disabled_filetypes[filetype] = false
    end

    display_status()
  end,

  toggle_file = function()
    local file = get_file()
    if disabled_files[file] == nil then
      disabled_files[file] = not autoformatting_enabled()
    elseif not disabled_files[file] then
      disabled_files[file] = true
    else
      disabled_files[file] = false
    end

    display_status()
  end,

  toggle_globally = function()
    disabled_globally = not disabled_globally

    display_status()
  end,

  reset = function()
    disabled_files = {}
    disabled_filetypes = {}
    disabled_globally = false
    formatter_overrides = {}

    display_status()
  end,

  formatter_override = function()
    local formatters = require("conform").list_all_formatters()
    local file = get_file()
    vim.ui.select(
      formatters,
      {
        prompt = "Select formatter for buffer:",
        ---@param item conform.FormatterInfo
        format_item = function(item)
          return item.name
        end,
      },
      ---@param item conform.FormatterInfo|nil
      function(item)
        if item ~= nil then
          formatter_overrides[file] = item.name
        end
      end
    )
  end,

  read_data = read_data,
  write_data = write_data,
  display_status = display_status,
}
