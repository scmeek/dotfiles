local key_app_mapping = {
	{ "1", "Wezterm" },
	{ "2", "Safari" },
	{ "3", "Spotify" },
	{ "4", "Messages" },
	{ "5", "Obsidian" },
}

hs.hotkey.bind({ "alt", "ctrl" }, "R", function()
	hs.reload()
end)

local function bind_key_to_launch_app(key, appName)
	local modifier = "cmd"
	hs.hotkey.bind({ modifier }, key, function()
		hs.application.launchOrFocus(appName)
	end)
end

for _, mapping in ipairs(key_app_mapping) do
	bind_key_to_launch_app(mapping[1], mapping[2])
end

local function set_frame(window, frame)
	local duration_seconds = 0.03
	-- window:setFrameWithWorkarounds(frame, duration_seconds)
	window:setFrame(frame, duration_seconds)
end

-- Maximize window
hs.hotkey.bind({ "cmd", "shift" }, "K", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.x = screen_frame.x
	window_frame.y = screen_frame.y
	window_frame.w = screen_frame.w
	window_frame.h = screen_frame.h
	set_frame(window, window_frame)
end)

-- Set window to left half
hs.hotkey.bind({ "cmd", "shift" }, "H", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.w = screen_frame.w / 2
	window_frame.h = screen_frame.h
	window_frame.x = screen_frame.x
	window_frame.y = screen_frame.y
	set_frame(window, window_frame)
end)

-- Set window to right half
hs.hotkey.bind({ "cmd", "shift" }, "L", function()
	local window = hs.window.focusedWindow()
	local window_frame = window:frame()
	local screen_frame = window:screen():frame()

	window_frame.w = screen_frame.w / 2
	window_frame.h = screen_frame.h
	window_frame.x = (screen_frame.x + window_frame.w)
	window_frame.y = screen_frame.y
	set_frame(window, window_frame)
end)

hs.alert.show("Hammerspoon config loaded")
