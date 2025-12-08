-- This outer table is what LazyVim expects
return {
  -- This inner table is the plugin spec for better-escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "j", "k" },
        timeout = vim.o.timeoutlen,
      })
    end,
  },
}
