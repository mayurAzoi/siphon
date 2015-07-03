# Introduction #

Currently, pjsip 2.0 includes the video support, also we will use it. And we won't backport video support in pjsip 1.x branch.

We use three external libraries :
  * [libyuv](http://code.google.com/p/libyuv/)
  * [ffmpeg](http://ffmpeg.org/)
  * [libx264](http://www.videolan.org/developers/x264.html)
  * [libvpx](http://www.webmproject.org/code/releases/) (optional)
The statements to compile libyuv are described in this [site](http://code.google.com/p/libyuv/wiki/GettingStarted). Maybe your svn version is too old, in this case you can update svn by following the statements of [Jason McCreary](http://jason.pureconcepts.net/2012/10/updating-svn-mac-os-x/)'s blog.

The statements to compile ffmpeg and x264 libraries are given on this [site](https://github.com/rodisbored/ffmpeg_x264_iOS5_build).


Some statements to include VP8 support in pjsip are given on this [page](http://lists.pjsip.org/pipermail/pjsip_lists.pjsip.org/2012-November/015489.html).

# libx264 compilation #
```
#!/bin/sh

DEST=../iOS/video/iOS

VERSION="5.1"
SDK_VERSION="5.1"

DEVPATH=/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
#DEVPATH=/Developer/Platforms/iPhoneOS.platform/Developer


echo "Building armv7..."

export CC=${DEVPATH}/usr/bin/llvm-gcc

./configure --host=arm-apple-darwin \
    --sysroot=${DEVPATH}/SDKs/iPhoneOS${VERSION}.sdk \
    --prefix=$DEST \
    --extra-cflags='-arch armv7' \
    --extra-ldflags="-L${DEVPATH}/SDKs/iPhoneOS${SDK_VERSION}.sdk/usr/lib/system -arch armv7" \
    --enable-pic \
    --enable-static 

make && make install

echo "Installed: $DEST"
```
# ffmpeg compilation #

```
#!/bin/sh

DEST=../iOS/video/iOS

VERSION=5.1
IPHONEOS_DEPLOYMENT_TARGET=5.1  

DEVPATH=/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
#DEVPATH=/Developer/Platforms/iPhoneOS.platform/Developer

X264INCLUDE=${DEST}/include
X264LIB=${DEST}/lib

COMMONFLAGS="-miphoneos-version-min=$IPHONEOS_DEPLOYMENT_TARGET -arch armv7 "
CFLAGS="$CFLAGS $COMMONFLAGS -I$X264INCLUDE"
LDFLAGS="$LDFLAGS -L${DEVPATH}/SDKs/iPhoneOS${VERSION}.sdk/usr/lib/system $COMMONFLAGS -L$X264LIB"

export CC=${DEVPATH}/usr/bin/llvm-gcc
export RANLIB=${DEVPATH}/usr/bin/ranlib


echo "Building armv7..."

./configure \
    --cpu=cortex-a8 \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --enable-cross-compile \
    --arch=arm \
    --target-os=darwin \
    --cc=${CC} \
    --sysroot=${DEVPATH}/SDKs/iPhoneOS${VERSION}.sdk \
    --prefix=${DEST} \
    --enable-gpl \
    --disable-network \
    --disable-decoders \
    --disable-muxers \
    --disable-demuxers \
    --disable-devices \
    --disable-parsers \
    --disable-encoders \
    --disable-protocols \
    --disable-filters \
    --disable-bsfs \
    --enable-libx264 \
    --enable-encoder=libx264 \
    --enable-encoder=libx264rgb \
    --enable-decoder=h264 \
    --enable-encoder=h263 \
    --enable-decoder=h263 \
    --enable-gpl \
    --enable-pic \
    --disable-doc \
    --disable-ffplay \
    --disable-ffprobe
    
make & make install

echo "Installed: $DEST"
```

# vpx compilation #
```
#!/bin/sh

DEST=../iOS/video/iOS

VERSION=6.0 

DEVPATH=/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer

mkdir armv7_build

cd armv7_build

../configure --target=armv7-darwin-gcc \
     --prefix=${DEST} \
     --disable-install-bins \ 
     --libc=${DEVPATH}/SDKs/iPhoneOS${VERSION}.sdk

make & make install
```

# pjsip compilation #

You have to enable video support in _config\_site.h_:
```
#define PJMEDIA_HAS_VIDEO 1
```

## pjsip updates ##

### rules.mak ###

Add the directive for .mm files (line 147, after the .cpp directive) :

```

$(OBJDIR)/%$(OBJEXT): $(SRCDIR)/%.mm
	$(CC) $($(APP)_CFLAGS) \
		$(CC_OUT)$(subst /,$(HOST_PSEP),$@) \
		$(subst /,$(HOST_PSEP),$<)
```

### aconfigure.ac ###

Check the availability of libyuv and disable video support if libyuv is unavailable.

```
[line 637]
case $target in
+ arm-apple-darwin*)
+ 	LIBS="$LIBS -framework UIKit -framework OpenGLES"
+	;;
 *darwin*)
 	LIBS="$LIBS -framework Foundation -framework AppKit"
	;;
esac

+AC_ARG_WITH(libyuv,
+    AC_HELP_STRING([--with-libyuv=DIR],
+		   [Specify libyuv location (iOS only)]),
+    [],
+    [with_libyuv=no]
+    )
+    
+AC_ARG_ENABLE(libyuv,
+	AC_HELP_STRING([--disable-libyuv],
+			[Exclude libyuv support from the build (default: autodetect)]),
+	[if test "$enable_libyuv" = "no"; then
+	   AC_MSG_RESULT([Checking if libyuv support is disabled... yes])
+	   [ac_libyuv=no]
+	 fi],
+	[AC_MSG_RESULT([checking for libyuv installations...])
+	   SAVED_CFLAGS="$CFLAGS"
+	   SAVED_CPPFLAGS="$CPPFLAGS"
+	   SAVED_LDFLAGS="$LDFLAGS"
+	   SAVED_LIBS="$LIBS"
+	
+          if test "x$with_libyuv" != "xno" -a "x$with_libyuv" != "x"; then
+            CFLAGS="$CFLAGS -I$with_libyuv/include"
+            CPPFLAGS="$CFLAGS"
+            LDFLAGS="$LDFLAGS -L$with_libyuv/lib"
+            AC_MSG_RESULT([Using libyuv prefix... $with_libyuv])
+          fi  
+          AC_LANG(C++)              
+	   AC_SUBST(libyuv_h_present)
+	   AC_SUBST(libyuv_present)
+	   AC_CHECK_HEADER(libyuv.h,[libyuv_h_present=1])
+	   AC_CHECK_LIB(yuv,InitCpuFlags,[libyuv_present=1 && LIBS="$LIBS -lyuv"])
+          AC_LANG(C) 
+	   if test "x$libyuv_h_present" = "x1" -a "x$libyuv_present" = "x1"; then
+	     AC_MSG_RESULT([Checking if libyuv library is available... yes])
+            [ac_libyuv=yes]
+	   else
+	     AC_MSG_RESULT([Checking if libyuv library is available... no])
+            [ac_libyuv=no]
+	     CFLAGS="$SAVED_CFLAGS"
+	     CPPFLAGS="$SAVED_CPPFLAGS"
+	     LDFLAGS="$SAVED_LDFLAGS"
+	     LIBS="$SAVED_LIBS"
+	   fi])

if test "$enable_video" = "no"; then
  true;
```

```
[line 653]
	AC_SUBST(ac_ios_cflags)
+	if test "$ac_libyuv" = "yes"; then
	  SAVED_LIBS="$LIBS"

[line 665]
	    AC_MSG_RESULT([Checking if AVFoundation framework is available... no])
	  fi
+	else
+	  ac_pjmedia_video_has_ios=no
+	  AC_MSG_RESULT([libyuv library not found, video support disabled])
+	fi
	;;
  *darwin*)
```

Don't forget to rebuild aconfigure script:
```
autoconf aconfigure.ac > aconfigure
```

### iOS video device implementation ###

Remove ios\_dev.m file and download [pjmedia.zip](http://siphon.googlecode.com/files/pjmedia.zip) and unzip it into pjsip folder.

### pjmedia/build/os-auto.mak.in ###

```
#
# iOS video device
#
ifeq ($(AC_PJMEDIA_VIDEO),iphone_os)
- export PJMEDIA_VIDEODEV_OBJS += ios_dev.o
+ export PJMEDIA_VIDEODEV_OBJS += ShaderUtilities.o ios_rend_dev_gl.o
+ export PJMEDIA_VIDEODEV_OBJS += ios_cap_dev.o
endif
```

### pjmedia/src/pjmedia\_videodev/videodev.c ###

```
[line 96]
#if PJMEDIA_VIDEO_DEV_HAS_IOS
- pjmedia_vid_dev_factory* pjmedia_ios_factory(pj_pool_factory *pf);
+ pjmedia_vid_dev_factory* pjmedia_ios_rend_factory(pj_pool_factory *pf);
+ pjmedia_vid_dev_factory* pjmedia_ios_cap_factory(pj_pool_factory *pf);
#endif

[line 379]
#if PJMEDIA_VIDEO_DEV_HAS_IOS
-    vid_subsys.drv[vid_subsys.drv_cnt++].create = &pjmedia_ios_factory;
+    vid_subsys.drv[vid_subsys.drv_cnt++].create = &pjmedia_ios_cap_factory;
+    vid_subsys.drv[vid_subsys.drv_cnt++].create = &pjmedia_ios_rend_factory;
#endif
```

## iOS ##
```
./configure-iphone --prefix=./iOS --with-ffmpeg=../iOS/video/iOS  --with-libyuv=../iOS/video/iOS

make & make install
```
## Simulator ##
```
export ARCH="-arch i386"

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
export IPHONESDK=iPhoneSimulator6.0.sdk
export CC=${DEVPATH}/usr/bin/llvm-gcc
export CFLAGS="-O2 -m32 -miphoneos-version-min=5.0 -fobjc-abi-version=2 -fobjc-legacy-dispatch"
export LDFLAGS="-O2 -m32"

./configure-iphone --prefix=./Simulator --with-ffmpeg=../iOS/video/iOS --with-libyuv=../iOS/video/iOS

make & make install
```