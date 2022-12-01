local pushkey = {"⌃", "⌘", "⌥"}
local divvy = {"⇧", "⌘"}

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", { hotkeys = "default" })
spoon.SpoonInstall:andUse("WindowHalfsAndThirds", { hotkeys = "default" })
spoon.SpoonInstall:andUse("WindowCenter", { hotkeys = "default" })

-- remove resize animations
hs.window.animationDuration = 0

-- zero margins
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

-- grid
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 4

hs.hotkey.bind(pushkey, "g", hs.grid.show)

-- custom 2:3 - alternative to ⇧ + ⌘ + 1
hs.hotkey.bind(pushkey, "t", function()
  local win = hs.window.focusedWindow()
  win:move({0,0,0.666,1})
end)

-- divvy bindings - old habits die hard
hs.hotkey.bind(divvy, "1", function()
  spoon.WindowHalfsAndThirds:leftHalf()
end)

hs.hotkey.bind(divvy, "2", function()
  spoon.WindowHalfsAndThirds:rightHalf()
end)

hs.alert("Hammerspoon loaded")