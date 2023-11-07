local servers = {
	bashls = { filetypes = { "sh", "zsh" } },
	clangd = {},
	eslint = {
		autoFixOnSave = true,
		codeActionsOnSave = {
			enable = "true",
			mode = "all",
		},
		enable = true,
		format = { enable = true },
		lintTask = {
			enable = true,
		},
		onIgnoredFiles = "off",
		problems = {
			shortentoSingleLine = false,
		},
		validate = "on",
	},
	html = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = "Disable" },
			telemetry = { enable = false },
		},
	},
	pyright = {},
	rust_analyzer = {},
	sqlls = {},
	tsserver = {
		format = { enable = false },
	},
	vimls = {},
	yamlls = {},
}

local servers_additional_settings = {}
servers_additional_settings.arduino_language_server = function()
	local arduino_cli_config_file = os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml"
	local arduino_cli_config_file_handler = io.open(arduino_cli_config_file, "r")
	if arduino_cli_config_file_handler ~= nil then
		arduino_cli_config_file_handler:close()
		return {
			cmd = {
				"arduino-language-server",
				"-cli-config",
				arduino_cli_config_file,
				"-cli",
				"arduino-cli",
				"-clangd",
				"clangd",
				"-fqbn",
				"arduino:avr:uno",
			},
		}
	else
		print(
			"WARN: Missing arduino-cli configuration file while configuring "
			.. "arduino-language-server ("
			.. arduino_cli_config_file
			.. ")"
		)
		return nil
	end
end

servers_additional_settings.rust_analyzer = function()
	local rust_analyzer_config_file = vim.fn.getcwd() .. "/.rust-analyzer.json"
	local rust_analyzer_config_file_handler = io.open(rust_analyzer_config_file, "r")
	if rust_analyzer_config_file_handler ~= nil then
		local config_json = rust_analyzer_config_file_handler:read("*a")
		rust_analyzer_config_file_handler:close()
		local config = vim.json.decode(config_json) or nil
		if config ~= nil then
			return {
				settings = {
					["rust-analyzer"] = config,
				},
			}
		end
	end
end

servers_additional_settings.tsserver = function()
	return {
		commands = {
			OrganizeImports = {
				function()
					vim.lsp.buf.execute_command({
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
					})
				end,
				description = "Organize Imports",
			},
		},
	}
end

local on_attach = function(client, bufnr)
	local set_lsp_keymap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	set_lsp_keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	set_lsp_keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	set_lsp_keymap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	set_lsp_keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	set_lsp_keymap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	set_lsp_keymap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	set_lsp_keymap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	set_lsp_keymap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	set_lsp_keymap("K", vim.lsp.buf.hover, "Hover Documentation")
	set_lsp_keymap("<leader>sd", vim.lsp.buf.signature_help, "[S]ignature [D]ocumentation")

	set_lsp_keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	set_lsp_keymap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	set_lsp_keymap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	set_lsp_keymap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
		"folke/neodev.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		require("neodev").setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			setup_jsonls = true,
			pathStrict = true,
		})
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				local server_settings = {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}

				local server_additional_settings = servers_additional_settings[server_name]
						and servers_additional_settings[server_name]()
				if server_additional_settings ~= nil then
					for k, v in pairs(server_additional_settings) do
						server_settings[k] = v
					end
				end

				require("lspconfig")[server_name].setup(server_settings)
			end,
		})

		-- Switch for controlling whether you want autoformatting.
		--  Use :FormatToggle to toggle autoformatting on or off
		local format_is_enabled = true
		vim.api.nvim_create_user_command("FormatToggle", function()
			format_is_enabled = not format_is_enabled
			print("Setting autoformatting to: " .. tostring(format_is_enabled))
		end, {})

		-- Create an augroup that is used for managing our formatting autocmds.
		--  We need one augroup per client to make sure that multiple clients
		--  can attach to the same buffer without interfering with each other.
		local _augroups = {}
		local get_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = "lsp-format-" .. client.name
				local id = vim.api.nvim_create_augroup(group_name, { clear = true })
				_augroups[client.id] = id
			end

			return _augroups[client.id]
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
			-- This is where we attach the autoformatting for reasonable clients
			callback = function(args)
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local bufnr = args.buf

				if not client.server_capabilities.documentFormattingProvider then
					return
				end

				if client.name == "tsserver" then
					return
				end

				-- Create an autocmd that will run *before* we save the buffer.
				--  Run the formatting command for the LSP that has just attached.
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = get_augroup(client),
					buffer = bufnr,
					callback = function()
						if not format_is_enabled then
							return
						end
						vim.lsp.buf.format({
							async = false,
							filter = function(c)
								return c.id == client.id
							end,
						})
					end,
				})
			end,
		})
	end,
}
