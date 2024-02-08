on run argv
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

on isFrontmost(appName)
  tell application "System Events"
    return frontmost of process appName
  end tell
end isFrontmost

on toggleVisible(appName)
  if isVisible(appName) then
    if isFrontmost(appName) then
      makeAppInvisible(appName)
    else
      makeAppFrontmost(appName)
    end if
  else
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
end makeAppInvisible

on makeAppInvisible(appName)
  tell application appName
    tell application "System Events"
      set visible of process appName to false
    end tell
  end tell
end makeAppInvisible

on makeAppVisible(appName, onceInvisible)
  tell application appName
    tell application "System Events"
      if onceInvisible then
        set visible of process appName to false
        delay 0.01
      end if
      set frontmost of process appName to true
    end tell
  end tell
end makeAppVisible

on isAppOnCurrentVirtualDesktop(appName)
  tell application "System Events"
    set cnt to count of windows of process appName
    return cnt >= 1
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

