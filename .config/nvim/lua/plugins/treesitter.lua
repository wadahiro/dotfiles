return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      treesitter.setup({
        ensure_installed = {
          "typescript",
          "tsx",
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
