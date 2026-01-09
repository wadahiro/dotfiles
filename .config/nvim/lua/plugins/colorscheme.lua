return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  },
  {
    "tomasiser/vim-code-dark",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme codedark")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.vscode_style = "dark"
    end,
  },
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
  },
}
