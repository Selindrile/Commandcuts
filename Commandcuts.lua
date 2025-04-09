_addon.version = '1.0'
_addon.name = 'CommandCuts'
_addon.author = 'Selindrile'

require 'strings'
config = require 'config'

default_settings = {
	commands = S{'lua','gs','load','unload','cancel','find','exec'},
	block_non_commands = false,
}

settings = config.load('data\\settings.xml',default_settings)
config.save(settings)
setmetatable(settings,nil)
commands = settings.commands

windower.register_event('outgoing text',function(original,modified)
	local converted = windower.convert_auto_trans(original)
	if converted:startswith('/') then
		local potentialcommand = string.match(converted, "/(%S+)")
		if commands:contains(potentialcommand) then
			windower.send_command(original:sub(2))
			return true
		end
	else
		local potentialcommand = string.match(converted, "(%S+)")
		if commands:contains(potentialcommand) then
			windower.send_command(original)
			return true
		elseif settings.block_non_commands then
			windower.add_to_chat(123, "Commandcuts: Message didn't start with a /, blocking.")
			return true
		end
	end
end)