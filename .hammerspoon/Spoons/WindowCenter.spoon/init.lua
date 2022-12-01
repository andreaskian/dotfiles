--- === WindowCenter ===
---
--- Center window management - a fork of Diego Zamboni's [http://www.hammerspoon.org/Spoons/WindowHalfsAndThirds.html](WindowHalfsAndThirds)
---
--- Download: To be added


local obj={}
obj.__index = obj

-- Metadata
obj.name = "WindowCenter"
obj.version = "0.1"
obj.author = "Andreas Kian <andreas@andreaskian.dk>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- WindowCenter.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('WindowCenter')

--- WindowCenter.defaultHotkeys
--- Variable
--- Table containing a sample set of hotkeys that can be
--- assigned to the different operations. These are not bound
--- by default - if you want to use them you have to call:
--- `spoon.WindowCenter:bindHotkeys(spoon.WindowCenter.defaultHotkeys)`
--- after loading the spoon. Value:
--- ```
---  {
---     center_center = { {"cmd", "shift"}, "c" },
---  }
--- ```
obj.defaultHotkeys = {
   center_center = { { "cmd", "shift"}, "c" },
}

--- WindowCenter.clear_cache_after_seconds
obj.clear_cache_after_seconds = 60

obj._window_state_name_to_rect = {
   center_center = {0.15,0.15,0.70,0.70}, -- two decimal places required for `window_state_rect_strings` to match
   center_third  = {0.166,0.00,0.666,1.00},
   center_half   = {0.20,0.00,0.50,1.00},
   center_66     = {0.333,0.00,0.333,1.00},
}
obj._window_state_rect_string_to_name = {}
for state,rect in pairs(obj._window_state_name_to_rect) do
   obj._window_state_rect_string_to_name[table.concat(rect,",")] = state
end
obj._window_moves = {
   center_center = {"center_center", center_center = "center_third", center_third = "center_half", center_half = "center_66"},
}

local function round(x, places)
   local places = places or 0
   local x = x * 10^places
   return (x + 0.5 - (x + 0.5) % 1) / 10^places
end

local function current_window_rect(win)
   local win = win or hs.window.focusedWindow()
   local ur, r = win:screen():toUnitRect(win:frame()), round
   return {r(ur.x,2), r(ur.y,2), r(ur.w,2), r(ur.h,2)} -- an hs.geometry.unitrect table
end

local function current_window_state_name(win)
   local win = win or hs.window.focusedWindow()
   return obj._window_state_rect_string_to_name[table.concat(current_window_rect(win),",")]
end

local function cacheWindow(win, move_to)
   local win = win or hs.window.focusedWindow()
   if (not win) or (not win:id()) then return end
   obj._frameCacheClearTimer:start()
   obj._lastMoveCache[win:id()] = move_to
   return win
end

function obj.resizeCurrentWindow(how)
   local win = hs.window.focusedWindow()
   if not win then return end

   local move_to = obj._lastMoveCache[win:id()] and obj._window_moves[how][obj._lastMoveCache[win:id()]] or
      obj._window_moves[how][current_window_state_name(win)] or obj._window_moves[how][1]
   if not move_to then
      obj.logger.e("I don't know how to move ".. how .." from ".. (obj._lastMoveCache[win:id()] or
         current_window_state_name(win)))
   end
   if current_window_state_name(win) == move_to then return end
   local move_to_rect = obj._window_state_name_to_rect[move_to]
   if not move_to_rect then
      obj.logger.e("I don't know how to move to ".. move_to)
      return
   end
   
   obj.logger.e("move to ".. move_to)
   cacheWindow(win, move_to)
   win:move(move_to_rect)
end

-- --------------------------------------------------------------------
-- Action functions for obj.resizeCurrentWindow, for the hotkeys
-- --------------------------------------------------------------------

--- WindowCenter:centerCenter(win)
--- Method
--- Resize to the center of the screen.
---
--- Parameters:
---  * win - hs.window to use, defaults to hs.window.focusedWindow()
---
--- Returns:
---  * the WindowCenter object
---
--- Notes:
---  * Variations of this method exist for other operations. See WindowCenter:bindHotkeys for details.

obj.centerCenter = hs.fnutils.partial(obj.resizeCurrentWindow, "center_center")

--- WindowCenter:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for WindowCenter
---
--- Parameters:
---  * mapping - A table containing hotkey objifier/key details for the following items:
---   * center_center - move window to center of screen
---
--- Returns:
---  * the WindowCenter object
function obj:bindHotkeys(mapping)
   local action_to_method_map = {
      center_center = self.centerCenter,
   }
   hs.spoons.bindHotkeysToSpec(action_to_method_map, mapping)
   return self
end

function obj:init()
   obj._lastMoveCache = {}
   self._frameCacheClearTimer = hs.timer.delayed.new(obj.clear_cache_after_seconds,
      function() obj._lastMoveCache = {} end)
end

return obj
