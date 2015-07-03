# Introduction #

I would like to write the process to submit one application for AppStore.
For the moment, Siphon was submitted six times.

## 19th april ##

Apple's guys work Saturday and Sunday, it's a great news but here is their message :

> "Thank you for submitting Siphon to the App Store. We've reviewed Siphon and determined that we cannot post this version of your iPhone application to the App Store because its business model is in violation of section 3.3.3 of the iPhone SDK Agreement:

> "Without Apple's prior written approval, an Application may not provide, unlock or enable additional features or functionality through distribution mechanisms other than the iTunes Store."

Apple took **3 months to answer** and between this two dates Apple changed his license :-(

## 9th april ##

2.5 months after submission, I received this message :

The April 9th, Apple informed me, he need more time to finalize the review:
> "Your application, Siphon, is requiring unexpected additional time for review. We apologize for the delay, and will update you with further status as soon as we are able.

> Thank you for your patience."

## Sixth (25/01/2009) ##

I submitted Siphon 2.0.3 (25/01) with some new functions that you can see [here](Feedback.md), but **mainly** I changed the icons.<br />

## Fifth (06/01/2009) ##

I submitted Siphon 2.0.1 (06/01) with some new functions that you can see [here](Feedback.md).

The January 13th, I received an answer: negative, why i give you the test of his mail:
> "Your application, Siphone, cannot be submitted to the App Store because it uses the Recents button from the iPhone's phone application for an action other than that for which it is intended.  Applications must adhere to the iPhone Human Interface Guidelines as outlined in iPhone SDK Agreement section 3.3.5."

I don't understand because I use SDK features (copy below):
```
UITabBarSystemItemHistory
  The history system item. [http://siphon.googlecode.com/svn/images/Apple%20UITabBarHistory.png]

  Available in iPhone OS 2.0 and later.

  Declared in UITabBarItem.h.

UITabBarSystemItemRecents
  The recents system item.

  Available in iPhone OS 2.0 and later.

  Declared in UITabBarItem.h.
```

Effectively, I use this button ![http://siphon.googlecode.com/svn/images/Apple%20UITabBarHistory.png](http://siphon.googlecode.com/svn/images/Apple%20UITabBarHistory.png) and it allows to see call history. If the developers mustn't use this icon, why is it available in the SDK ?

So I give you the end of message:
> "The Recents button is to be used to display recent calls made using the Phone application.  Implementing this button to refer to calls made from your app will lead to user confusion.  We recommend using another button to refer to the recent calls made from your application."

When I will change the icon, it won't be able submitted to AppStore because the user will be able to not understand. And after it will the favorites icon, and then keypad icon, etc...

## Fourth (02/12) ##

I submitted Siphon (02/12) for iPhone and iPod Touch 2.
<p>The December 7th, Apple informed me, he need more time to finalize the review.<br>
I never received an answer.</p>

## Third (27-29/11) ##
<p>I submitted Siphon (27/11) but I found a bug so I re-submitted Siphon (29/11) before Apple review.</p>
<p>Apple refused "because the VoIP service is active over the cellular network". Like you can see on the screenshot that I received, they tested on iPod touch. So the test was not complete.</p>
<p>In fact when SIP is unreachable or Wi-Fi is unavailable, Siphon asks to users to make a cellular call. Maybe in USA, GSM is unknown.</p>
http://siphon.googlecode.com/svn/images/Apple%20VoIP%20GSM.PNG

## Second (~13/11) ##
I submitted Siphon (~13/11) with new functionalities.<br />
Apple refused because GUI was too close to MobilePhone application of iPhone.<br />
In fact, with my compilation problems the GUI didn't work correctly. So I understand now why Apple refused Siphon.<br />
I corrected these problems and now Siphon displays the status of connection.


## First (25/10) ##
I submitted Siphon (25/10) before I leave in holiday with my family in Spain (Galicia).<br />
Apple refused because I didn't give a SIP account (27/10).<br />
So When I came back, I create a new SIP account and I gave them it.<br />

