return {
  -- LSP stuff
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup({})
        end
      }
    },
    config = function()
      -- LSP settings.
      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
        nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>s', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')
        nmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [Symbols]')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer using LSP' })
      end

      -- Enable language servers. They will automatically be installed.
      --
      -- Add any additional override configuration in the following tables.
      -- They will be passed to the `settings` field of the server config.
      -- You must look up that documentation yourself.
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
              workspace = {
                checkThirdParty = false,
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        },
        ruby_ls = {
          init_options = {
            enabledFeatures = {
              'documentHighlights',
              'documentLink',
              'documentSymbols',
              'inlayHint',
              'onTypeFormatting',
              'completion'
            }
          }
        },
        standardrb = {
          settings = {}
        }
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast
      -- that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the above servers are installed
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers)
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          local lsp_setup = {
            capabilities = capabilities,
            on_attach = on_attach,
          }

          for k, v in pairs(servers[server_name]) do
            lsp_setup[k] = v
          end

          require('lspconfig')[server_name].setup(lsp_setup)
        end
      })
    end
  }
}
