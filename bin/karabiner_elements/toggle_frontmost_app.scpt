on run argv
  --set argv to {"Microsoft Edge"}
  if (count of argv) is 0 then
    --display dialog "No arguments provided." buttons {"OK"} default button "OK"
    return
  end if
  set appName to item 1 of argv
  set res to process(appName) of me
end run

on process(appName)
  if isRunning(appName) then
    if isAppOnCurrentVirtualDesktop(appName) then
      toggleVisible(appName, false)
    else
      makeAppVisible(appName, true)
    end if
  else
    boot(appName)
  end if
end process

on reverseMinimizedAsNeed(appName)
  tell application "System Events"
    repeat with win in every window of process appName
      if value of attribute "AXMinimized" of win is true then
        set value of attribute "AXMinimized" of win to false
      end if
    end repeat
  end tell
end reverseMinimizedAsNeed

on isFrontmost(appName)
  tell application "System Events"
    return frontmost of process appName
  end tell
end isFrontmost

on toggleVisible(appName)
  if isVisible(appName) then
    if isFrontmost(appName) then
      --display dialog "toggleVisible:3-1-1"
      makeAppInvisible(appName)
    else
      --display dialog "toggleVisible:3-1-2"
      reverseMinimizedAsNeed(appName)
      --display dialog "toggleVisible:3-1-3"
      makeAppVisible(appName, true)
      --display dialog "toggleVisible:3-1-4"
    end if
  else
    --display dialog "toggleVisible:3-2"
    makeAppVisible(appName, false)
  end if
end toggleVisible

on isVisible(appName)
  tell application appName
    tell application "System Events"
      return visible of process appName
    end tell
  end tell
end isVisible

on makeAppFrontmost(appName)
  tell application "System Events"
    set frontmost of process appName to true
  end tell
end makeAppFrontmost

on makeAppInvisible(appName)
  --display dialog "makeAppInvisible:4-1"
    tell application "System Events"
      --display dialog "makeAppInvisible:4-2"
      set visible of process appName to false
    end tell
end makeAppInvisible

on makeAppVisible(appName, onceInvisible)
    tell application "System Events"
      --display dialog "makeAppVisible:5-1" & onceInvisible
      if onceInvisible then
        --display dialog "makeAppVisible:5-2" & onceInvisible
        set visible of process appName to false
        delay 0.7
        set visible of process appName to true
        set frontmost of process appName to true
        delay 0.7
      end if
      set frontmost of process appName to true
    end tell
end makeAppVisible

on isAppOnCurrentVirtualDesktop(appName)
  tell application "System Events"
    return exists of windows of process appName
  end tell
end isAppOnCurrentVirtualDesktop

on boot(appName)
  tell application appName
    activate
  end tell
  makeAppVisible(appName)
end boot

on isRunning(appName)
  tell application appName
    return running
  end tell
end isRunning

