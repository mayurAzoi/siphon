## Using of Siphon ##

Siphon works on iPhone OS 2.2 and later.

### Why Siphon doesn't work with Skype ###
Skype uses a proprietary protocol that doesn't use SIP protocol. And Siphon uses SIP protocol.

_But you can call Skype's users by gizmo5 project. When you want to call someone, you must use SIP URL: sip://number@opensky.gizmo5.com_
_You can write this URL in safari, or in your address book (web field)._

### Why Siphon doesn't allow to receive a call when it doesn't run ###
Apple doesn't accept (for the moment) an application runs in the background. So, when Siphon doesn't run, the SIP server of your provider doesn't know your iPhone.

### Why Siphon doesn't work on 3G/EDGE network ? ###
The developer agreement forbids the development of VoIP software for 3G/Edge. Moreover, several mobile phone operator forbid the VoIP traffic on their 3G/EDGE network.

_The Siphon version released on Cydia works on 3G/EDGE network._

_But the users must verified their mobile subscription. **The author is not responsible of Siphon's usage.**_

### Does Siphon use gateway server ? ###
No, You are directly connected to your SIP provider.

### Does Siphon work with Bluetooth stereo headset ###
If you have a Bluetooth stereo headset & A2DP adapter for iPhone, Siphon will work over Bluetooth stereo.

This was tested with Jaybird JB-200. It will not work over the handsfree profile. This is an apple limitation.

### What is NAT option ? ###
NAT is [Network Address Translation](http://en.wikipedia.org/wiki/Network_address_translation)


### What is ICE option ? ###

ICE is [Interactive Connectivity Establishment](http://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment)

### Which codec are supported by Siphon ###

Currently, Siphon implements G711, GSM, G729a and G722 codec.
In the future, iLbc, amr will be supported.

## Siphon and iPhone's applications ##
### Why Siphon doesn't use/display the favorites of iPhone? ###
Apple allow to share address book, but in iPhone OS 2.0 and 2.1, it doesn't existe API to obtain favorites.

### Why the recent calls of Siphon and iPhone are not shared? ###
Like previous question on favorites, Apple doesn't allow to manage the recent calls list.