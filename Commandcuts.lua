_addon.version = '1.0'
_addon.name = 'Commandcuts'
_addon.author = 'Selindrile'

require 'strings'
config = require 'config'

default_settings = {
	commands = S{'lua','gs','load','unload','cancel'},
	block_non_commands = false,
}

settings = config.load('data\\settings.xml',default_settings)
config.save(settings)
setmetatable(settings,nil)
commands = settings.commands

windower.register_event('outgoing text',function(original,modified)
	if original:startswith('/') then
		if not original:startswith('//') then
			local potentialcommand = string.match(original, "/(%S+)")
			if commands[potentialcommand] then
				windower.send_command(original:sub(2))
				return true
			end
		end
	else
		local potentialcommand = string.match(original, "(%S+)")
		if commands[potentialcommand] then
			windower.send_command(original)
			return true
		elseif settings.block_non_commands then
			windower.add_to_chat(123, "Commandcuts: Message didn't start with a /, blocking.")
			return true
		end
	end
end)