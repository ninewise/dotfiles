-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-word')
require('plugins/myfiletype')
require('editorconfig/editorconfig')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set escdelay 0')
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set theme dark-16')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options
	vis:command('set show-tabs on')
	vis:command('set number')
end)

vis:command_register("fzf", function(argv, force, cur_win, selection, range)
	local out = io.popen("fzf"):read()
	--local out = io.popen("fzf " .. table.concat(argv, " ")):read()
	if out then
		if argv[1] then
			vis:command(string.format('e "%s"', out))
			-- or vis:command(string.format('open %s', out))
			-- should e return false when failed
		else
			vis:command(string.format('open "%s"', out))
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

interactives = {
	["python"] = "!python -i $vis_filename",
	["haskell"] = "!stack ghci $vis_filepath",
	["lithaskell"] = "!stack ghci $vis_filepath",
}
vis:map(vis.modes.NORMAL, ";i", function()
	local command = interactives[vis.win.syntax]
	if command then
		vis:command(command)
	end
end)

vis:map(vis.modes.NORMAL, ";w", function()
	vis:command('set theme light-16')
end)

vis:map(vis.modes.NORMAL, ";b", function()
	vis:command('set theme dark-16')
end)
