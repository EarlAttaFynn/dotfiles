return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- This table contains the key mappings
    opts.keymap = {
      -- Use the default preset as a base
      preset = "default",

      -- Map Enter (<CR>) to accept the selected completion
      ["<CR>"] = { "accept", "fallback" },

      -- Map Tab to select the next item in the list
      ["<Tab>"] = { "select_next", "fallback" },

      -- Map Shift+Tab to select the previous item
      ["<S-Tab>"] = { "select_prev", "fallback" },
    }
    opts.completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    }
    opts.completion.show_on_trigger_character = true
  end,
}
