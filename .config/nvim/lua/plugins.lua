-- Check if packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then 
		execute('!git clone https://github.com/wbthomason/packer.nvim ' ..install_path)
		execute 'packadd packer.nvim'
end

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- nvim LSP
	use 'neovim/nvim-lspconfig'
	use 'kabouzeid/nvim-lspinstall'

	-- Language pack
	use 'sheerun/vim-polyglot'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'

	-- Telescope for fuzzy file-searching
	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim'}
	}

	-- Gruvbox !!1!11
	use 'gruvbox-community/gruvbox'

	-- Status bar/Tab bar/Buffer bar
	use 'vim-airline/vim-airline'

	-- Git related plugins
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'

	-- nerdfonts
	use 'lambdalisue/nerdfont.vim'

	-- fern
  use {
		'lambdalisue/fern.vim',
		requires = {'lambdalisue/fern-renderer-nerdfont.vim',
			'lambdalisue/fern-hijack.vim',
			'lambdalisue/fern-git-status.vim'}
	}
end)
