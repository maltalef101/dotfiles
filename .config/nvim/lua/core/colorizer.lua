local Log = require('core.log')

local status_ok, colorizer = pcall(require, 'colorizer')
if not status_ok then
	Log:get_default().error "Failed to load plugin colorizer"
end

colorizer.setup(
	{'*';},
	{
		RGB = true;
		RRGGBB = true;
		RRGGBBAA = true;
		rgb_fn = true;
		hsl_fn = true;
		css = true;
		css_fn = true;
	}
)
