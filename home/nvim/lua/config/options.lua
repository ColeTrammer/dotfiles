-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- file types
vim.filetype.add({
  pattern = { [".*/hyprland%.conf"] = "hyprlang" },
})

-- line width and indentation
vim.opt.textwidth = 120
vim.opt.shiftwidth = 4

-- swap files cause frequent editor freezes...
vim.opt.swapfile = false

-- always enable system clipboard (this works even remotely thanks to tmux)
vim.opt.clipboard = "unnamedplus"
