return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- LSP magic
	use 'neovim/nvim-lspconfig'

	-- Galaxyline
	use { 'glepnir/galaxyline.nvim',
		branch = 'main',
		config = function() require "core.galaxyline" end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	}

	use	{ 'kabouzeid/nvim-lspinstall',
		config = function() require('lspinstall').setup() end,
	}

	use { 'hrsh7th/nvim-compe',
		event = "InsertEnter",
		config = function() require('core.compe').setup() end,
		requires = {
			{
				'L3MON4D3/LuaSnip',
				event = "InsertEnter",
			},
			{
				'rafamadriz/friendly-snippets',
				event = "InsertCharPre",
			},
		},
	}

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		branch = '0.5-compat',
		config = function() require('core.treesitter') end,
		run = ':TSUpdate',
	}

	-- Telescope for fuzzy file-searching
	use { 'nvim-telescope/telescope.nvim',
		config = function() require('core.telescope').setup() end,
		requires = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim'
		},
	}

	-- Colorscheme and stuff
	use { '~/dev/gruvbox.nvim',
		requires =  'tjdevries/colorbuddy.nvim'
	}

	-- Git related plugins
	use 'tpope/vim-fugitive'
	use { 'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function() require('gitsigns').setup() end,
		event = 'BufRead',
	}

	-- nerdfonts
	use 'lambdalisue/nerdfont.vim'

	-- NvimTree
	use { 'kyazdani42/nvim-tree.lua',
		config = function() require('core.nvimtree').setup() end
	}

	-- indent-blankline
	use { "lukas-reineke/indent-blankline.nvim",
		event = 'BufRead',
		config = function() require('core.indent-blankline').setup() end,
	}

	-- autocomplete closing brackets and such
	use { 'windwp/nvim-autopairs',
		config = function() require('core.autopairs') end,
    requires = 'kyazdani42/nvim-web-devicons',
		after = "nvim-compe",
	}

	use { 'norcalli/nvim-colorizer.lua',
		config = function() require('core.colorizer') end,
	}

	use { 'romgrk/barbar.nvim',
    requires =  'kyazdani42/nvim-web-devicons',
	}

	use { 'terrortylor/nvim-comment',
		config = function() require('core.comment').setup() end
	}

end)
