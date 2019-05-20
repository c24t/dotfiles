hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hello World", informativeText="Hammerspoon is running"}):send()
end)

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
--   local win = hs.window.focusedWindow()
--   win:centerOnScreen()
-- end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = 0
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
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

-- SCROLL ON MIDDLE-CLICK DRAG
-- https://github.com/tekezo/Karabiner/issues/814#issuecomment-281422447
local oldmousepos = {}
local scrollmult = -2

-- The were all events logged, when using `{"all"}`
mousetap = hs.eventtap.new({0,3,5,14,25,26,27}, function(e)
	oldmousepos = hs.mouse.getAbsolutePosition()
	local mods = hs.eventtap.checkKeyboardModifiers()
	local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
	local shouldScroll = 2 == pressedMouseButton
	if shouldScroll then
		local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
		local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
		local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
		local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
		scroll:post()
		hs.mouse.setAbsolutePosition(oldmousepos)
		return true, {scroll}
	else
		return false, {}
	end
end)
mousetap:start()
