-- lua/plugins/completion.lua
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its source for nvim-cmp
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds file path completion
    'hrsh7th/cmp-path',
    
    -- Adds words from the current buffer completion
    'hrsh7th/cmp-buffer',

    -- A collection of useful snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Loads vscode-style snippets from installed plugins (e.g., friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      -- Tell nvim-cmp how to expand snippets
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Key Mappings (This is the updated section)
      mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- The new, smarter mapping for the Enter key
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- If a snippet is expandable, expand it
            if luasnip.expandable() then
              luasnip.expand()
            else
              -- Otherwise, confirm the selected completion
              cmp.confirm({
                select = true,
              })
            end
          else
            -- If no completion is visible, execute the default fallback behavior (new line)
            fallback()
          end
        end, { "i", "s" }), -- This mapping is active in Insert and Select mode
      },

      -- Sources for completion
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
    })
  end,
}
