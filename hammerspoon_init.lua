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

local key_app_mapping = {
	{ "1", "Alacritty" },
	{ "2", "Safari" },
	{ "3", "Spotify" },
	{ "4", "Messages" },
	{ "5", "Obsidian" },
}

local function bind_key_to_launch_app(key, appName)
	local modifier = "cmd"
	hs.hotkey.bind({ modifier }, key, function()
		hs.application.launchOrFocus(appName)
	end)
end

for _, mapping in ipairs(key_app_mapping) do
	bind_key_to_launch_app(mapping[1], mapping[2])
end

-- Maximize window
hs.hotkey.bind({ "cmd", "shift" }, "K", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.x = screen_frame.x
	window_frame.y = screen_frame.y
	window:setFrame(window_frame)
	window_frame.w = screen_frame.w
	window_frame.h = screen_frame.h
	window:setFrame(window_frame)
end)

-- Set window to left half
hs.hotkey.bind({ "cmd", "shift" }, "H", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.w = screen_frame.w / 2
	window_frame.h = screen_frame.h
	window:setFrame(window_frame)
	window_frame.x = screen_frame.x
	window_frame.y = screen_frame.y
	window:setFrame(window_frame)
end)

-- Set window to right half
hs.hotkey.bind({ "cmd", "shift" }, "L", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.w = screen_frame.w / 2
	window_frame.h = screen_frame.h
	window:setFrame(window_frame)
	window_frame.x = screen_frame.w / 2
	window_frame.y = screen_frame.y
end)
