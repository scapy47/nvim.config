local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require("cmp_nvim_lsp")
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local function on_attach(client, bufnr)
    --  PERF: Format on save
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('bufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end
        })
    end
end


lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
