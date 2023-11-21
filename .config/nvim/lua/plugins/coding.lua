return {
  -- auto-pair characters
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require('mini.pairs').setup()
    end
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      { 'L3MON4D3/LuaSnip', version = "v2.*" },
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup({})

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        end
      end, { silent = true, desc = "expand snippet or jump to next item within snippet" })

      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, desc = "move to the previous item within the snippet" })

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
          ['<C-CR>'] = cmp.mapping(function(fallback) -- Some terminal emulators may need additional config
            cmp.abort()
            fallback()
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        completion = {
          keyword_length = 2
        },
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'luasnip' }
          },
          {
            { name = 'buffer', keyword_length = 2 }
          }
        ),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' }
        },
        formatting = {
          format = function(entry, item)
            item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]"
            })[entry.source.name]
            return item
          end
        },
        experimental = {
          ghost_text = true
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        },
        view = {
          entries = { name = 'wildmenu' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        view = {
          entries = { name = 'wildmenu' }
        }
      })
    end
  }
}
