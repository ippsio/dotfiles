on run argv
  --set argv to {"Microsoft Edge"}
  --set argv to {"Slack"}
  if (count of argv) is 0 then
    display dialog "No arguments provided." buttons {"OK"} default button "OK"
    return
  end if
  set appName to item 1 of argv
  try
    set res to process(appName) of me
  on error theCaption number n
    display dialog theCaption
  end try
end run

on process(appName)
  if isRunning(appName) then
    if isAppOnCurrentVirtualDesktop(appName) then
      toggleVisible(appName, false)
    else
      makeAppVisible(appName, true)
    end if
  else
    activate(appName)
    makeAppVisible(appName, false)
  end if
end process

on isRunning(appName)
  tell application appName
    return running
  end tell
end isRunning

on activate(appName)
  tell application appName
    activate
  end tell
end activate

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
    set process_appName to process appName
  end tell

  if onceInvisible then
    tryToFocusAppOnAnotherVirtualDesktop(appName)
    set frontmost of process_appName to true
    (* 一定のdelayを挟まないと動作が安定しない(経験則) *)
    delay 0.5
    if not isAppOnCurrentVirtualDesktop(appName) then
      (*
        ここまでしてもwindowが存在しない場合、ウインドウを新規作成する。
        Chrome等のブラウザで、タブが全て閉じられている場合などを想定します。
      *)

      makeNewWindowOfApp(appName)
    end if
  else
    set frontmost of process_appName to true
  end if
end makeAppVisible

on makeNewWindowOfApp(appName)
  activate(appName)

  (* 待つ *)
  delay 0.5
  tell application "System Events"
    keystroke "n" using {command down} -- 新しいウィンドウを開く
  end tell
end makeNewWindowOfApp

on tryToFocusAppOnAnotherVirtualDesktop(appName)
  tell application "System Events"
    (*
      別の仮想デスクトップでAppが起動している場合、
      一度 visible を false に設定し、
      再度 visible を true に設定すると、
      該当のAppが起動している仮想デスクトップにフォーカスが移動するようです(経験則)。
      その際、一定のdelayを挟まないと動作が安定しないようです(こちらも経験則)。
    *)
    set visible of process appName to false
    delay 0.1
    set visible of process appName to true
  end tell
end tryToFocusAppOnAnotherVirtualDesktop

on makeAppInvisible(appName)
  tell application "System Events"
    set visible of process appName to false
  end tell
end makeAppInvisible


