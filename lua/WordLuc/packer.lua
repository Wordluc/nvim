vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'mbbill/undotree'
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use {"Wordluc/FromC-ToTypeScript",branch="master"}
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('hrsh7th/nvim-cmp')
	use('L3MON4D3/LuaSnip')
	use('hrsh7th/cmp-nvim-lsp')
	use('folke/neodev.nvim') --for lsp vim
	use({ 'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end })
	-- file explorer
	use("nvim-tree/nvim-tree.lua")
	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")
	use {
		"ray-x/lsp_signature.nvim",
	}
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	use {
		"navarasu/onedark.nvim"
	}
	use { 'Exafunction/codeium.vim', tag="1.8.37"
	}
end)
