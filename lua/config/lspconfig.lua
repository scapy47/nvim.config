local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require("cmp_nvim_lsp")
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local function on_attach(client, bufnr)
end


lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('bufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format { bufnr = args.buf, id = client.id }
                end
            })
        end
    end
})
