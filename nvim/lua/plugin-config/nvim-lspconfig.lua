-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>de', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = bufnr })
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { buffer = bufnr })
end

local servers = {
    'bashls',
    'clangd',
    'cssls', -- vscode-langservers-extracted
    'eslint', -- vscode-langservers-extracted
    'html', -- vscode-langservers-extracted
    'rust_analyzer',
    'pyright',
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
})
