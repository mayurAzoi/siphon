# Installation instructions #

  * Download Siphon-_version_.deb
  * Copy on your iPhone
  * Install
```
dpkg -i Siphon-version.deb
apt-get -y -f install
```

## Old process <= 2.1.0 rc 1 ##

  * Download Siphon-_version_.deb
  * Copy on your iPhone
  * Install
```
dpkg -i Siphon-version.deb
```
  * Install Preferences
```
cd /Applications/Siphon.app
./Siphon --installPrefBundle
```

# Removing instructions #

  * Uninstall Siphon
```
apt-get -y autoremove com.googlecode.siphon
```

## Old process <= 2.1.0 rc 1 ##
  * Remove Preferences
```
cd /Applications/Siphon.app
./Siphon --removePrefBundle
cd
```
  * Uninstall Siphon
```
apt-get remove com.googlecode.siphon
```

# Regenerate Spring Board's system #

Regenerate Spring Board's system application installation icon cache.
This will cause newly installed/removed .app bundles to appear/disappear on the icon list.
```
su mobile
uicache
```

or

```
sudo -u mobile uicache
```

# Dependencies and links #

## Dependencies ##

  * **Open SSH** : Connect on your device by _ssh_.
  * **UIKit Tools** : Regenerate Spring Board with _uicache_.
  * **APT Strict** : Install/Uninstall with _apt-get_
  * **Sudo** : (optional)

  * **PreferenceLoader** : Load settings, and they are always displayed.

## Links ##

  * [Preference Loader](http://volatile-dev.com/PreferenceLoader/)
  * [Preferences Specifier](http://code.google.com/p/networkpx/wiki/PreferencesSpecifierPlistFormat)
  * [Preference Bundles](http://www.touchrepo.com/guides/preferencebundles/PreferenceBundles.doc)