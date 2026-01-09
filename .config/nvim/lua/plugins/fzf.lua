return {
  {
    "junegunn/fzf",
    dir = "~/.fzf_bin",
    build = "./install --all",
    config = function()
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      -- fzf-preview keymaps
      keymap("n", "<C-p>", "<CMD>CocCommand fzf-preview.FromResources buffer project_mru project<CR>", opts)
      keymap("n", "zs", "<CMD>CocCommand fzf-preview.GitStatus<CR>", opts)
      keymap("n", "zgg", "<CMD>CocCommand fzf-preview.GitActions<CR>", opts)
      keymap("n", "zb", "<CMD>CocCommand fzf-preview.Buffers<CR>", opts)
      keymap("n", "zf", "<CMD>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort ", opts)
      keymap(
        "x",
        "zf",
        '"sy:CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort -F "<C-r>=substitute(substitute(@s, "\\n", "", "g"), "/", "\\\\/", "g")<CR>"',
        opts
      )

      keymap("n", "zq", "<CMD>CocCommand fzf-preview.CocCurrentDiagnostics<CR>", opts)
      keymap("n", "zrf", "<CMD>CocCommand fzf-preview.CocReferences<CR>", opts)
      keymap("n", "zd", "<CMD>CocCommand fzf-preview.CocDefinition<CR>", opts)
      keymap("n", "zt", "<CMD>CocCommand fzf-preview.CocTypeDefinition<CR>", opts)
      keymap("n", "zo", "<CMD>CocCommand fzf-preview.CocOutline --add-fzf-arg=--exact --add-fzf-arg=--no-sort<CR>", opts)
      keymap("n", "zi", "<CMD>CocCommand fzf-preview.CocImplementations<CR>", opts)
    end,
  },
}
