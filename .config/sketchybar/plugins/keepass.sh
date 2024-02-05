#!/bin/bash

osascript -e 'tell application "System Events" to tell process "KeePassXC"
    click menu bar item 1 of menu bar 2
    click menu item 2 of menu 1 of menu bar item 1 of menu bar 2
end tell'

