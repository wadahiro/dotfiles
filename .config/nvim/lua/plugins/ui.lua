return {
  {
    "vim-airline/vim-airline",
    dependencies = {
      "vim-airline/vim-airline-themes",
    },
    config = function()
      vim.g.airline_theme = "codedark"
      vim.g.airline_powerline_fonts = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g.airline_section_z = vim.fn["airline#section#create"]({
        "windowswap",
        "%3p%% ",
        "linenr",
        ":%3v"
      })
      vim.g["airline#extensions#hunks#enabled"] = 0
    end,
  },
}
