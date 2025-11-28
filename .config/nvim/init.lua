-- [[ Base Config (Kickstart) ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- For more ooptions, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
)

-- Enable break indent
vim.o.breakindent

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on my default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new slipts should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It it very similar to `vim.o` but offers and interface for conveniently interacting wth tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '.', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccomand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybind to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Personal Customizations ]]

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g._johnc219 = {
  border_style = "rounded"
}

-- [[ Options ]]

-- Set rulers
vim.opt.colorcolumn = "81,121"

-- Highlight text line and line number
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true -- use spaces to insert a <Tab>
vim.opt.inccommand = "nosplit"
vim.opt.fillchars:append { diff = " " }
vim.opt.pumheight = 10 -- maximum number of entries in a popup
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true }) -- Don't show welcome message
vim.opt.sidescrolloff = 5
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = false
vim.opt.ttimeout = false
vim.opt.virtualedit = "block"
vim.opt.wrap = false     -- line wrapping

-- [[ Config ]]
vim.diagnostic.config({
  -- underline = {
  --   severity = vim.diagnostic.severity.INFO
  -- },
  -- virtual_text = {
  --   severity = vim.diagnostic.severity.INFO
  -- },
  float = { border = vim.g._johnc219.border_style }
})

-- [[ Keymaps ]]
-- General
vim.keymap.set({ 'n', 'v', }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '<C-l>', '<del>', { desc = 'forward-delete character' })
vim.keymap.set('', '<C-u>', '<C-u>zz', { desc = 'scroll up' })
vim.keymap.set('', '<C-d>', '<C-d>zz', { desc = 'scroll down' })

-- Clipboard
vim.keymap.set('n', '<leader>\\', function()
  vim.fn.setreg('+', vim.fn.expand('%:~:.'))
end, { desc = 'Yank relative file path to system clipboard' })
-- vim.keymap.set('', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
-- vim.keymap.set('', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
-- vim.keymap.set('', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = '[W]indow' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Indentation
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('', '<leader>zj', '<C-e><leader>z', { remap = true } )
vim.keymap.set('', '<leader>zk', '<C-y><leader>z', { remap = true })
vim.keymap.set('', '<leader>zu', '<C-u><leader>z', { remap = true })
vim.keymap.set('', '<leader>zd', '<C-d><leader>z', { remap = true })

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

-- vim.keymap.set({ 'i', 'n' }, '<Esc>', "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
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
