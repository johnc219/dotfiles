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
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<A-space>"
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
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer"
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer"
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer"
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer"
            }
          },
          lsp_interop = {
            enable = true,
            floating_preview_opts = { border = vim.g._johnc219.border_style },
            peek_definition_code = {
              ["<leader>tf"] = "@function.outer",
              ["<leader>tF"] = "@class.outer"
            },
          }
        }
      })
    end
  }
}
