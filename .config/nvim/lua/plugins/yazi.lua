return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    config = function()
      require("yazi").setup({
        open_for_directories = false,
      })

      -- Keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      keymap("n", "<Leader>e", "<CMD>Yazi<CR>", opts)
      keymap("n", "<Leader>E", "<CMD>Yazi cwd<CR>", opts)
    end,
  },
}
