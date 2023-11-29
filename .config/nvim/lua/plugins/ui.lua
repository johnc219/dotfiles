return {
  -- Colorschemes
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme nordic]]
    end
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme onedarkpro]]
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme solarized-osaka]]
    end
  },
  {
    "rose-pine/neovim",
    lazy = true,
    priority = 1000,
    config = function ()
      vim.cmd [[colorscheme rose-pine]]
    end
  },
  {
    "ronisbr/nano-theme.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme nano-theme]]
    end
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('monokai-pro').setup {
        filter = "octagon",
        background_clear = {
          "float_win",
          "telescope"
        },
        override = function (c)
          return {
            ["@text.reference"] = { fg = c.base.red },
            helpHyperTextJump = { fg = c.base.red }
          }
        end
      }
      vim.cmd [[colorscheme monokai-pro]]
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        compile = true,
        background = {
          dark = "dragon",
          light = "lotus"
        }
      })
      vim.cmd [[colorscheme kanagawa]]
    end
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          component_separators = '|',
          section_separators = '',
          globalstatus = false,
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1, 1) end }
          },
          lualine_x = { 'filetype' }
        }
      })
    end
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    enabled = false,
    config = function()
      require('neoscroll').setup()
    end
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    config = function()
      require('ibl').setup({
        indent = { char = '│', smart_indent_cap = true }
      })
      local hooks = require "ibl.hooks"
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )
    end
  }
}
