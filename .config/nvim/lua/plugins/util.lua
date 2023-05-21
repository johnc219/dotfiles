return {
  -- Session manaagement
  {
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup({
        options = vim.opt.sessionoptions:get()
      })

      vim.keymap.set("n", "<leader>qc", function() require("persistence").load() end, { desc = '[Q]uit session [C]urrent dir' })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true}) end, { desc = '[Q]uit session [L]ast' })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "[Q]uit session [D]on't" })

      -- https://github.com/folke/persistence.nvim/issues/14
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gitcommit" },
        callback = function()
          require("persistence").stop()
        end
      })
    end
  }
}
