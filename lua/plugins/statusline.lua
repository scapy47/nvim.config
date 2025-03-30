return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = vim.g.have_nerd_font,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' }
        },
        sections = {
            lualine_y = {
                {
                    'lsp_status',
                    icon = '',
                    symbols = {
                        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                        done = '✓',
                        separator = ' ',
                    },
                    ignore_lsp = {},
                }
            }
        }
    }
}
