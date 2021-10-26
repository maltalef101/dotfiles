
require('config'):load()

require('keymappings')

local plugins = require('plugins')

if not plugins.packer_installed() then
	plugins.install_packer()
	plugins:load()
else
	plugins:load()
end

require('config.settings').colorscheme()

require('lsp').global_setup()

