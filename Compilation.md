# Introduction #

This article describes the steps to generate Siphon.
I just tested this on Linux. If you test and it works on another OS, I'd like to know.

# PjSIP Compilation #

## Getting pjsip source code ##
Get [PjSIP](http://pjsip.org) from subversion repository:

```
svn checkout http://svn.pjsip.org/repos/pjproject/trunk pjproject
```

## Media device for ipod/iphone ##

### pjMedia ###
Download [iphonesound.c](http://siphon.googlecode.com/files/iphonesound-20091226.c), and save in _pjmedia/src/pjmedia_ directory.

Complete _config.h_ file in pjmedia/include/pjmedia at line 59 with:
```
/** Constant for AudioQueue sound backend. */
#define PJMEDIA_SOUND_IPHONE_SOUND	    3
```

### Configuration ###
Complete _aconfigure.ac_ file at line 370 with:
```
  arm-apple-darwin*)
	LIBS="$LIBS -framework CoreAudio -framework CoreFoundation -framework AudioToolbox"
	ac_pjmedia_snd=iphone
	AC_MSG_RESULT([Checking sound device backend... AudioQueue])
	;;
```

Complete _os-auto.mak.in_ in _pjmedia/build_ at line 92 with following lines:
```
#
# iPod/iPhone
#
ifeq ($(AC_PJMEDIA_SND),iphone)
export SOUND_OBJS = iphonesound.o
INCLUDE_IPHONE=/path/of/include/in/iphone/sdk
export CFLAGS += -DPJMEDIA_SOUND_IMPLEMENTATION=PJMEDIA_SOUND_IPHONE_SOUND \
	-D__COREAUDIO_USE_FLAT_INCLUDES__ \
	-I$(INCLUDE_IPHONE)/AudioToolbox \
	-I$(INCLUDE_IPHONE)/CoreAudio \
	-I$(INCLUDE_IPHONE)/CarbonCore \
	-I$(INCLUDE_IPHONE)/CoreFoundation
endif
```
On Linux and Windows,you need use FLAT\_INCLUDES, so you must define INCLUDE\_IPHONE. This value defines the path of include directory in your iphone sdk. It would be great to define automatically INCLUDE\_IPHONE.

On MacOS X, with official SDK, you need insert these lines:
```
#
# iPod/iPhone
#
ifeq ($(AC_PJMEDIA_SND),ipod)
export SOUND_OBJS = iphonesound.o
export CFLAGS += -DPJMEDIA_SOUND_IMPLEMENTATION=PJMEDIA_SOUND_IPHONE_SOUND
endif
```



Generate configuration script
```
autoconf aconfigure.ac > aconfigure
```

## Compilation ##

Configure pjsip without codec except G711 and GSM:
```
./aconfigure --host=arm-apple-darwin8 \
  --disable-speex-aec --disable-speex-codec \
  --disable-l16-codec --disable-g722-codec  --disable-ilbc-codec
```


_We need to add GSM codec, because when the pjmedia-codec library is build, the **ar** command needs object file to exit without failure._

For official SDK, you need to replace **arm-apple-darwin8** by **arm-apple-darwin9**.

Compile the libraries:
```
make
```

_If you get an error with AVAILABLE\_MAC\_OS\_X\_VERSION\_10\_5\_AND\_LATER macro, you should update the AvailabilityMacros.h file in your sdk._

# Siphon Compilation #

## Getting siphon source code ##

Get Siphon from subversion repository:
```
svn checkout http://siphon.googlecode.com/svn/trunk/ siphon-read-only
```

## Installation pjsip ##

Create directory to install pjsip in Siphon:
```
mkdir -p pjsip/include
mkdir -p pjsip/lib
```

Put these pjsip include directories in the pjsip/include path:
  * pjlib/include
  * pjlib-util/include
  * pjmedia/include
  * pjnath/include
  * pjsip/include
Put these pjsip library directories in the pjsip/lib path:
  * pjlib/lib
  * pjlib-util/lib
  * pjmedia/lib
  * pjnath/lib
  * pjsip/lib
  * third\_party/lib

## Compilation ##

```
pushd settings
make
popd
pushd src
make
popd
```

For installation read the [Manual](ManualInstallation.md).