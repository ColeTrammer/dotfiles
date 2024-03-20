-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Add <leader+p> to paste in visual mode without yanking over the current selection
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, desc = "Paste without yanking over selection" })

-- Auto center the cursor when scrolling.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Replace word under cursor.
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Toggle Copilot with <leader>cp
vim.g.GitHubCopilotEnabled = true
local function copilot_toggle()
  if vim.g.GitHubCopilotEnabled then
    require("copilot.command").disable()
  else
    require("copilot.command").enable()
  end

  vim.g.GitHubCopilotEnabled = not vim.g.GitHubCopilotEnabled
end

-- Start disabled
copilot_toggle()

vim.keymap.set("n", "<leader>cp", copilot_toggle, { noremap = true, desc = "Toggle GitHub Copilot" })
