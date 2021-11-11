"\	'python': ['mypy'], " or pylint
let g:ale_linters = {
	\	'vim': ['vint'],
	\	'cpp': ['clang', 'cppcheck', 'clangtidy', 'clangcheck'],
	\	'c': ['clang', 'cppcheck', 'clangtidy', 'clangcheck'],
	\}

let g:ale_fixers = {
	\   '*': ['trim_whitespace'],
	\   'javascript': ['eslint'],
	\	'cpp': ['clangtidy'],
	\	'c': ['clangtidy'],
	\}

" Fix files on save
let g:ale_fix_on_save = 1

