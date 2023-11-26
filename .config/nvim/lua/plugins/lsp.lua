return {
  -- LSP stuff
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
      },
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
      -- mason-lspconfig requires that these setup functions are called in this
      -- order before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- LSP settings.
      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
        nmap('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
        nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
        nmap('<leader>dw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
        nmap('<leader>dh', vim.lsp.buf.document_highlight, '[d]ocument [h]ighlight')
        nmap('<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, '[f]ormat')

        -- Lesser used LSP functionality
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[w]orkspace [l]ist folders')

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
              semantic = {
                enable = false
              }
            },
          },
        },
        standardrb = {},
        ruby_ls = {
          init_options = {
            formatter = "none"
          }
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
          local lsp_setup = vim.tbl_extend("error", {
            capabilities = capabilities,
            on_attach = on_attach,
          }, servers[server_name] or {})

          require('lspconfig')[server_name].setup(lsp_setup)
        end
      })

      require('lspconfig.ui.windows').default_options.border = vim.g._johnc219.border_style
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = vim.g._johnc219.border_style
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = vim.g._johnc219.border_style
        }
      )
    end
  }
}
