-- Reload config on ~/.hammerspoon/*.lua file change
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

local keyAppMapping = {
	{ "1", "Alacritty" },
	{ "2", "Safari" },
	{ "3", "Spotify" },
	{ "4", "Messages" },
	{ "5", "Obsidian" },
}

function bindKeyToLaunchApp(key, appName)
	local modifier = "cmd"
	hs.hotkey.bind({ modifier }, key, function()
		hs.application.launchOrFocus(appName)
	end)
end

for _, mapping in ipairs(keyAppMapping) do
	bindKeyToLaunchApp(mapping[1], mapping[2])
end

-- Maximize window
hs.hotkey.bind({ "cmd", "shift" }, "K", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end)

-- Set window to left half
hs.hotkey.bind({ "cmd", "shift" }, "H", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- Set window to right half
hs.hotkey.bind({ "cmd", "shift" }, "L", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.w / 2
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)
