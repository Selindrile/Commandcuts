_addon.version = '1.0'
_addon.name = 'Commandcuts'
_addon.author = 'Selindrile'

require 'strings'
config = require 'config'

default_commands = {
	commands = S{'lua','gs','load','unload','cancel'}
}

settings = config.load('data\\commands.xml',default_commands)
config.save(settings)
setmetatable(settings,nil)
commands = settings.commands

windower.register_event('outgoing text',function(original,modified)
	if original:startswith('/') and not original:startswith('//') then
		local potentialcommand = string.match(original, "/(%S+)")
		if commands[potentialcommand] then
			return '/'..original
		end
	end
end)