local hyper = {"ctrl"}
local lastKey = ''
local browserWindowFilter = hs.window.filter.new("Firefox")
local browserSwitcher = hs.window.switcher.new(browserWindowFilter)
browserSwitcher.ui.showThumbnails = false
browserSwitcher.ui.showSelectedThumbnail = false

-- window movement --
-- move window to the right
hs.hotkey.bind({"ctrl", "shift"}, "L", function()
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

-- move window to the left
hs.hotkey.bind({"ctrl", "shift"}, "H", function()
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

-- maximize window
hs.hotkey.bind({"ctrl", "shift"}, "M", function()
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

-- focus windows --
-- ctrl+1
hs.hotkey.bind(hyper, "1", function()
    hs.application.launchOrFocus("Alacritty")
    -- hs.application.launchOrFocus("Microsoft Excel")
    lastKey = "1"
end)

-- ctrl+2
hs.hotkey.bind(hyper, "2", function()
    if lastKey == "2" then
        browserSwitcher:next()
    else
        -- hs.application.launchOrFocus("Google Chrome")
        hs.application.launchOrFocus("Firefox")
    end
    lastKey = "2"
end)

-- ctrl+3
hs.hotkey.bind(hyper, "3", function()
    hs.application.launchOrFocus("Slack")
    -- hs.application.launchOrFocus("Alacritty")
    lastKey = "3"
end)

-- ctrl+4
hs.hotkey.bind(hyper, "4", function()
    hs.application.launchOrFocus("Postman")
    -- hs.application.launchOrFocus("Microsoft Excel")
    lastKey = "4"
end)

-- ctrl+5
hs.hotkey.bind(hyper, "5", function()
    -- hs.application.launchOrFocus("Postman")
    hs.application.launchOrFocus("Docker Desktop")
    lastKey = "5"
end)

-- ctrl+6
hs.hotkey.bind(hyper, "6", function()
    hs.application.launchOrFocus("Mail Hypotheekbond")
    lastKey = "6"
end)

-- ctrl+7
hs.hotkey.bind(hyper, "7", function()
    hs.application.launchOrFocus("WhatsApp")
    lastKey = "7"
end)

-- ctrl+8
hs.hotkey.bind(hyper, "8", function()
    hs.application.launchOrFocus("TablePlus")
    lastKey = "8"
end)

-- ctrl+9
hs.hotkey.bind(hyper, "9", function()
    hs.application.launchOrFocus("Notion")
    lastKey = "9"
end)

-- ctrl+0
hs.hotkey.bind(hyper, "0", function()
    hs.application.launchOrFocus("TimeChimp Hypotheekbond")
    lastKey = "0"
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files) 
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end):start()
