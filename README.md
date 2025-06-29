# Quick overview of scripts

## dmenuSelect.nu

List of strings in nuon format -> prompt to select one of strings using rofi -dmenu
Uses rofi

```nu
  options: string       # List of string (nuon format) to select from
  msg: string           # Prompt to display
  --fuzzy (-f)          # Use fuzzy matching
  --theme (-t): string  # rofi -dmenu theme (default sets width)
  --width (-w): int     # width for theme
  --length (-l): int    # Number of lines to display (default options length)
```

## getMonitors.nu

Get table with connected monitors in nuon format {name: ..., resolution: ...}
Uses xrandr

```nu
  --raw (-r) # Output plain text
```

## killprompt.nu

Prompt to kill process by name/id  
Uses dmenuSelect.nu

## misc.nu

Prompts user to select which script to run next and runs it.  
Uses dmenuSelect.nu

To run, either add directory with scripts you want to run to PATH  
(to envoke with i3 binds I do that in .xsession like
"export PATH="$HOME/.custom/scripts:$PATH")  
or replace with full path.

```nu
  --priority (-p): int # Defines which scripts will be shown
```

## monitorDuplicate.nu

Disconnect/connect/etc monitors with xrandr  
Uses dmenuSelect.nu, getMonitors.nu, selectMonitor.nu

## monitorRotate.nu

Rotates selected monitor with xrandr  
Uses dmenuSelect.nu, selectMonitor.nu

## music.nu

Mainly prints title/artist of currently playing song.  
Uses playerctl

```nu
  --player  (-p): string   # Specify player 
  --format  (-f)           # Output is formated "title (artist)" instead of nuon
  --title   (-t)           # Output title
  --artist  (-a)           # Output artist
  --rotate  (-r)           # Rotate title (with max_len and speed)
      --max_len (-l): int  # Max length of rotated title
      --speed   (-s): int  # Speed of rotation
```

## newNote.nu

(Stolen from Bread on Penguins)  
Prompts user to create new note or edit old  
Uses dmenuSelect.nu, rofi, ghostty (for default terminal), nvim (for editor)

## selectMonitor.nu

Select monitor from connected ones  
If monitors variable is not provided, gets monitors through getMonitors.nu  
Uses getMonitors.nu, dmenuSelect.nu, youSure.nu

```nu
  message: string   # Prompt to display
  monitors?: string # List of monitor in nuon format (optional)
  --confirm (-c)    # If only one monitor, automatically chooses it and returns
  --skip (-s)       # Skip check whether there is only one monitor connected
```

## setBackground.nu

Set background image  
Uses feh (for setting bg image), dmenuSelect.nu, getMonitors.nu, selectMonitor.nu  
Change bg folder

```nu
  type?: string        # Type of background folder to randomize (specified it code)
  --file (-f): string  # Specify file to set background to. Ignores type
  --monitor (-m): int  # Specify monitor id
  --per_mon (-p)       # Prompts to pick monitor and background for it
                       # (hopefully works. Cannot check. No second monitor :( )
```

## shutdown.nu

Just shutdown  
Uses systemctl, dmenuSelect.nu

## switchAudioOutput.nu

Switches audio output...  
Uses pactl, dmenuSelect.nu

## toggleProg.nu

Checks if program provided is running and either starts or kills it.  
Can provide custom executable to launch, or flags for starting.  

```nu
  --is_running (-r)         # Print 1/0 if the program does/doesn't running
  --cust_exec (-c): string  # Specify custom executable to run if program is not running
  program: string           # Specify program name
  ...arguments: string      # Flags for program launch
```

## youSure.nu

Promts user to confirm selection.  
Uses dmenuSelect.nu

```nu
  selection?: string  # Prints what user previously selected. Just for looks
```
