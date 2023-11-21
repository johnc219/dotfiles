return {
  -- Colorschemes
  {
    "ronisbr/nano-theme.nvim",
    lazy = true,
    config = function()
      vim.cmd [[colorscheme nano-theme]]
    end
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require('monokai-pro').setup {}
      vim.cmd [[colorscheme monokai-pro]]
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
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
          globalstatus = true,
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
