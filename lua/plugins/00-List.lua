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
    -- PERF: show color for hexcode and such
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {},
    },
    -- PERF: code screenshot
    {
        "ellisonleao/carbon-now.nvim",
        lazy = true,
        cmd = "CarbonNow",
        ---@param opts cn.ConfigSchema
        opts = {}
    }
}
