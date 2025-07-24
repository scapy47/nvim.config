return {
    -- PERF: Typing prectice
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        cmd = { "Typr", "TyprStats" },
        opts = {}
    },
    -- PERF: cursor animation
    {
        "sphamba/smear-cursor.nvim",
        enabled = false,
        event = 'VimEnter',
        opts = {}
    },
    -- PERF: platformio
    {
        "anurag3301/nvim-platformio.lua",
        dependencies = {
            { "akinsho/nvim-toggleterm.lua" },
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = {
            "Pioinit",
            "Piorun",
            "Piocmd",
            "Piolib",
            "Piomon",
            "Piodebug",
            "Piodb",
        },
        opts = {
            lsp = "clangd"
        }
    },
    -- PERF: notification
    {
        "folke/snacks.nvim",
        priority = 1000,
        opts = {
            notifier = {},
            indent = {},
            bigfile = {},
            -- scroll = {},
            dashboard = require "config.startup_screen"
        }
    },
    {
        "A7Lavinraj/fyler.nvim",
        branch = "stable",
        opts = {
            icon_provider = "nvim-web-devicons",
            views = {
                explorer = {
                    width = 0.45,
                    height = 0.8,
                    kind = "float",
                    border = "rounded",
                },
                confirm = {
                    width = 0.8,
                    height = 0.2,
                    kind = "float",
                    border = "rounded",
                },
            },
            mappings = {
                explorer = {
                    n = {
                        ["<Esc><Esc>"] = "CloseView",
                        ["<CR>"] = "Select",
                    }
                }
            }
        }
    }
}
