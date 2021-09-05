local Log = require('core.log')

local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
	Log:get_default().error "Failed to load plugin"
end

autopairs.setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
})

if packer_plugins['nvim-compe'].loaded then
	require('nvim-autopairs.completion.compe').setup({
		map_cr = true,
		map_complete = true,
		auto_select = false,
	})
end
