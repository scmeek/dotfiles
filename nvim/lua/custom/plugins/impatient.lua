-- Improve startup time by caching lua modules
return {
	'lewis6991/impatient.nvim',
	config = function()
		require('impatient')
	end,
}
