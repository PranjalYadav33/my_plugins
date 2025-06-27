-- lua/plugins/lsp.lua
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvimtools/none-ls.nvim', -- Manages formatters/linters
  },
  config = function()
    -- Setup Mason
    require('mason').setup()

    -- Setup none-ls for formatters and linters
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Add your formatters and linters here
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.flake8,
      },
    })

    -- This function runs for every LSP server that attaches to a buffer
    local on_attach = function(client, bufnr)
      -- Enable formatting on save for LSP-supported buffers
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end

      -- Your other keymaps
      local keymap = vim.keymap
      keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    end

    -- Setup lspconfig
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'vtsls', 'html', 'cssls', 'pyright' },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = on_attach, -- Use our on_attach function
          })
        end,
      },
    })
  end,
}
