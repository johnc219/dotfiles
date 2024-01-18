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

-- [[ Variables ]]
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g._johnc219 = {
  border_style = "rounded"
}

-- [[ Options ]]
-- vim.opt.listchars:append({ leadmultispace = '│ ' })
vim.opt.breakindent = true                              -- wrapped line will continue visually indented
vim.opt.clipboard = "unnamedplus"                       -- Sync with system clipboard
vim.opt.colorcolumn = "81"
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- using nvim-cmp
vim.opt.cursorline = false
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true -- use spaces to insert a <Tab>
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true    -- show some invisible characters
vim.opt.number = true
vim.opt.pumheight = 10 -- maximum number of entries in a popup
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true }) -- Don't show welcome message
vim.opt.showmode = false               -- Don't show mode since we have a statusline
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = false -- remember undo history
vim.opt.virtualedit = "block"
vim.opt.wrap = false     -- line wrapping

-- [[ Config ]]
vim.diagnostic.config({
  underline = {
    severity = vim.diagnostic.severity.INFO
  },
  virtual_text = {
    severity = vim.diagnostic.severity.INFO
  },
  float = { border = vim.g._johnc219.border_style }
})

-- [[ Keymaps ]]
-- General
vim.keymap.set({ 'n', 'v', }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '<C-l>', '<del>', { desc = 'forward-delete character' })

-- Clipboard
vim.keymap.set('n', '<leader>\\', function()
  vim.fn.setreg('+', vim.fn.expand('%:~:.'))
end, { desc = 'Yank relative file path to system clipboard' })
vim.keymap.set('', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = '[W]indow' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Indentation
-- vim.keymap.set('v', '<', '<gv')
-- vim.keymap.set('v', '>', '>gv')

-- Window resizing
vim.keymap.set('n', '<C-Up>', "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set('n', '<C-Down>', "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set('n', '<C-Left>', "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set('n', '<C-Right>', "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines
vim.keymap.set('n', '<A-j>', "<cmd>m .+1<cr>==", { desc = "Move line down [normal]" })
vim.keymap.set('n', '<A-k>', "<cmd>m .-2<cr>==", { desc = "Move line up [normal]" })
vim.keymap.set('i', '<A-j>', "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down [insert]" })
vim.keymap.set('i', '<A-k>', "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up [insert]" })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = "Move line down [visual]" })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = "Move line up [visual]" })

vim.keymap.set({ 'i', 'n' }, '<Esc>', "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Search highlighting

-- [[ Autocommands ]]
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*'
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[%s/\s\+$//e]]
})

-- Set custom columns for git commit messages
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.colorcolumn = "51,73"
  end
})

-- Vertical help
vim.api.nvim_create_user_command(
  "Vhelp",
  function(opts)
    vim.api.nvim_cmd({
      cmd = "help",
      args = opts.fargs,
      mods = { vertical = true }
    }, {})
  end, {
    desc = "Open help in a vertical split",
    nargs = "?",
    complete = "help"
  }
)

-- Wrap and spell-check in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

-- [[ Plugins ]]
-- Setup lazy plugins; no icons
require("lazy").setup("plugins", {
  ui = {
    border = vim.g._johnc219.border_style,
    icons = {
      cmd = "[CMD]",
      config = "[CONFIG]",
      event = "[EVENT]",
      ft = "[FT]",
      init = "[INIT]",
      keys = "[KEYS]",
      plugin = "[PLUGIN]",
      runtime = "[RUNTIME]",
      require = "[REQUIRE]",
      source = "[SOURCE]",
      start = "[START]",
      task = "[TASK]",
      lazy = "[LAZY]",
    },
  },
})
