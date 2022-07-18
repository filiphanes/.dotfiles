hs.hotkey.bind("option", "1", function()
	hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind("option", "2", function()
	hs.application.launchOrFocus("Alacritty")
end)

hs.hotkey.bind("option", "3", function()
	hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind("option", "4", function()
	hs.application.launchOrFocus("Signal")
end)

hs.hotkey.bind("option", "5", function()
	hs.application.launchOrFocus("Finder")
end)

-- TODO: toggle Caps Lock using Esc key without loop