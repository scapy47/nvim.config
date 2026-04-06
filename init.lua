-------------------------------
--- Global variables
-------------------------------

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Nerd font icons
vim.g.have_nerd_font = true

-------------------------------
--- Options
-------------------------------

-- line numbers
vim.opt.number = true
-- relative line number
vim.opt.relativenumber = true
-- showmode (already in statusline)
vim.opt.showmode = false
-- Line wrapping
vim.opt.wrap = true
-- prevent words splitting
vim.opt.linebreak = true
-- line break indicator
vim.opt.showbreak = "➥"
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- border
vim.opt.winborder = 'rounded'

-- Signcolumn (scale/line on the side)
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
-- background
vim.opt.background = "dark"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
    tab = '⇔ ',
    trail = '●',
    extends = '❱',
    precedes = '❰',
    nbsp = '␣'
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line cursor is on
vim.opt.cursorline = true

-- omnicompletion
vim.opt.completeopt = 'menuone,noselect,noinsert,longest,preview'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.schedule(function()
    -- Sync clipboard between OS and Neovim
    -- vim.opt.clipboard = 'unnamedplus'
end)

-- enable lua bitecode caching
vim.loader.enable()

-------------------------------
-- Diagnostic
-------------------------------

vim.diagnostic.config {
    signs = true,
    severity_sort = true,
    underline = true,
    float = {
        border = 'rounded',
        severity_sort = true,
        source = 'if_many',
    }
}

-------------------------------
-- Keymaps
-------------------------------
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

require("config.keymap").global()

-------------------------------
-- Plugins
-------------------------------

---convert short github links into full links
---@param str string
---@return string
local gh = function(str) return "https://github.com/" .. str end

vim.pack.add {
    gh "maxmx03/fluoromachine.nvim",
    gh "neovim/nvim-lspconfig",
    { src = gh "saghen/blink.cmp", version = vim.version.range("^1") },
}

---@type fluoromachine
require("fluoromachine").setup {
    glow = true,
    theme = "delta",
    transparent = true,
    overrides = {
        ['@comment'] = { italic = false },
        ['@constant'] = { italic = false },
        ['@constant.builtin'] = { italic = false },
        ['@constant.macro'] = { italic = false },
        ['@constructor'] = { italic = false },
        ['@function'] = { italic = false },
        ['@function.builtin'] = { italic = false },
        ['@function.macro'] = { italic = false },
        ['@keyword'] = { italic = false },
        ['@keyword.function'] = { italic = false },
        ['@keyword.operator'] = { italic = false },
        ['@keyword.return'] = { italic = false },
        ['@parameter'] = { italic = false },
        ['@string'] = { italic = false },
        ['@string.regex'] = { italic = false },
        ['@tag'] = { italic = false },
        ['@type'] = { italic = false },
        ['@type.definition'] = { italic = false },
        ['@variable'] = { italic = false },
        ['@variable.builtin'] = { italic = false },
    }
}
vim.cmd.colorscheme "fluoromachine"

vim.lsp.enable("lua_ls")

require("config.lspconfig")
require("blink.cmp").setup({})

-------------------------------
-- Autocommands
-------------------------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
