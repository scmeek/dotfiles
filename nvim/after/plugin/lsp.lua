vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = {
            severity_limit = 'Warning',
        },
        underline = true,
        virtual_text = false,
        update_in_insert = false,
    }
)
