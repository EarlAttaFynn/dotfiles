-- ~/.config/nvim/lua/plugins/rust-keymaps.lua

return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      local old_on_attach = opts.server and opts.server.on_attach

      opts.server = opts.server or {}
      opts.server.on_attach = function(client, bufnr)
        if old_on_attach then
          old_on_attach(client, bufnr)
        end

        -- === 1. Recommended Overrides ===

        -- THIS IS THE CORRECTED SYNTAX, using a Lua table
        vim.keymap.set("n", "K", function()
          vim.cmd.RustLsp({ "hover", "actions" })
        end, {
          buffer = bufnr,
          desc = "Hover (Rustacean)",
        })

        vim.keymap.set("n", "<leader>ca", function()
          vim.cmd.RustLsp("codeAction")
        end, {
          buffer = bufnr,
          desc = "Code Action (Rust)",
        })

        -- === 2. Your New <leader>R Menu ===
        vim.keymap.set("n", "<leader>R", "", {
          buffer = bufnr,
          desc = "+Rust",
        })

        vim.keymap.set("n", "<leader>Rr", function()
          vim.cmd.RustLsp("runnables")
        end, {
          buffer = bufnr,
          desc = "Runnables",
        })
        vim.keymap.set("n", "<leader>Rd", function()
          vim.cmd.RustLsp("debuggables")
        end, {
          buffer = bufnr,
          desc = "Debuggables",
        })
        vim.keymap.set("n", "<leader>Rt", function()
          vim.cmd.RustLsP("testables")
        end, {
          buffer = bufnr,
          desc = "Testables",
        })
        vim.keymap.set("n", "<leader>Re", function()
          vim.cmd.RustLsp("explain")
        end, {
          buffer = bufnr,
          desc = "Explain Error",
        })
        vim.keymap.set("n", "<leader>Rj", function()
          vim.cmd.RustLsp("joinLines")
        end, {
          buffer = bufnr,
          desc = "Join Lines",
        })
        vim.keymap.set("n", "<leader>Rp", function()
          vim.cmd.RustLsp("parentModule")
        end, {
          buffer = bufnr,
          desc = "Parent Module",
        })
        vim.keymap.set("n", "<leader>Rg", function()
          vim.cmd.RustLsp("viewCrateGraph")
        end, {
          buffer = bufnr,
          desc = "Crate Graph",
        })
      end
    end,
  },
}
