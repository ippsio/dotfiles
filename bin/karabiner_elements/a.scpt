use AppleScript version "2.4"
use scripting additions
set argvAppName to "Microsoft Edge"
set aRes to dispAppWithFullScreen(argvAppName) of me

on dispAppWithFullScreen(appName)
    set pID to id of application appName
    tell application appName
        reopen
        activate
    end tell
    return true
end dispAppWithFullScreen

on isAlive(appName)
  tell application appName
    return running
  end tell
end isAlive
