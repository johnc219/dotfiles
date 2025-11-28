return {
  -- LSP stuff
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      -- {
      --   'williamboman/mason.nvim',
      --   build = ":MasonUpdate" -- :MasonUpdate updates registry contents
      -- },
      -- 'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup({})
        end
      },
      { 'saghen/blink.cmp' }
    },
    config = function()
      -- mason-lspconfig requires that these setup functions are called in this
      -- order before setting up the servers.
      -- require('mason').setup({
      --   ui = {
      --     border = vim.g._johnc219.border_style
      --   }
      -- })
      -- require('mason-lspconfig').setup()

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

        -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- nmap('gD',
        --   function() require('telescope.builtin').lsp_definitions({ jump_type = "vsplit" }) end,
          -- '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        -- -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        -- nmap('<leader>s', require('telescope.builtin').lsp_document_symbols, 'document symbols')
        -- nmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

        -- See `:help K` for why this keymap
        -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        local format_buffer = function()
          vim.lsp.buf.format({ timeout_ms = 5000 })
        end
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          format_buffer()
        end, { desc = 'Format current buffer with LSP' })
        nmap('<leader>;', format_buffer, 'format buffer')

        local document_highlight = false
        nmap('<leader>h', function()
          if document_highlight then
            vim.lsp.buf.clear_references()
          else
            vim.lsp.buf.document_highlight()
          end

          document_highlight = not document_highlight
        end, '[D]ocument [H]ighlight')
      end

      -- Enable language servers. They will automatically be installed.
      --
      -- Add any additional override configuration in the following tables.
      -- They will be passed to the `settings` field of the server config.
      -- You must look up that documentation yourself.
      local servers = {
        -- lua_ls = {
        --   settings = {
        --     Lua = {
        --       runtime = {
        --         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        --         version = 'LuaJIT',
        --       },
        --       diagnostics = {
        --         -- Get the language server to recognize the `vim` global
        --         globals = { 'vim' },
        --       },
        --       workspace = {
        --         checkThirdParty = false,
        --       },
        --       -- Do not send telemetry data containing a randomized but unique identifier
        --       telemetry = {
        --         enable = false,
        --       },
        --       semantic = {
        --         enable = false
        --       }
        --     },
        --   },
        -- },
        ruby_lsp = {
          init_options = {
            formatter = "standard",
            linters = { "standard" }
          }
        },
        -- ts_ls = {},
        -- eslint = {}
      }

      local lspconfig = require('lspconfig')
      for server, config in pairs(servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `server.capabilities`, if you've defined it
        config.capabilities =
          require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
      -- nvim-cmp supports additional completion capabilities, so broadcast
      -- that to servers
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the above servers are installed
      -- local mason_lspconfig = require('mason-lspconfig')

      -- mason_lspconfig.setup({
      --   ensure_installed = vim.tbl_keys(servers)
      -- })

      -- mason_lspconfig.setup_handlers({
      --   function(server_name)
      --     local lsp_setup = vim.tbl_extend("error", {
      --       capabilities = capabilities,
      --       on_attach = on_attach,
      --     }, servers[server_name] or {})

      --     require('lspconfig')[server_name].setup(lsp_setup)
      --   end
      -- })

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
