return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
    version = "*"
  },
  -- Fuzzy finder
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   branch = '0.1.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --     {
  --       "nvim-telescope/telescope-live-grep-args.nvim",
  --       -- This will not install any breaking changes.
  --       -- For major updates, this must be adjusted manually.
  --       version = "^1.0.0",
  --     },
  --   },
  --   config = function()
  --     local lga_actions = require("telescope-live-grep-args.actions")

  --     require('telescope').setup({
  --       defaults = {
  --         layout_config = {
  --           prompt_position = "top"
  --         },
  --         sorting_strategy = "ascending"
  --       },
  --       pickers = {
  --         live_grep = {
  --           additional_args = { "--hidden" }
  --         },
  --         grep_string = {
  --           additional_args = { "--hidden" }
  --         },
  --         oldfiles = {
  --           cwd_only = true
  --         },
  --         buffers = {
  --           sort_mru = true, ignore_current_buffer = true
  --         }
  --       },
  --       extensions = {
  --         live_grep_args = {
  --           additional_args = { "--hidden" },
  --           auto_quoting = true, -- enable/disable auto-quoting
  --           -- define mappings, e.g.
  --           mappings = {         -- extend mappings
  --             i = {
  --               ["<C-k>"] = lga_actions.quote_prompt(),
  --               ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
  --             },
  --           },
  --           -- ... also accepts theme settings, for example:
  --           -- theme = "dropdown", -- use dropdown theme
  --           -- theme = { }, -- use own theme spec
  --           -- layout_config = { mirror=true }, -- mirror preview pane
  --         }
  --       }
  --     })
  --     -- To get fzf loaded and working with telescope, you need to call
  --     -- load_extension, somewhere after setup function:
  --     require('telescope').load_extension('fzf')
  --     require('telescope').load_extension('live_grep_args')

  --     local builtin = require('telescope.builtin')
  --     vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = 'recently opened files' })
  --     vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'existing buffers' })
  --     -- vim.keymap.set('n', '<leader>/', function()
  --     --   -- You can pass additional configuration to telescope to change theme, layout, etc.
  --     --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  --     --     winblend = 10,
  --     --     previewer = false,
  --     --   })
  --     -- end, { desc = 'Fuzzily search in current buffer' })

  --     -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  --     vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'git files' })
  --     vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'find files' })
  --     -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  --     local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
  --     vim.keymap.set("n", "<leader>l", live_grep_args_shortcuts.grep_word_under_cursor, { desc = 'grep word' })
  --     vim.keymap.set("v", "<leader>l", live_grep_args_shortcuts.grep_visual_selection, { desc = 'grep word (v)' })
  --     -- vim.keymap.set('n', '<leader>l', builtin.grep_string, { desc = 'lookup word' })
  --     vim.keymap.set('n', '<leader>L', require('telescope').extensions.live_grep_args.live_grep_args,
  --       { desc = 'live grep' })
  --     -- vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = 'search diagnostics' })
  --     vim.keymap.set('n', "<leader>'", builtin.resume, { desc = 'resume' })
  --     -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  --   end
  -- },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        numhl = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map({ 'n', 'v' }, ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = "Jump to next hunk" })

          map({ 'n', 'v' }, '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to previous hunk' })
        end
      })
      vim.keymap.set('', '<leader>tb', require('gitsigns').toggle_current_line_blame, { desc = 'toggle blame line' })
    end
  },
  {
    "sindrets/diffview.nvim",   -- optional - Diff integration
    config = function()
      require("diffview").setup({
        use_icons = false
      })
    end
  },
  {
    "linrongbin16/gitlinker.nvim",
    config = function()
      require('gitlinker').setup({})
      -- with lua api:

      -- browse
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gl",
        require("gitlinker").link,
        { silent = true, noremap = true, desc = "GitLink" }
      )
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gL",
        function()
          require("gitlinker").link({ action = require("gitlinker.actions").system })
        end,
        { silent = true, noremap = true, desc = "GitLink!" }
      )
      -- blame
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gb",
        function()
          require("gitlinker").link({ router_type = "blame" })
        end,
        { silent = true, noremap = true, desc = "GitLink blame" }
      )
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gB",
        function()
          require("gitlinker").link({
            router_type = "blame",
            action = require("gitlinker.actions").system,
          })
        end,
        { silent = true, noremap = true, desc = "GitLink! blame" }
      )
      -- default branch
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gd",
        function()
          require("gitlinker").link({ router_type = "default_branch" })
        end,
        { silent = true, noremap = true, desc = "GitLink default_branch" }
      )
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gD",
        function()
          require("gitlinker").link({
            router_type = "default_branch",
            action = require("gitlinker.actions").system,
          })
        end,
        { silent = true, noremap = true, desc = "GitLink! default_branch" }
      )
      -- default branch
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gc",
        function()
          require("gitlinker").link({ router_type = "current_branch" })
        end,
        { silent = true, noremap = true, desc = "GitLink current_branch" }
      )
      vim.keymap.set(
        { "n", 'v' },
        "<leader>gC",
        function()
          require("gitlinker").link({
            router_type = "current_branch",
            action = require("gitlinker.actions").system,
          })
        end,
        { silent = true, noremap = true, desc = "GitLink! current_branch" }
      )
    end
  },
  {
    'echasnovski/mini.misc',
    version = false,
    config = function()
      require('mini.misc').setup()
      vim.keymap.set('', '<leader>m', require('mini.misc').zoom, { desc = 'zoom buffer' })
    end
  },
  -- File explorer tree
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require('mini.files').setup({
        windows = {
          -- Whether to show preview of file/directory under cursor
          preview = false
        }
      })

      local minifiles_toggle = function()
        if not MiniFiles.close() then MiniFiles.open() end
      end

      local minifiles_open_current = function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end

      vim.keymap.set(
        'n',
        '<leader>/',
        minifiles_toggle,
        { desc = "Toggle explorer" }
      )

      vim.keymap.set(
        'n',
        '<leader>?',
        minifiles_open_current,
        { desc = "Show in explorer" }
      )
    end
  },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  --     { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
  --     { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
  --     { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  --   },
  -- },
  {
    'echasnovski/mini.clue',
    version = false,
    config = function()
      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- `[]` keys
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end
  },
}
