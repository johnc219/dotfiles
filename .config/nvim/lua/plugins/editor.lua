return {
  -- (Un)comment
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup({
        pickers = {
          live_grep = {
            additional_args = { "--hidden" }
          },
          grep_string = {
            additional_args = { "--hidden" }
          }
        }
      })
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Find [B]uffers' })
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files'})
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
      vim.keymap.set('n', '<leader>sF', function()
        builtin.find_files({ hidden = true })
      end, { desc = '[s]earch [f]iles (hidden true)' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
      vim.keymap.set('n', '<leader>sG', function()
        builtin.live_grep({ additional_args = { '-w', '--hidden' } })
      end, { desc = '[s]earch by [G]rep with word boundaries' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
      vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[s]earch [t]reesitter' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
      vim.keymap.set('n', "<leader>'", builtin.resume, { desc = 'Resume search' })
    end
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- File explorer tree
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    config = function()
      require("nvim-tree").setup({
        renderer = {
          indent_markers = {
            enable = true
          },
          icons = {
            show = {
              file = false,
              folder = false
            }
          }
        }
      })

      vim.keymap.set(
        'n',
        '<leader>e',
        '<cmd>NvimTreeToggle<CR>',
        { desc = 'Toggle file tree [E]xplorer' }
      )
      vim.keymap.set(
        'n',
        '<leader>E',
        '<cmd>NvimTreeFindFileToggle<CR>',
        { desc = 'Toggle file tree [E]xplorer and find file' }
      )
    end
  },

  -- Keymap reminders
  {
    'folke/which-key.nvim',
    enabled = false,
    config = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 500
      require('which-key').setup({})
    end
  }
}
