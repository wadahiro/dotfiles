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
      local mason_lspconfig = require("mason-lspconfig")

      -- Ensure servers are installed
      mason_lspconfig.setup({
        ensure_installed = {
          "gopls",
          "ts_ls",
          "eslint",
          "rust_analyzer",
          "jdtls",
          "lua_ls",
        },
      })

      -- Configure LSP servers using native vim.lsp.config
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      vim.lsp.config.gopls = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.mod", ".git" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      vim.lsp.config.ts_ls = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      }

      vim.lsp.config.eslint = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
        root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json", ".git" },
      }

      vim.lsp.config.rust_analyzer = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
      }

      vim.lsp.config.jdtls = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
        filetypes = { "java" },
        root_markers = { "pom.xml", "build.gradle", ".git" },
      }

      vim.lsp.config.lua_ls = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Enable LSP servers
      vim.lsp.enable({ "gopls", "ts_ls", "eslint", "rust_analyzer", "jdtls", "lua_ls" })

      -- LspAttach autocmd for keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf

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
