return {
  -- Using lazy.nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          diffview = true,
          fidget = true,
          mason = true,
        }
      })
      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    'echasnovski/mini.animate',
    version = false,
    enabled = false,
    config = function()
      require("mini.animate").setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          theme = 'catppuccin',
          -- component_separators = '|',
          -- section_separators = '',
          -- globalstatus = false,
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1, 3) end }
          },
          lualine_x = { 'filetype' }
        }
      })
    end
  },
}
