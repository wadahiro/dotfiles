return {
  {
    "lambdalisue/fern.vim",
    config = function()
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      keymap("n", "<Leader>e", "<CMD>Fern . -drawer<CR>", opts)
      keymap("n", "<Leader>E", "<CMD>Fern . -drawer -reveal=%<CR>", opts)
    end,
  },
}
