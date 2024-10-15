require('inputsource_aurora')

-- 앱 실행
function open(app)
  return function()
    hs.application.launchOrFocus(app)
  end
end

-- 출력 장치 변경
function change_output_device() 
  local currentOutputDevice = hs.audiodevice.defaultOutputDevice()

  local devices = hs.audiodevice.allOutputDevices()
  local index = 0
  for i = 0, #devices do
    if devices[i] ~= nil and devices[i]:uid() == currentOutputDevice:uid() then
      index = i
      break
    end
  end

  while true do
    device = devices[(index % #devices) + 1]
    if device == nil or device:transportType() == nil then
      index = index + 1
    else
      break
    end
  end
  
  hs.alert(device:name())
  device:setDefaultOutputDevice()
end

-- 입력 장치 변경
function change_input_device() 
  local currentInputDevice = hs.audiodevice.defaultInputDevice()

  local devices = hs.audiodevice.allInputDevices()
  local index = 0
  for i = 0, #devices do
    if devices[i] ~= nil and devices[i]:uid() == currentInputDevice:uid() then
      index = i
      break
    end
  end

  while true do
    device = devices[(index % #devices) + 1]
    if device == nil or device:transportType() == nil then
      index = index + 1
    else
      break
    end
  end
  
  hs.alert(device:name())
  device:setDefaultInputDevice()
end

-- 화면 잠그기
function lock_screen() 
  hs.caffeinate.systemSleep()
end

-- 화면 왼쪽 절반으로 변경
function window_left()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- 화면 오른쪽 절반으로 변경
function window_right()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- 화면 전체 화면으로 변경
function window_full()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end

function mirrorStop()
  local screen = hs.screen.mainScreen()

  screen:mirrorStop();
end

function mirrorStart()
  local screens = hs.screen.allScreens()
  if #screens < 2 then
    return
  end

  local mainScreen = hs.screen.mainScreen()

  hs.alert(screens[2])

  mainScreen:mirrorOf(screens[2])
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'd', open("Discord"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'k', open("KakaoTalk"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'c', open("Google Chrome"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'b', open("Obsidian"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 't', open("Terminal"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'f', open("Finder"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'n', open("Notion"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'v', open("Visual Studio Code"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'e', open("IntelliJ IDEA"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'l', open("LINE"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'g', open("ChatGPT"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'w', open("Google Chat"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'p', open("Postman"))
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'o', change_output_device)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'i', change_input_device)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'escape', lock_screen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", window_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", window_right)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", window_full)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", mirrorStart)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "]", mirrorStop)

-- 해머스푼 설정 리로딩 단축키
hs.hotkey.bind({'option', 'cmd'}, 'r', function() hs.reload() end)

hs.window.animationDuration = 0
