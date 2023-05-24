return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      { "RRethy/nvim-treesitter-endwise", enabled = true },
      { "nvim-treesitter/nvim-treesitter-textobjects" }
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- core
        ensure_installed = {
          'javascript',
          'lua',
          'ruby',
          'rust',
          'tsx',
          'typescript',
          'vimdoc'
        },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = "<C-s>",
            node_decremental = "<M-Space>"
          }
        },

        -- endwise
        -- endwise = { enable = true },

        -- textobjects
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjecs.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner"
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner"
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner"
            }
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer"
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer"
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer"
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer"
            }
          }
        }
      })
    end
  }
}
