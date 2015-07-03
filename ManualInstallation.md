# Manual Installation #

The preferred method of installing Siphon is through the [AppTapp Installer](http://iphone.nullriver.com/beta/). However, if you are unable to or prefer not to use the Installer, you can follow the steps below to install Siphon manually.


**NOTE:** Siphon requires firmware version 1.1.X.

## Manual Installation after compilation ##

  * [Compile](Compilation.md) Siphon.

The three directories are in 'dist' directory.

  * Copy `Siphon.app` into `/Applications` or `/Widgets` on your device. You may see some error messages during this process, are there are several symbolic links in here that the Installer source would normally deal with. You can safely ignore these errors as we will copy the files manually.
  * Copy `SiphonSettings.bundle` into `/System/Library/PreferenceBundles/SiphonSettings.bundle` on your device.
  * Copy `SpringBoard.app` into `/System/Library/CoreServices/SpringBoard.app` on your device.



## Manual Installation after download ##

  * Download the last version on this [page](http://code.google.com/p/siphon/downloads/list).
  * Unzip downloaded file in `/Applications` or `/Widgets` on your device. You may see some error messages during this process, are there are several symbolic links in here that the Installer source would normally deal with. You can safely ignore these errors as we will copy the files manually.
  * Copy `SiphonSettings.bundle` into `/System/Library/PreferenceBundles/SiphonSettings.bundle` on your device.
  * Copy `SpringBoard.app` into `/System/Library/CoreServices/SpringBoard.app` on your device.

# Last operations #

Next, run the following command to complete the installation:
```
/Applications/Siphon.app/Siphon --installPrefBundle
```
Finally, restart the SpringBoard:
```
killall SpringBoard
```