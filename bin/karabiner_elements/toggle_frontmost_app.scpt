on run argv
  --set argv to {"Microsoft Edge"}
  if (count of argv) is 0 then
    display dialog "No arguments provided." buttons {"OK"} default button "OK"
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

on isRunning(appName)
  tell application appName
    return running
  end tell
end isRunning

on boot(appName)
  tell application appName
    activate
  end tell
  makeAppVisible(appName)
end boot

on isAppOnCurrentVirtualDesktop(appName)
  tell application "System Events"
    return exists of windows of process appName
  end tell
end isAppOnCurrentVirtualDesktop

on toggleVisible(appName)
  if isVisible(appName) then
    if isFrontmost(appName) then
      makeAppInvisible(appName)
    else
      reverseMinimizedAsNeed(appName)
      makeAppVisible(appName, true)
    end if
  else
    makeAppVisible(appName, false)
  end if
end toggleVisible

on isFrontmost(appName)
  tell application "System Events"
    return frontmost of process appName
  end tell
end isFrontmost

on isVisible(appName)
  tell application "System Events"
    return visible of process appName
  end tell
end isVisible

on reverseMinimizedAsNeed(appName)
  tell application "System Events"
    repeat with win in every window of process appName
      if value of attribute "AXMinimized" of win is true then
        set value of attribute "AXMinimized" of win to false
      end if
    end repeat
  end tell
end reverseMinimizedAsNeed

on makeAppFrontmost(appName)
  tell application "System Events"
    set frontmost of process appName to true
  end tell
end makeAppFrontmost

on makeAppVisible(appName, onceInvisible)
    tell application "System Events"
      if onceInvisible then
        set visible of process appName to false
        delay 0.1
        set visible of process appName to true
      end if
      set frontmost of process appName to true
    end tell
end makeAppVisible

on makeAppInvisible(appName)
    tell application "System Events"
      set visible of process appName to false
    end tell
end makeAppInvisible

