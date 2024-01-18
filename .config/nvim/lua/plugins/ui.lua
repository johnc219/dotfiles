return {
  -- Colorschemes
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        compile = true,
        dimInactive = true,
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
}
