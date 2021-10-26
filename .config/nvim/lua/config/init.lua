local M = {}

function M:load()
	require("config.def")

	local settings = require('config.settings')
	settings.load_options()
	settings.disable_builtins()
end

return M
