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
    config = function(_, opts)
      require('telescope').setup(opts)
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension('fzf')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = '[S]earch [C]ommand history' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG', function()
        builtin.live_grep({ additional_args = { '-w' } })
      end, { desc = '[S]earch by [G]rep with word boundaries' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>;', builtin.resume, { desc = 'Resume search' })
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

      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree [E]xplorer' })
      vim.keymap.set(
        'n',
        '<leader>E',
        '<cmd>NvimTreeFindFileToggle<CR>',
        { desc = 'Toggle file tree [E]xplorer and find file' }
      )
    end
  },

  -- Add indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_trailing_blankline_indent = false,
      }
    end
  },

  -- Keymap reminders
  {
    'folke/which-key.nvim',
    config = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 500
      require('which-key').setup({})
    end
  }
}
