vim.api.nvim_command("packadd packer.nvim")

-- Get `require` statement for corresponding config file
function get_config(name)
  return string.format('require("plugin_configs/%s")', name)
end

return require('packer').startup({
	function(use)
    use 'wbthomason/packer.nvim'  -- Manage itself

    use {
    	'dracula/vim',
    	as = 'dracula'
    	}

    use {
    	'neovim/nvim-lspconfig',
    	config = get_config('nvim-lspconfig')
    	}

		-- File explorer
    use {
    	'kyazdani42/nvim-tree.lua',
    	requires = 'kyazdani42/nvim-web-devicons',
    	config = get_config('nvim-tree')
	  }

	  -- Buffers git integration
		use {
  		'lewis6991/gitsigns.nvim',
  		config = get_config('gitsigns')
		}

		-- Status line
		use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  		config = get_config('lualine')
		}

		-- Tabline
		use {
  		'romgrk/barbar.nvim',
  		requires = {'kyazdani42/nvim-web-devicons'},
  		config = get_config('barbar')
		}

  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1,  -- Time in ms minimum to show in profile
    },
  },
})
