require('config')

require('plugins')

require('lsp').config()

require('keymappings')

require('settings').load_options()
require('settings').disable_builtins()
