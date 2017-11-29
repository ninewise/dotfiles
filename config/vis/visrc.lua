-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-word')
require('plugins/myfiletype')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set expandtab on')
	vis:command('set show-tabs on')
	vis:command('set number')
	vis:command('set theme dark-16')
	vis:command('set escdelay 0')
end)

vis:command_register("fzf", function(argv, force, cur_win, selection, range)
	local out = io.popen("fzf"):read()
	--local out = io.popen("fzf " .. table.concat(argv, " ")):read()
	if out then
		if argv[1] then
			vis:command(string.format('e %s', out))
			-- or vis:command(string.format('open %s', out))
			-- should e return false when failed
		else
			vis:command(string.format('open %s', out))
		end
		vis:feedkeys("<vis-redraw>")
	end
end)

vis:map(vis.modes.NORMAL, ";l", function()
	vis:command('fzf')
end)

vis:map(vis.modes.NORMAL, ";o", function()
	vis:command('fzf true')
end)

vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")
