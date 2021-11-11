"\	'python': ['mypy'], " or pylint
let g:ale_linters = {
	\	'vim': ['vint'],
	\	'cpp': ['clang'],
	\	'c': ['clang']
	\}

let g:ale_fixers = {
	\   '*': ['trim_whitespace'],
	\   'javascript': ['eslint'],
	\	'cpp': ['clang'],
	\	'c': ['clang']
	\}

" Fix files on save
let g:ale_fix_on_save = 1

