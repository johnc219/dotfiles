-- bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.shortmess:append({ I = true })
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = { 'menuone', 'noselect' }

vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
vim.keymap.set({ 'n', 'v', }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '<C-l>', '<Del>', { desc = 'Forward-delete character' })
vim.keymap.set('', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>\\', '<cmd>let @+ = @%<CR>', { silent = true, desc = 'Copy file path' })

-- Strip trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[%s/\s\+$//e]]
})

-- Set custom columns for git commit messages.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "COMMIT_EDITMSG",
  callback = function()
    vim.opt_local.colorcolumn = "50,72"
  end
})

require("lazy").setup("plugins")
