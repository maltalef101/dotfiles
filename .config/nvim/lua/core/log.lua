local Log = {}

--- Creates a log handle based on Plenary.log
---@param opts these are passed verbatim to Plenary.log
---@return log handle
function Log:new(opts)
  local status_ok, plogger = pcall(require, "plenary.log")
  if not status_ok then
    return nil
  end

  local handle = plogger.new(opts)
  local path = string.format("%s/%s.log", vim.api.nvim_call_function("stdpath", { "cache" }), opts.plugin)

  handle.get_path = function()
    return path
  end

  return handle
end

--- Creates or retrieves a log handle for the default logfile
--- based on Plenary.log
---@return log handle
function Log:get_default()
  return Log:new { plugin = "mvim", level = mvim.log.level }
end

--- Logs to a file depending on plugin name
---@param name the plugin name
---@return a log handle with a custom name and default log level
function Log:log(name)
	return Log:new { plugin = name, level = mvim.log.level }
end


return Log
