Plug 'kyazdani42/nvim-web-devicons'  " File icons
Plug 'kyazdani42/nvim-tree.lua'

let g:nvim_tree_indent_markers = 1  " Shows indent markers when folders are open
let g:nvim_tree_git_hl = 0  " File highlight for git attributes
let g:nvim_tree_highlight_opened_files = 1  " Folder and file icon highlight for opened files/directories.
let g:nvim_tree_add_trailing = 1  " Append a trailing slash to folder names
let g:nvim_tree_group_empty = 1  " Compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_refresh_wait = 1000  " How often the tree refreshes in ms

" List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <leader>f :NvimTreeFindFileToggle<CR>

function NvimTreeInit()
lua << EOF
require'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {}
	},
	system_open = {
		cmd = nil,
		args = {}
	},
	filters = {
		dotfiles = false,
		custom = {}
	},
	git = {
		enable = false,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 35,
		height = 30,
		hide_root_folder = false,
		side = 'left',
		auto_resize = true,
		mappings = {
			custom_only = false,
			list = {}
		},
		number = false,
		relativenumber = false,
		signcolumn = "no"
	},
	trash = {
		cmd = "trash",
		require_confirm = true
	}
}
EOF
endfunction

augroup NvimTreeInit
	autocmd!
	autocmd User PlugLoaded call NvimTreeInit()
augroup END

