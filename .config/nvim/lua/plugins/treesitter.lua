return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      { "RRethy/nvim-treesitter-endwise" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context" },
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
          'vimdoc',
          'yaml'
        },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<A-o>",
            node_incremental = "<A-o>",
            scope_incremental = "<C-s>",
            node_decremental = "<A-i>"
          }
        },

        -- endwise
        endwise = { enable = true },

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
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer"
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer"
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer"
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer"
            }
          }
        }
      })
    end
  }
}
