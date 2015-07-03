# Introduction #

Add your content here.


# Headers #

Apple doesn't publish all headers from Public Frameworks, and none from Private Frameworks.
But Siphon uses some headers. You can find its on [Erica Sadun's](http://ericasadun.com/iPhoneDocs220/) site, or you can generate alone with class-dump tool on iPhone.
```
   class-dump -H <Framework>
```

You need to do this for :
  * Preferences (PrivateFrameworks)
  * AdressBookUI (Frameworks)

Copy the two directories in _Headers_ folder.

# Compilation #

If you don't have Apple's Certificate, you can compile and install on Jailbreak iPhone. For that you just need to read and apply the [BigBoss's instructions](http://thebigboss.org/hosting-repository/submit-your-app/compile-for-cydia-submission/).

## Settings ##

xcode project is configured to compiled for iPhone OS 2.2 so you need to define the certificate.
  * Open **Project "SiphonSettings" Info**
  * Select in **Code Signing/Any iPhone OS Device** your certificate.

## Siphon ##

xcode project is configured to compiled for iPhone OS 2.2 so you need to define the certificate.
  * Open **Project "SiphonSettings" Info**
  * Select in **Code Signing/Any iPhone OS Device** your certificate.

# Packaging #

## Settings ##

The SiphonSettings.bundle package must be installed on iPhone in this directory :
  * /System/Library/PreferenceBundles

## Siphon ##

The Siphon.app package must be installed on iPhone in this directory :
  * /Applications