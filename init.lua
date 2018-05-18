-- Hammerspoon config
-- TODO: Move this to a module 
-- Make iTerm visible (config to take full screen)
-- Press again to hide
hs.hotkey.bind({"ctrl"}, "return", function()
  toggle_app('iTerm')
end)

-- TODO: Move this to a module
-- Lock screen
hs.hotkey.bind({"ctrl"}, "L", function()
  hs.caffeinate.lockScreen()
end)

-- TODO: Move this to a module
hs.hotkey.bind({"ctrl", "shift"}, "K", function()
  hs.application.open("GitKraken")
end)

hs.hotkey.bind({"ctrl", "shift"}, "S", function()
  hs.application.open("Slack")
end)

hs.hotkey.bind({"ctrl", "shift"}, "I", function()
  hs.application.open("IntelliJ IDEA")
end)

hs.hotkey.bind({"ctrl", "shift"}, "P", function()
  hs.application.open("DBeaver")
end)

function toggle_app(name)
  focused = hs.window.focusedWindow()
  if focused then
    app = focused:application()
    if app:title() == name or app:title() == "iTerm2" then
      app:hide()
      return
    end
  end

  hs.application.launchOrFocus(name)
end
