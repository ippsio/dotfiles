use AppleScript version "2.4"
use scripting additions
on run argv
  if (count of argv) is 0 then
    display dialog "No arguments provided. Please provide an argument." buttons {"OK"} default button "OK"
    return
  end if
  set argvAppName to item 1 of argv
  set aRes to dispAppWithFullScreen(argvAppName) of me
end run

on dispAppWithFullScreen(applicationName)
    set appName to returnExactNameOfAnApp(applicationName)
    if appName = false then

      tell application argvAppName
        if not running then
          activate
          tell application "System Events"
            set frontmost of process appName to true
          end tell
        end if
      end tell

      return false
    else
      set pID to id of application appName
      log pID
      tell application appName
          reopen
          activate
      end tell
      tell application "System Events"
          set appProcess to process 1 whose bundle identifier is pID
          tell appProcess

            repeat with win in windows
                set isFullScreen to value of attribute "AXFullScreen" of win
                set nameOfWin to (name of win)
                if not nameOfWin = "" then
                  log nameOfWin & " " & isFullScreen
                end if
              end repeat
          end tell
      end tell
      return true
    end if
end dispAppWithFullScreen

on returnExactNameOfAnApp(aName)
    tell application "System Events"
        set ap1List to every process whose name is equal to aName
        if ap1List = {} then
            set ap1List to every process whose displayed name is equal to aName
            if ap1List = {} then return false
        end if
        set anApp to contents of first item of ap1List
        return name of anApp
    end tell
end returnExactNameOfAnApp
