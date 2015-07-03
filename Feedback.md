# Introduction #

If you are a beta-testers of Siphon, you can describe the results of your tests (SIP provider and its parameters, Wi-Fi Network...) in comments.

For problems and enhancements, you should add [issues](http://code.google.com/p/siphon/issues/list).

# 3.9.18 (4.0 alpha) (Not release yet) #

Bugs fixed:
  * change codec priorities, when the settings are changed

New features:
  * last revision of pjsip 1.x and multi-architecture (armv6/armv7)

# 3.9.17 (4.0 alpha) #

Bugs fixed:
  * Impossible to call people from contact list([issue 535](https://code.google.com/p/siphon/issues/detail?id=535))

# 3.9.16 (4.0 alpha) #

Bugs fixed:
  * Unavailable state with UDP connection ([issue 533](https://code.google.com/p/siphon/issues/detail?id=533))

New features:
  * Display missed or all recent calls.

# 3.9.15 (4.0 alpha) #

Bugs fixed:
  * Button save is disabled ([issue 522](https://code.google.com/p/siphon/issues/detail?id=522))
  * Potential leak fixes
  * The recents view displays better the calls.
  * Better multi-account management

New features:
  * Cellular button (enable in phone advanced settings)
  * Log file can be read and sent by mail

# 3.9.14 (4.0 alpha) #

Bugs fixed:
  * Save button on setting not working ([issue 522](https://code.google.com/p/siphon/issues/detail?id=522))

# 3.9.13 (4.0 alpha) #

Bugs fixed:
  * memory leaks.
  * fix the background of dual button (In call view).
  * fix the issue about settings displaying under the keyboard .

# 3.9.12 (4.0 alpha) #

Bugs fixed:
  * icons (removed white corners)
  * if network is unreachable at launching, display a message
  * in some cases the save button, in new account view, is enabled and it should not be it.
  * continue a call in background when UDP connection is used.

New features:
  * support the compact forms of SIP headers
  * g722 and g722.1 support (not tested)
  * receive a second call

# 3.9.11 (4.0 alpha) #

Bugs fixed:
  * Fatal database error ([issue 511](https://code.google.com/p/siphon/issues/detail?id=511))

New features:
  * last version of pjsip
  * the date in Recent Calls is correctly displayed

# 3.9.10 (4.0 alpha) #

Add the source http://svsip.free.fr/repository/cydia in Cydia.
If you installed Siphon 3.9.0/3.9.1, you have to delete file:
> `/User/Documents/CoreDataSiphon.sqlite`

Bugs fixed:
  * Doesn't start on iPhone 4 and iPod Touch 4 with iOS 4.3.1 ([issue 504](https://code.google.com/p/siphon/issues/detail?id=504))

# 3.9.9 (4.0 alpha) #

Bugs fixed:
  * Regression on Magic Jack ([issue 498](https://code.google.com/p/siphon/issues/detail?id=498))
  * Prevent screen lock when on a call ([issue 502](https://code.google.com/p/siphon/issues/detail?id=502))
  * Doesn't start on iPhone 4 and iPod Touch 4 with iOS 4.3.1 ([issue 504](https://code.google.com/p/siphon/issues/detail?id=504))

New features:
  * Select Codecs with type of connection ([issue 178](https://code.google.com/p/siphon/issues/detail?id=178), [issue 496](https://code.google.com/p/siphon/issues/detail?id=496))
  * Display legal notice

# 3.9.8 (4.0 alpha) #

Bug fixed:
  * Crash when placing a call with account disconnected.

New features
  * if the account is not connected, propose to place a regular call.

# 3.9.7 (4.0 alpha) #

Bugs fixed:
  * background support (TCP)

New features
  * Specify user agent ([issue 477](https://code.google.com/p/siphon/issues/detail?id=477))

# 3.9.6 (4.0 alpha) #

Bugs fixed:
  * Auth. name does not work ([issue 489](https://code.google.com/p/siphon/issues/detail?id=489))
  * test if VoIP over 3G feature is enabled or not

New Features:
  * multi DNS (use coma between servers)
  * multi proxy and outbound proxy (use coma between servers)

# 3.9.5 (4.0 alpha) #

Bugs fixed:
  * Bluetooth support ([issue 487](https://code.google.com/p/siphon/issues/detail?id=487))
  * Not ringing when incoming call is received ([issue 488](https://code.google.com/p/siphon/issues/detail?id=488))
  * STUN sever doesn't use.

New feature:
  * ilbc support ([issue 65](https://code.google.com/p/siphon/issues/detail?id=65))

# 3.9.4 (4.0 alpha) #

Bugs fixed:
  * Auth. name does not work ([issue 489](https://code.google.com/p/siphon/issues/detail?id=489))
  * Bluetooth support ([issue 487](https://code.google.com/p/siphon/issues/detail?id=487))

# 3.9.3 (4.0 alpha) #

Bugs fixed:
  * Auth. name does not work ([issue 489](https://code.google.com/p/siphon/issues/detail?id=489))
  * Calling direct SIP addresses ([issue 490](https://code.google.com/p/siphon/issues/detail?id=490))
  * MagicJack support ([issue 485](https://code.google.com/p/siphon/issues/detail?id=485))
  * Display button '+' in Contacts view

New feature:
  * Multitask support (TCP only) ([issue 410](https://code.google.com/p/siphon/issues/detail?id=410), [issue 486](https://code.google.com/p/siphon/issues/detail?id=486))
  * SIP Signaling over TCP  ([issue 398](https://code.google.com/p/siphon/issues/detail?id=398))

# 3.9.2 (4.0 alpha) #

Bugs fixed:
  * Recent calls are not displayed ([issue 484](https://code.google.com/p/siphon/issues/detail?id=484))
  * Message is displayed when authentication failed,

# 3.9.1 (4.0 alpha) #

Bugs fixed:
  * saving of settings,
  * save button is enabled when you back from advanced settings.

# 3.9.0 (4.0 alpha) #

New features:
  * Multi account ([issue 46](https://code.google.com/p/siphon/issues/detail?id=46))

Bugs fixed:
  * support iOS 4.1 and later

# 2.3 rc4 #

Bugs fixed:
  * Settings are not displayed with iOS4 ([issue 406](https://code.google.com/p/siphon/issues/detail?id=406))

# 2.3 rc3 #

New features:
  * Manage Message Waiting Information (MWI) ([issue 94](https://code.google.com/p/siphon/issues/detail?id=94))
  * Dipslay the missed call ([issue 273](https://code.google.com/p/siphon/issues/detail?id=273))

Bugs fixed:
  * Resend authentication after error message 302 ([issue 397](https://code.google.com/p/siphon/issues/detail?id=397))
  * Crash on decline incoming call ([issue 385](https://code.google.com/p/siphon/issues/detail?id=385))
  * Accept two calls simultaneously ([issue 69](https://code.google.com/p/siphon/issues/detail?id=69), [issue 237](https://code.google.com/p/siphon/issues/detail?id=237), [issue 391](https://code.google.com/p/siphon/issues/detail?id=391))

# 2.3 rc2 #

New features:
  * Define the frequency/clock rate
  * Enable bluetooth headset (quality is not very good, Apple's issue ?) ([issue 277](https://code.google.com/p/siphon/issues/detail?id=277), [issue 361](https://code.google.com/p/siphon/issues/detail?id=361))

# 2.3 rc1 #

Bugs fixed:
  * Dutch translation ([issue 353](https://code.google.com/p/siphon/issues/detail?id=353))
  * Correct ptime with G729 ([issue 374](https://code.google.com/p/siphon/issues/detail?id=374))
  * open codec to 16kHz ([issue 337](https://code.google.com/p/siphon/issues/detail?id=337))

New features:
  * Add Keep Awake functionality ([issue 383](https://code.google.com/p/siphon/issues/detail?id=383), [issue 228](https://code.google.com/p/siphon/issues/detail?id=228), [issue 296](https://code.google.com/p/siphon/issues/detail?id=296), [issue 328](https://code.google.com/p/siphon/issues/detail?id=328))

# 2.2.1 rc1 (not released) #

New features
  * Swedish translation (thanks to micsta29) ([issue 340](https://code.google.com/p/siphon/issues/detail?id=340))
  * Dutch translation (thanks to sjoerd.olthof) ([issue 353](https://code.google.com/p/siphon/issues/detail?id=353))
  * Russian translation update (thanks to Alexey) ([issue 348](https://code.google.com/p/siphon/issues/detail?id=348))

# 2.2.1 alpha 2 #

Bug fixed:
  * Issue with Magic Jack is fixed.

New features:
  * update to pjsip 1.5.5

# 2.2.1 alpha 1 #

Bugs fixed :
  * Problem with using Magicjack SIP account ([issue 151](https://code.google.com/p/siphon/issues/detail?id=151), [issue 234](https://code.google.com/p/siphon/issues/detail?id=234), [issue 245](https://code.google.com/p/siphon/issues/detail?id=245), [issue 261](https://code.google.com/p/siphon/issues/detail?id=261))

# 2.2.0 rc4 and 2.2.0 #

Bugs fixed:
  * g722 and g722.1 implemented ([issue 308](https://code.google.com/p/siphon/issues/detail?id=308))

# 2.2.0 rc3 #

New features:
  * multi definition of proxy in advanced settings (separate multi server by coma)

Bugs fixed:
  * crash if network configuration is incomplete ([issue 223](https://code.google.com/p/siphon/issues/detail?id=223), [issue 220](https://code.google.com/p/siphon/issues/detail?id=220), [issue 155](https://code.google.com/p/siphon/issues/detail?id=155), [issue 230](https://code.google.com/p/siphon/issues/detail?id=230), [issue 303](https://code.google.com/p/siphon/issues/detail?id=303), [issue 313](https://code.google.com/p/siphon/issues/detail?id=313), [issue 315](https://code.google.com/p/siphon/issues/detail?id=315), [issue 326](https://code.google.com/p/siphon/issues/detail?id=326), [issue 327](https://code.google.com/p/siphon/issues/detail?id=327))

# 2.2.0 rc2 #

New features:
  * specification of nameserver to enable DNS SRV resolution (separate multi server by comma)

# 2.2.0 rc1 #

Bugs fixed:
  * No audio after call put on hold ([issue 219](https://code.google.com/p/siphon/issues/detail?id=219))

New features:
  * update to pjsip 1.4
  * Catalan translation (thanks to Jordi)
  * Slovak translation (thanks to Rovniansky)
  * Labels below images (speaker, mute, hold...) are displayed
  * Long hold of delete key , deletes quicker or instantly all numbers ([issue 156](https://code.google.com/p/siphon/issues/detail?id=156))

  * VPN ([issue 225](https://code.google.com/p/siphon/issues/detail?id=225), [issue 222](https://code.google.com/p/siphon/issues/detail?id=222), [issue 195](https://code.google.com/p/siphon/issues/detail?id=195), [issue 120](https://code.google.com/p/siphon/issues/detail?id=120))
    * _public ip addr_ : Application can specify any address or hostname for this field, for example it can point to one of the interface address in the system, or it can point to the public address of a NAT router where port mappings have been configured for the application.
    * _bound ip addr_ : This option SHOULD only be used to selectively bind the socket to particular interface (instead of 0.0.0.0), and SHOULD NOT be used to set the published address of a transport (the public ip addr field should be used for that purpose).


# 2.1.0 rc3 and 2.1.0 #

Bugs fixed:
  * pressed button of keypad staid displayed when the view changes ([issue 292](https://code.google.com/p/siphon/issues/detail?id=292))

# 2.1.0 rc2 #

Bugs fixed:
  * hebrew language should be worked
  * settings should be displayed everytime ([issue 90](https://code.google.com/p/siphon/issues/detail?id=90))
  * on ipod touch microphone must be connected to phone ([issue 248](https://code.google.com/p/siphon/issues/detail?id=248), [issue 288](https://code.google.com/p/siphon/issues/detail?id=288))

# 2.1.0 rc1 #

Update with the last version of pjsip 1.0.3

Bugs fixed:
  * enter @ sign for URI ([issue 214](https://code.google.com/p/siphon/issues/detail?id=214))
  * disable RTCP advertising in SDP (for televantage provider) ([issue 207](https://code.google.com/p/siphon/issues/detail?id=207))

New features:
  * **g729a codec** ([issue 129](https://code.google.com/p/siphon/issues/detail?id=129))
  * Switch between numpad and alpha bad is possible by touch the field ([issue 215](https://code.google.com/p/siphon/issues/detail?id=215))
  * _Add "URI" in address book_
  * Voicemail button
  * Suppress DTMF (or make it optional) when entering destination number ([issue 211](https://code.google.com/p/siphon/issues/detail?id=211))
  * Russian translation ([issue 205](https://code.google.com/p/siphon/issues/detail?id=205))
  * Croatian translation ([issue 275](https://code.google.com/p/siphon/issues/detail?id=275))
  * Hebrew translation ([issue 260](https://code.google.com/p/siphon/issues/detail?id=260), [issue 276](https://code.google.com/p/siphon/issues/detail?id=276))
  * Enable or disable GSM/Cellular button ([issue 213](https://code.google.com/p/siphon/issues/detail?id=213))
  * implementation of the "pause" key ([issue 241](https://code.google.com/p/siphon/issues/detail?id=241))
  * option to remove international prefix '+', if you don't find the substitution code.

# 2.0.8 #

Update with the last version of pjsip 1.0.2

Bugs fixed:
  * call URI from recent dial works ([issue 162](https://code.google.com/p/siphon/issues/detail?id=162))
  * display menu instead of dialpad ([issue 99](https://code.google.com/p/siphon/issues/detail?id=99), [issue 144](https://code.google.com/p/siphon/issues/detail?id=144))
  * crash at startup with NAT or Echo canceler enables ([issue 187](https://code.google.com/p/siphon/issues/detail?id=187), [issue 194](https://code.google.com/p/siphon/issues/detail?id=194), [issue 199](https://code.google.com/p/siphon/issues/detail?id=199))

New features:
  * dial string is possible ([issue 162](https://code.google.com/p/siphon/issues/detail?id=162))
  * GSM button to call with mobile subscription and not SIP.
  * display version number in settings ([issue 173](https://code.google.com/p/siphon/issues/detail?id=173))
  * Multiple codec selection ([issue 186](https://code.google.com/p/siphon/issues/detail?id=186))
  * Russian language ([issue 205](https://code.google.com/p/siphon/issues/detail?id=205))
  * Korean translation ([issue 240](https://code.google.com/p/siphon/issues/detail?id=240))
  * display photo

# 2.0.6 / 2.0.7 #

Bugs fixed:
  * Impossible to call SIP url several times ([issue 145](https://code.google.com/p/siphon/issues/detail?id=145))
  * Auto Lock screen is not disabled by siphon ([issue 153](https://code.google.com/p/siphon/issues/detail?id=153))

New features:
  * Czech localization ([issue 158](https://code.google.com/p/siphon/issues/detail?id=158))
  * Chinese localization
  * Select one codec, by default all codec can be used ([issue 186](https://code.google.com/p/siphon/issues/detail?id=186))
  * Doesn't support DTMF with INFO message ([issue 168](https://code.google.com/p/siphon/issues/detail?id=168))

# 2.0.5 #

Bugs fixed:
  * Impossible to define port in server and proxy parameters ([issue 114](https://code.google.com/p/siphon/issues/detail?id=114), [issue 151](https://code.google.com/p/siphon/issues/detail?id=151))

# 2.0.4 #

Bug fixed:
  * Problem of connection with IP address and Proxy ([issue 103](https://code.google.com/p/siphon/issues/detail?id=103))
  * size of title button ([issue 143](https://code.google.com/p/siphon/issues/detail?id=143))

New features:
  * enable [ICE](http://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment) (Interactive Connectivity Establishment)
  * Slovenian Translation ([issue 141](https://code.google.com/p/siphon/issues/detail?id=141))

# 2.0.3 #

New features:
  * Message scrolling if it's too long ([issue 132](https://code.google.com/p/siphon/issues/detail?id=132))
  * Enable/disable echo canceler ([issue 45](https://code.google.com/p/siphon/issues/detail?id=45))
  * Enable/Disable silence detector/voice activity detector
  * Define CallerID for From field ([issue 115](https://code.google.com/p/siphon/issues/detail?id=115), [issue 134](https://code.google.com/p/siphon/issues/detail?id=134)?)
  * Hold on call ([issue 133](https://code.google.com/p/siphon/issues/detail?id=133))
  * International prefix substitution ([issue 96](https://code.google.com/p/siphon/issues/detail?id=96))
  * Keep Alive Interval ([issue 130](https://code.google.com/p/siphon/issues/detail?id=130))

# 2.0.2 #

Bugs fixed:
  * Dial SIP addresses ([issue 97](https://code.google.com/p/siphon/issues/detail?id=97), [issue 89](https://code.google.com/p/siphon/issues/detail?id=89))
  * No auth on invite ([issue 121](https://code.google.com/p/siphon/issues/detail?id=121) [issue 126](https://code.google.com/p/siphon/issues/detail?id=126)?)

New features:
  * mute ([issue 66](https://code.google.com/p/siphon/issues/detail?id=66))
  * speaker ([issue 67](https://code.google.com/p/siphon/issues/detail?id=67))
  * new splashscreen
  * new icons for AppStore

# 2.0.1 #

Bugs fixed:
  * Impossible to set Username unequal Authorization name ([issue 20](https://code.google.com/p/siphon/issues/detail?id=20))
  * Stun server is not saved (Cydia) ([issue 88](https://code.google.com/p/siphon/issues/detail?id=88))

Modifications:
  * Log level moved to advanced settings.

# Beta 16 #

Cydia version, because I have no news from Apple since December 7,2008 I decide to publish a Cydia version. Users can activated VoIP on 3G/Edge.

# Beta 15 #

Siphon works on iPod Touch 2 with headset.

Bugs fixed:
  * In some cases Siphon could work on 3G/Edge :-(
  * Siphon can be installed from Windows and Mac.

Thanks to Yan and Bernard.

# Beta 14 #

Bugs fixed :
  * several bugs fixed in Distribution after modification of compilation options.

Thanks to David.

# Beta 13 #

Bugs fixed
  * beta 12 does not install on iphoneOS 2.2 ([issue 78](https://code.google.com/p/siphon/issues/detail?id=78))
  * UI Enhancement : visual feedback when pressing buttons ([issue 75](https://code.google.com/p/siphon/issues/detail?id=75))

# Beta 12 #

Same beta 11 but for iphone 2.2

# Beta 11 #

Bugs fixed
  * Crash for audio feedback of _star_ key for windows users ([issue 77](https://code.google.com/p/siphon/issues/detail?id=77))
  * some bugs in call history

Enhancements
  * Display status of connection
  * Disconnect and reconnect when the Wi-Fi network status changes.

# Beta 10 #

Bugs fixed and enhancement:
  * Ring and ringback ([issue 40](https://code.google.com/p/siphon/issues/detail?id=40), [issue 56](https://code.google.com/p/siphon/issues/detail?id=56), [issue 68](https://code.google.com/p/siphon/issues/detail?id=68))
  * History of calls ([issue 48](https://code.google.com/p/siphon/issues/detail?id=48))
  * Stun server and parameters are correctly used ([issue 74](https://code.google.com/p/siphon/issues/detail?id=74)).
  * Sound when you dials, if the iPhone is not on vibrate mode.
  * Reorder favorites

# Beta 9 #

Bugs fixed and enhancement:
  * Quality of sound should be good now (few delay, [issue 54](https://code.google.com/p/siphon/issues/detail?id=54)).
  * Remove icons of call history, because the work is not finished.

# Beta 8 #

Bugs fixed:
  * Closed session at the end
  * Dialing single Digits works ([issue 49](https://code.google.com/p/siphon/issues/detail?id=49))
  * Version 1.0 of pjsip so dtmf should be work ([issue 39](https://code.google.com/p/siphon/issues/detail?id=39)).
  * Stun server and parameters are correctly used ([issue 58](https://code.google.com/p/siphon/issues/detail?id=58)).

# Beta 7 #

AEC is activated.

GSM Codec is added.

I tested at home the DTMF tones rfc2833, and it seems it works.

It seems there are some problems with provider using [SIP Express Router](http://www.iptel.org/ser).

Bugs/Enhancement fixed :
  * accept letter in number like 1800-My-APPLE ([issue 50](https://code.google.com/p/siphon/issues/detail?id=50))
  * pressing call twice with no number should act like redial. ([issue 52](https://code.google.com/p/siphon/issues/detail?id=52))
Translation complete
  * English
  * French
  * Spanish
  * German
  * Italian
  * Portuguese
  * Danish
Thanks for translation to David, Stefan, Patrick, Pedro, Jorge and Ferruccio.

# Beta 6 #
This version is compiled for iPhone 2.1 and uses specific features of 2.1.

This version fixes:
  * proxy parameter works ([issue 13](https://code.google.com/p/siphon/issues/detail?id=13))
  * freephonie network works ([issue 44](https://code.google.com/p/siphon/issues/detail?id=44))
  * iTunes Application Icon ([issue 41](https://code.google.com/p/siphon/issues/detail?id=41))

It seems DTMF with rfc 2833 doesn't work yet.

I began to implement history of recent calls.

New translation:
  * Spanish
  * Portuguese

Translation not finished
  * German
  * Italian

# Beta 5 #
This version is compiled for iPhone 2.1 and uses specific features of 2.1.

This version fixes:
  * Sometimes the screen "appel terminé"/"call ended" stays display ([issue 32](https://code.google.com/p/siphon/issues/detail?id=32))
  * Advanced parameters are read always ([issue 33](https://code.google.com/p/siphon/issues/detail?id=33))
  * Crash when hang up ([issue 34](https://code.google.com/p/siphon/issues/detail?id=34))
  * Implements DTMF with rfc 2833 before DTMF inband ([issue 9](https://code.google.com/p/siphon/issues/detail?id=9) and [issue 39](https://code.google.com/p/siphon/issues/detail?id=39))

This version adds:
  * Somes error messages to understand why the connection isn't established.
  * Siphon rings and vibrates when a call is received

Problems known:
  * No elements to know if Siphon is connected or not
  * No history list

# Beta 4 #

This version is compiled for iPhone 2.1.
This versions adds:
  * New implementation of dialpad
    * display key down
    * manage '+' and ','
  * New translation (not finish)
    * German
    * Italian
    * Spanish

# Beta 3 #

This version is compiled for iPhone 2.0
This versions adds:
  * Error messages,
  * Proxy parameter

# Beta 2 #

This versions adds:
  * NAT and STUN parameters

# Beta 1 #