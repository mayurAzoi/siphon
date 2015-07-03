# Introduction #

This article describes the steps to generate pjsip on Mac OS X 10.5.5


# Details #

## Get pjsip source code ##
Get [PjSIP](http://pjsip.org) from subversion repository:

```
svn checkout http://svn.pjsip.org/repos/pjproject/trunk pjproject
```


## Modify some files ##

### aconfigure.ac ###

In _aconfigure.ac_ file add the lines below displayed with '+'. Of course copy without '+' ;-)

```
 if test "$enable_sound" = "no"; then
   true;
 else
  case $target in
+   arm-apple-darwin*)
+        LIBS="$LIBS -framework CoreAudio -framework CoreFoundation -framework AudioToolbox"
+        ac_pjmedia_snd=iphone
+        AC_MSG_RESULT([Checking sound device backend... AudioQueue])
+        ;;
   *darwin*)
 	LIBS="$LIBS -framework CoreAudio -framework CoreServices -framework AudioUnit -framework AudioToolbox"
 	if test "`uname -r`" = "6.8"; then
```

Comment the checking of in\_system.h existence :
```
dnl AC_CHECK_HEADER(netinet/in_systm.h,[AC_DEFINE(PJ_HAS_NETINET_IN_SYSTM_H,1)])
```

### build/rules.mak ###
In _rules.mak_ modify, remove lines with '-' and add lines with '+':
```
 $(LIB): $(OBJDIRS) $(OBJS) $($(APP)_EXTRA_DEP)
 	if test ! -d $(LIBDIR); then $(subst @@,$(subst /,$(HOST_PSEP),$(LIBDIR)),$(HOST_MKDIR)); fi
-	$(AR) $(LIB) $(OBJS)
-	$(RANLIB) $(LIB)
+	$(RANLIB) -static -o $(LIB) $(OBJS)
```
### pjlib/include/pj/compat/os\_darwinos.h ###
In _os\_darwinos.h_ find and comment the following lines :
```
/*
 * Socket related
 */
//typedef int socklen_t;
```

Without this, you will get an error when you will compile, because socklen\_t is redefined.

### pjlib/include/pj/config\_site.h ###
It can be necessary to define some macro. For example :
```
#undef PJ_HAS_FLOATING_POINT
#define PJ_HAS_FLOATING_POINT	1

/* SRTP has not been ported to iPhone yet */
#   undef PJMEDIA_HAS_SRTP
#   define PJMEDIA_HAS_SRTP		0

/* Disable some codecs for now */
#   define PJMEDIA_HAS_GSM_CODEC	1
#   define PJMEDIA_HAS_L16_CODEC	0
#   define PJMEDIA_HAS_ILBC_CODEC	0
#   define PJMEDIA_HAS_SPEEX_CODEC	0
#   define PJMEDIA_HAS_G722_CODEC	0
```

### pjmedia/build/os-auto.mak.in ###
In _os-auto.mak.in_, add the line with '+'
```
 #   - ds:	    	Win32 DirectSound (dsound.c)
+#   - iphone:       iPhone AudioQueue (iphonesound.c)
 #   - null:	    	Null sound device (nullsound.c)
```

Add the line below, for example between "Win 32 Direct Sound" and " Null Sound Device"

```
#
# iPod/iPhone
#
ifeq ($(AC_PJMEDIA_SND),iphone)
export SOUND_OBJS = iphonesound.o
export CFLAGS += -DPJMEDIA_SOUND_IMPLEMENTATION=PJMEDIA_SOUND_IPHONE_SOUND
endif

```

We have defined a new target for sound device.

### pjmedia/include/pjmedia/config.h ###
in _config.h_ add the lines below with '+':

```
 /** Constant for Win32 MME sound backend. */
 #define PJMEDIA_SOUND_WIN32_MME_SOUND	    3

+/** Constant for AudioQueue sound backend. */
+#define PJMEDIA_SOUND_IPHONE_SOUND            4
```

### pjmedia/src/pjmedia ###
Download [iphonesound.c](http://siphon.googlecode.com/files/iphonesound-20091226.c) file from Download tab, and save in pjmedia/src/pjmedia  directory.

For pjsip 1.4 and later, you should apply [patch](http://siphon.googlecode.com/files/patch-audio_dev.txt). Maybe it works with pjsip 1.3 but I didn't test.

For pjsip 1.4 and later, if you don't want to use legacy audio dev, you can apply this [patch](http://siphon.googlecode.com/files/patch-audioqueue-dev.txt). Maybe it works with pjsip 1.3 but I didn't test.

## Configuration ##
Generate configuration script
```
autoconf aconfigure.ac > aconfigure
```

## Compilation ##

iPhone SDK doesn't provide some programs without version number, so we create symbolic link. We should test before create link, but we are very lazy.
Copy the lines below in file with name like _compile.sh_ in the root of pjsip.

```
#!/bin/sh

export DEV=/Developer/Platforms/iPhoneOS.platform/Developer
export SDK=${DEV}/SDKs/iPhoneOS2.1.sdk

pushd ${DEV}/usr/bin
ln -s arm-apple-darwin9-gcc-4.0.1 arm-apple-darwin9-gcc
ln -s arm-apple-darwin9-g++-4.0.1 arm-apple-darwin9-g++
ln -s ranlib arm-apple-darwin9-ranlib
popd

export PATH=${DEV}/usr/bin:${PATH}

export CFLAGS="-O2 -arch armv6 -isysroot ${SDK}"

export LDFLAGS="-O2 -arch armv6 -isysroot ${SDK}"

export CPP="${DEV}/usr/bin/cpp"

./aconfigure --host=arm-apple-darwin9 --disable-speex-aec \
   --disable-speex-codec --disable-l16-codec --disable-g722-codec \
   --disable-ilbc-codec --disable-ssl

make dep
make
```

We must not forget to change access right to allow execution.
We can run _compile.sh_ after some minutes pjsip is compiled.