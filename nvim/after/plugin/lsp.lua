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

-- see :h diagnostic-handlers-example
local custom_diagnostics_namespace = vim.api.nvim_create_namespace('custom_diagnostics')
local original_signs_handler = vim.diagnostic.handlers.signs
vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
        local diagnostics = vim.diagnostic.get(bufnr)
        local max_severity_per_line = {}
        for _, diagnostic in pairs(diagnostics) do
            local max_diagnostic = max_severity_per_line[diagnostic.lnum]
            if not max_diagnostic or diagnostic.severity < max_diagnostic.severity then
                max_severity_per_line[diagnostic.lnum] = diagnostic
            end
        end

        local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
        original_signs_handler.show(custom_diagnostics_namespace, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
        original_signs_handler.hide(custom_diagnostics_namespace, bufnr)
    end,
}
