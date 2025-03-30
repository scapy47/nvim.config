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
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")
        end
    }
}
