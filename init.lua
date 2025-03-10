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
vim.opt.showbreak = "↪"
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Signcolumn (scale/line on the side)
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣'
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.schedule(function()
    -- Sync clipboard between OS and Neovim
    --vim.opt.clipboard = 'unnamedplus'
end)

-------------------------------
-- Basic Keymaps
-------------------------------

-------------------------------
-- Install plugins & packages
-------------------------------

-- [[ `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath
    }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ lazy.nvim and plugins setup ]]
require('lazy').setup({

    ---- [[ plugins ]] ----

    'tpope/vim-sleuth',

    -- PERF: Theme
    {
        "scottmckendry/cyberdream.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "cyberdream"
        end,
    },
    {
        "catppuccin/nvim",
        name = 'catppuccin',
        priority = 1000,
        enabled = true,
        lazy = false,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- PERF: Icons
    { 'nvim-tree/nvim-web-devicons', lazy = true },

    -- PERF: Highlight comments
    {
        "folke/todo-comments.nvim",
        event = 'VimEnter',
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = true }
    },

    -- PERF: Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = 'InsertEnter',
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",

            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp"
            },
            "saadparwaiz1/cmp_luasnip"
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                mapping = cmp.mapping.preset.insert {

                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer",  keyword_length = 4 },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = 'luasnip' }
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
            }
        end,
    },

    -- PERF: Syntex highlights and other
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
            rainbow = {
                enable = true,
            },
        },
    },

    -- PERF: LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                dependencies = {
                    'williamboman/mason-lspconfig.nvim',
                    'WhoIsSethDaniel/mason-tool-installer.nvim'
                },
                opts = {}
            },
            {
                'j-hui/fidget.nvim',
                opts = {
                    notification = {
                        window = {
                            winblend = 40,
                            border = "rounded",
                        },
                    }
                }
            },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    }
                }
            }
        },
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup {}

            require "config.lspconfig"
        end
    },

    -- NOTE: Game for practice
    {
        "ThePrimeagen/vim-be-good",
        cmd = { "VimBeGood" }
    },

    -- PERF: import other plugins form lua/plugins dir
    { import = "plugins" },

    ---- [[ config ]] ----
    checker = {
        enabled = true,
        frequency = 21600, -- check every 6hr
        auto_install = true,
    }
})

-- require("lazy").update({ show = true })

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
