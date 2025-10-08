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

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w - f.w)
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

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = 0
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
-- TODO: don't suppress regular middle clicks! gah!
-- https://github.com/tekezo/Karabiner/issues/814#issuecomment-281422447
local oldmousepos = {}
local scrollmult = -2

---- The were all events logged, when using `{"all"}`
--mousetap = hs.eventtap.new({0,3,5,14,25,26,27}, function(e)
--  oldmousepos = hs.mouse.getAbsolutePosition()
--  local mods = hs.eventtap.checkKeyboardModifiers()
--  local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
--  local shouldScroll = 2 == pressedMouseButton
--  if shouldScroll then
--    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
--    local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
--    local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
--    --https://www.hammerspoon.org/docs/hs.eventtap.html#middleClick
--    --https://www.hammerspoon.org/docs/hs.eventtap.event.html
--    -- if dx == 0 and dy == 0 then
--    --   hs.eventtap.middleClick(oldmousepos)
--    --   return false, {}
--    -- else
--      local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
--      scroll:post()
--      hs.mouse.setAbsolutePosition(oldmousepos)
--      return true, {scroll}
--    -- end
--  else
--    return false, {}
--  end
--end)

mousetap = hs.eventtap.new(
  {
    hs.eventtap.event.types.otherMouseDown,   -- 25
    hs.eventtap.event.types.otherMouseUp,     -- 26
    hs.eventtap.event.types.otherMouseDragged -- 27
  },
  function(e)

    -- 1. If this event has our custom tag, ignore it to avoid re-processing
    if e:getProperty(hs.eventtap.event.properties.eventSourceUserData) == MY_EVENT_TAG then
      return false
    end

    local eventType = e:getType()
    local button = e:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    local oldmousepos = hs.mouse.absolutePosition()

    -- We only care about the middle mouse button
    if button ~= 2 then
      return false
    end

    if eventType == hs.eventtap.event.types.otherMouseDown then
      -- Swallow this event and mark that we might do a middle click
      scrolling = false
      middleDown = true
      return true, {}  -- don't pass it on

    elseif eventType == hs.eventtap.event.types.otherMouseDragged then
      if middleDown then
        -- The user is moving/dragging while the middle button is down => scroll
        scrolling = true

        local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
        local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
        local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult}, {}, 'pixel')
        scroll:post()
        hs.mouse.absolutePosition(oldmousepos) -- keep cursor locked
        return true, {scroll}
      end
      return false, {}

    elseif eventType == hs.eventtap.event.types.otherMouseUp then
      if middleDown then
        if scrolling then
          -- We were scrolling, so just stop scrolling
          scrolling = false
          middleDown = false
          return true, {}
        else
          -- No scroll occurred, so treat it like a normal middle click
          middleDown = false
          local pos = hs.mouse.absolutePosition()
          local clickDown = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.otherMouseDown, pos)
          local clickUp   = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.otherMouseUp, pos)

          -- Tag them so we skip them in the callback
          clickDown:setProperty(hs.eventtap.event.properties.mouseEventButtonNumber, 1)
          clickUp:setProperty(hs.eventtap.event.properties.eventSourceUserData, MY_EVENT_TAG)
          clickUp:setProperty(hs.eventtap.event.properties.mouseEventButtonNumber, 1)
          clickUp:setProperty(hs.eventtap.event.properties.eventSourceUserData, MY_EVENT_TAG)

          clickDown:post()
          clickUp:post()
          return true, {}
        end
      end
      return false, {}
    end
  end
)
mousetap:start()
