TERM = vim.fn.expand('$TERMINAL')
USER = vim.fn.expand('$USER')
HOME = vim.fn.expand('$HOME')
CACHE_PATH = vim.fn.stdpath('cache')
DATA_PATH = vim.fn.stdpath "data"

mvim = {
	lsp = {
		completion = {
			item_kind = {
				"   (Text) ",
        "   (Method)",
        "   (Function)",
        "   (Constructor)",
        " ﴲ  (Field)",
        "[] (Variable)",
        "   (Class)",
        " ﰮ  (Interface)",
        "   (Module)",
        " 襁 (Property)",
        "   (Unit)",
        "   (Value)",
        " 練 (Enum)",
        "   (Keyword)",
        "   (Snippet)",
        "   (Color)",
        "   (File)",
        "   (Reference)",
        "   (Folder)",
        "   (EnumMember)",
        " ﲀ  (Constant)",
        " ﳤ  (Struct)",
        "   (Event)",
        "   (Operator)",
        "   (TypeParameter)",
			},
		},
	},
	lang = {
		lua = {
			formatters = {
				{
					exe = "",
					args = {},
				},
			},
			linters = {},
			lsp = {
				provider = "sumneko_lua",
				setup = {
					cmd = {
						DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
						"-E",
						DATA_PATH .. "/lspinstall/lua/main.lua",
					},
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
								path = vim.split(package.path, ";"),
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { 'vim', 'mvim' },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = {
									[vim.fn.expand "$VIMRUNTIME/lua"] = true,
									[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
								},
								maxPreload = 100000,
								preloadFileSize = 1000,
							},
						}
					},
				},
			},
		},
	},
	treesitter = {
		ensure_installed = { 'lua' }, -- list of languages
		ignore_install = {}, -- list of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = false,
		},
	},
}

return mvim
