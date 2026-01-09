return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })

      -- Keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      -- File/Buffer navigation
      keymap("n", "<C-p>", builtin.find_files, opts)
      keymap("n", "zb", builtin.buffers, opts)
      keymap("n", "zf", builtin.live_grep, opts)

      -- Git
      keymap("n", "zs", builtin.git_status, opts)
      keymap("n", "zgg", builtin.git_commits, opts)

      -- LSP
      keymap("n", "zd", builtin.lsp_definitions, opts)
      keymap("n", "zrf", builtin.lsp_references, opts)
      keymap("n", "zt", builtin.lsp_type_definitions, opts)
      keymap("n", "zi", builtin.lsp_implementations, opts)
      keymap("n", "zo", builtin.lsp_document_symbols, opts)
      keymap("n", "zq", builtin.diagnostics, opts)
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
}
