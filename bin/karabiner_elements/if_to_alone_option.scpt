on run argv
  if (count of argv) is 0 then
    display dialog "No arguments provided. Please provide an argument." buttons {"OK"} default button "OK"
    return
  end if
  set appName to item 1 of argv

  tell application appName
    if not running then
      activate
    end if
  end tell

  tell application "System Events"
    set appProcess to process appName
  end tell

  if visible of appProcess then
    set visible of appProcess to false
  else
    set frontmost of appProcess to true
  end if
end run
