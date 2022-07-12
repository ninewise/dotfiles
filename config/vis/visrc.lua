-- load standard vis module, providing parts of the Lua API

-- get inspiration from: https://src.adamsgaard.dk/dotfiles/file/.config/vis/visrc.lua.html

require('vis')
require('plugins/complete-word')
require('plugins/myfiletype')
require('plugins/editorconfig/editorconfig')

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

vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")

--------------------------------------------------------------------------------
-- Escape removes counts

vis:map(vis.modes.NORMAL, "<Escape>", function()
	if vis.count then
		vis.count = nil
	else
		vis:feedkeys("<vis-selections-remove-all>")
	end
end)

--------------------------------------------------------------------------------
-- Fuzzy search filenames to open files

vis:command_register("skim", function(argv, force, cur_win, selection, range)
	local out = io.popen("sk"):read()
	if out then
		vis:command(string.format(argv[1]..' "%s"', out))
		vis:feedkeys("<vis-redraw>")
	end
end, 'fuzzy file search')

vis:map(vis.modes.NORMAL, ";l", function()
	vis:command('skim open')
end)

vis:map(vis.modes.NORMAL, ";o", function()
	vis:command('skim e')
end)

vis:map(vis.modes.NORMAL, ";v", function()
	vis:command('skim vsplit')
end)

--------------------------------------------------------------------------------
-- Fuzzy search lines to copy them

vis:map(vis.modes.NORMAL, ";r", function()
	local choice = io.popen('tac < ' .. vis.win.file.path .. ' | uniq | sk'):read()
	if choice then
		local line = vis.win.selection.line
		table.insert(vis.win.file.lines, line + 1, choice)
		vis.win.selection:to(line + 1, 0)
	end
	vis:feedkeys("<vis-redraw>f€l")
end, 'fuzzy line copy')

--------------------------------------------------------------------------------
-- Fuzzy search lines to open files

vis:command_register("rg", function(argv, force, cur_win, selection, range)
	local out = io.popen("sk --ansi -i -c 'rg --color=always --line-number "..'"{}"'.."'"):read()
	if out then
		local filename = string.find(out, ':')
		local linenumber = string.find(out, ':', filename + 1)
		vis:command(string.format(argv[1]..' "%s"', string.sub(out, 0, filename - 1)))
		vis.win.selection:to(tonumber(string.sub(out, filename + 1, linenumber - 1)), 0)
		vis:feedkeys("<vis-redraw>")
	end
end, 'fuzzy grep open')

vis:map(vis.modes.NORMAL, ";g", function()
	vis:command('rg open')
end)

vis:map(vis.modes.NORMAL, ";G", function()
	vis:command('rg e')
end)

--------------------------------------------------------------------------------
-- Some interactive programs

interactives = {
	["python"] = "!python -i ",
	["haskell"] = "!stack ghci ",
	["lithaskell"] = "!stack ghci ",
	["latex"] = "!tectonic ",
	["lua"] = "!luajit -i ",
}

vis:map(vis.modes.NORMAL, ";i", function()
	local command = interactives[vis.win.syntax]
	if command then
		vis:command(command.."'"..vis.win.file.name.."'")
	end
end)

vis:map(vis.modes.NORMAL, ";s", function()
	vis:command("!sent '"..vis.win.file.path.."'")
end)

--------------------------------------------------------------------------------
-- Swap between light and dark themes

vis:map(vis.modes.NORMAL, ";w", function()
	vis:command('set theme light-16')
end)

vis:map(vis.modes.NORMAL, ";b", function()
	vis:command('set theme dark-16')
end)

--------------------------------------------------------------------------------
-- Backspace removes 4 spaces if need be

vis:map(vis.modes.INSERT, '<Backspace>', function()
	local tabwidth = 4
	local single_selection = false
	for selection in vis.win:selections_iterator() do
		if single_selection then
			single_selection = false
			break
		end
		single_selection = true
	end

	local to_stop = (vis.win.selection.col - 1) % tabwidth
	if to_stop == 0 then
		to_stop = tabwidth
	end

	if single_selection and to_stop > 1 and vis.win.file:content(vis.win.selection.pos - to_stop, to_stop) == string.rep(' ', to_stop) then
		vis:feedkeys(string.rep('<vis-delete-char-prev>', to_stop))
	else
		vis:feedkeys('<vis-delete-char-prev>')
	end
end)

--------------------------------------------------------------------------------
-- Hardwrapping

vis:map(vis.modes.VISUAL, ';a', function()
	if vis.count then
		vis:command(string.format(':|par %d', vis.count))
		vis.count = nil
	else
		vis:command(':|par')
	end
end)

vis:map(vis.modes.NORMAL, ';a', function()
	if vis.count then
		vis:command(string.format(':1,$|mreflow %d', vis.count))
		vis.count = nil
	else
		vis:command(':1,$|mreflow')
	end
end)

--------------------------------------------------------------------------------
-- Strip trailing spaces

vis:command_register("sts", function(argv, force, win, selection, range)
	local lines = win.file.lines
	for index=1, #lines do
		lines[index] = lines[index]:gsub("%s+$", "")
	end
	return true
end, "Strip line trailing spaces")
