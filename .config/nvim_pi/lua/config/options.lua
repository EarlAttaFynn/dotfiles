-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Sync clipboard between OS and Neovim.
-- This keeps 'dd', 'x', and 'yy' instant and local to Neovim.
vim.opt.clipboard = ""
-- 2. Configure the provider to only listen for the '+' register
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")

  vim.g.clipboard = {
    name = "OSC 52 (Plus Register Only)",
    copy = {
      -- When you type "+y, send it to the host via OSC 52
      ["+"] = osc52.copy("+"),
      -- When you type "*y, keep it local/do nothing (saves performance)
      ["*"] = function() end,
    },
    paste = {
      -- When you type "+p, try to paste from host (if terminal supports it)
      ["+"] = osc52.paste("+"),
      -- "*p does nothing or uses internal cache
      ["*"] = function()
        return {}
      end,
    },
  }
end
