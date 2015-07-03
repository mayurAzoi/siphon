# Introduction #

You tested Siphon, but finally this version is unstable (as I said ;-) so you want to uninstall from your device.

This article describes how uninstall manually Siphon.


# Details #

Start by remove Siphon settings from General Settings :
```
/Applications/Siphon.app/Siphon --removePrefBundle
```

Delete `Siphon.app` directory

Delete `SiphonSettings.bundle` directory in `/System/Library/PreferenceBundles/`

Delete `Default_Siphon.png` and `FSO_Siphon.png` in `/System/Library/CoreServices/SpringBoard.app/`

Finally, restart the SpringBoard:
```
killall SpringBoard
```

You can read uninstall section in this [file](http://code.google.com/p/siphon/source/browse/trunk/Siphon/rep.xml) to know all operations.