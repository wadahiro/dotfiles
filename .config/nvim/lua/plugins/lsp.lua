return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "rust_analyzer",
          "lua_ls",
          "jdtls",
          "gopls",
        },
        automatic_installation = true,
      })

      -- Configure Lua LSP for Neovim development
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Enable language servers
      vim.lsp.enable({ "ts_ls", "eslint", "rust_analyzer", "lua_ls", "jdtls", "gopls" })

      -- LspAttach autocmd for keymaps and settings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Enable native completion
          vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

          -- Keymaps
          local opts = { buffer = bufnr, silent = true, noremap = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "mrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "ma", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "mf", vim.lsp.buf.format, opts)
        end,
      })
    end,
  },
}
