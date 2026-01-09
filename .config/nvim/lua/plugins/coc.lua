return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- Global extensions
      vim.g.coc_global_extensions = {
        "coc-tsserver",
        "coc-eslint8",
        "coc-prettier",
        "coc-git",
        "coc-fzf-preview",
        "coc-lists",
      }

      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      -- Keymaps
      keymap("i", "<C-Space>", "coc#refresh()", { expr = true, silent = true })
      keymap("n", "K", "<CMD>lua _G.show_documentation()<CR>", opts)
      keymap("n", "mrn", "<Plug>(coc-rename)", opts)
      keymap("n", "ma", "<Plug>(coc-codeaction-selected)iw", opts)

      -- Navigation
      keymap("n", "gd", "<Plug>(coc-definition)", opts)
      keymap("n", "gy", "<Plug>(coc-type-definition)", opts)
      keymap("n", "gi", "<Plug>(coc-implementation)", opts)
      keymap("n", "gr", "<Plug>(coc-references)", opts)

      -- Show documentation
      function _G.show_documentation()
        local filetype = vim.bo.filetype
        if filetype == "vim" or filetype == "help" then
          vim.cmd("help " .. vim.fn.expand("<cword>"))
        elseif vim.fn["coc#rpc#ready"]() then
          vim.fn.CocActionAsync("doHover")
        end
      end

      -- TypeScript specific settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact" },
        callback = function()
          keymap(
            "n",
            "mf",
            "<CMD>CocCommand eslint.executeAutofix<CR><CMD>CocCommand prettier.formatFile<CR>",
            { buffer = true, silent = true }
          )
        end,
      })
    end,
  },
}
