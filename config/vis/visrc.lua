-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/complete-word')
require('plugins/myfiletype')

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

vis:map(vis.modes.NORMAL, ";i", function()
	if vis.win.syntax == "python" then
		vis:command("!python -i $vis_filename")
	end
end)

lines = nil
index = 1

vis:map(vis.modes.INSERT, "<Tab>", function()
	local win = vis.win
	local pos = win.selection.pos
	local word = win.file:content(win.file:text_object_word(pos - 1))
	if word:gsub("%s+", "") == "" then
		vis:insert("	")
		return pos+1
	end

	lines = {}
	local nlines = 0
	local handle = io.popen(string.format("cut -f1 tags | uniq | grep '^%s'", word))
	for line in handle:lines() do
		table.insert(lines, line)
		nlines = nlines + 1
	end

	if nlines == 0 then
		lines = nil
	end
end)
-- Rec
