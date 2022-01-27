hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", { hotkeys = 'default' })
spoon.SpoonInstall:andUse("WindowHalfsAndThirds", { hotkeys = 'default' })

-- remove resize animations
hs.window.animationDuration = 0

local pushkey = {"⌃", "⌘", "⌥"}
local divvy = {"⇧", "⌘"}

-- zero margins
hs.grid.MARGINX     = 0
hs.grid.MARGINY     = 0

-- grid
hs.grid.GRIDWIDTH   = 6
hs.grid.GRIDHEIGHT  = 1

hs.hotkey.bind(pushkey, "g", hs.grid.show)

-- center
hs.hotkey.bind(divvy, "c", function()
  local win = hs.window.focusedWindow()
  -- win:centerOnScreen()
  win:move({0.15,0.15,0.7,0.7})
end)

-- divvy bindings - old habits die hard
hs.hotkey.bind(divvy, "1", function()
  spoon.WindowHalfsAndThirds:leftHalf()
end)

hs.hotkey.bind(divvy, "2", function()
  spoon.WindowHalfsAndThirds:rightHalf()
end)

hs.alert("Hammerspoon loaded")