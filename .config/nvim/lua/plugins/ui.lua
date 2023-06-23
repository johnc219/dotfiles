return {
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          component_separators = '|',
          section_separators = '',
          globalstatus = true
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1,1) end }
          },
          lualine_x = {'filetype'}
        }
      })
    end
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    enabled = true,
    config = function ()
      require('neoscroll').setup()
    end
  }
}
