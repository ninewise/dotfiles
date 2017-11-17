-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-word')
require('plugins/myfiletype')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set expandtab on')
	vis:command('set show-tabs on')
	vis:command('set number')
	vis:command('set theme dark-16')
	vis:command('set escdelay 0')
end)

vis:command_register("fzf", function(argv, force, cur_win, selection, range)
	local old = cur_win
	local out = io.popen("fzf"):read()
	if out then
		vis:command(string.format('open %s', out))
		if argv[1] then
			old:close(force)
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
