    cat $0
    exit 0

Backup of my `bin/` folder
==========================

This is just a collection of simple scripts.
Most of them are just one-liners.
Use them as you wish. Have fun.

Licence
-------

Licence: [CC0 Public Domain Dedication](http://creativecommons.org/publicdomain/zero/1.0/)

Recommendations
===============
Somewhat usable and somewhat useful:

* `blackup`
    The backup blacklist generator solves one problem:
    Finding the 80% of your data you don't need a backup of fast.
    Navigate the folders like in any shell, use `ll` to see where the big chunks of data are and blacklist folders or files with `bl` and get updates about the remaining backup size and where you'll be able to get rid of more data.
    This keeps the backup reasonably small while not having to waste time to ponder about the importance of a bunch of small files.
    May be used with rsync natively or with any backup solution as the blacklists are saved automatically as plain text.
    
* `countdown`
    Same as sleep, but you see how much time remains
    Examples:
    `countdown 12m; while sleep 1;do espeak "pizza is ready";done`
    `countdown 25m; notify-send Pomodoro "take a break"`
    `countdown 28d6h42m12s && pkill firefox && init 0` (is interruptable and exits false)

* `slical`
    The single line inode calendar is for showing appointments in a single line.
    I use it in my .rc file to show the next few dates/deadlines/appointments in every new terminal.
    It has a single line and a double line mode:
    Both modes attempts to compresses the entries by deleting vowels before cutting stuff off and color different entries to make telling them apart easier.
    Single line mode shows the current date and significant parts of the dates of the entries (i.e. only the day of month for everythin in the next weeks and day.month for everything later).
    Double line mode Shows the day of the week and the as well as how many days remain.
    Data entry can use different formats eg. `2038-1-19` `19.1.2038` `19-1` `1.19` the later two mapping to the next 19th of January.
    Entries are stored in `~/.calenda` just as the name of an empty file.

```
> slical single
(09.08) 14|Camp Anrse 21|Camp 27|Camp Abrse 2|CR Pruefung

> slical double
Fri|Camp Anreise|  Camp      |Camp Abreise|CeR Pruefung
09.|5> Wed 14.8 |12> Wed 21.8|18> Tue 27.8|24> Mon 2.9 
```

* `P`
    P the paragraph printing program prints pretty pennants.
    It's basically a big colorful bar that can help you to find the beginning of long outputs.
    You can use it before compiling to have a visual barrier between different runs.
    It has different modes and adjustable thickness.

* `inotifymake`
    Wait for a file to change, then `make`.


Not recommended but inspiring
=============================
Things to look into to see how they work:

* `night_mode`
    Sets color temperature via `xrandr`. Useful for the table.
    
* `procrastinadoro`
    Uses `countdown` and `notify-send`. I call it Procrastinadoro, because I like procrastinating for 1/2h and then doing menial tasks for 5min. Like Pomodoro but reverse with a greater focus on procrasination. Because thats what we really want to do. "And buy procrastinadoro now. It's not time for work! It's procastination time. Get things done while doing nothing. It never was easier."

* `alert_brightness` & `tmp_brighness`
    Uses the `brightness` program from my *random* repo. `tmp_brightness` set's a brightness temporarily and restores it on exit. `alert_brightness` works in a similay way, only the it uses the backlight to blink with the whole monitor as a nonauditive alarm you can't overlook.

* `i3all`
    Has a somewhat useful i3 control flow using `dmenu`, `i3-input` and `i3-msg` to move workspaces to outputs(monitors) and rename workspaces. Originally for everything seldomly used that can share a keybinding.


