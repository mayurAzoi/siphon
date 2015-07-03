# Installation #

First, you should read [pjsip documentation](http://trac.pjsip.org/repos/wiki/Intel_IPP_Codecs), and certainly [Intel® documentation](http://software.intel.com/en-us/articles/intel-integrated-performance-primitives-for-mac-os-how-to-link-to-the-intel-ipp-for-mac-os-x-libraries-in-application/).

## Leopard instructions ##

### Download and install IPP and IPP samples ###
  1. Download Intel® C++ Compiler Professional Edition for Mac OS X and Intel® IPP samples from http://software.intel.com/en-us/articles/intel-software-evaluation-center/ and http://software.intel.com/en-us/intel-ipp/
  1. Mount the package (e.g. m\_cproc\_p\_11.1.080.dmg) and run the installer (m\_cproc\_p\_11.1.080.mpkg). The default installation options will install it to "/opt/intel/Compiler/" directory (e.g. "/opt/intel/Compiler/11.1/080/" in my case).
  1. Extract IPP samples to a directory (e.g. to "~/Desktop/ipp-samples").

### Build the IPP samples ###
  1. Go to the directory where IPP samples have been extracted to (e.g. ~/Desktop/ipp-samples).
  1. Go to speech-codecs folder.
  1. Open the readme.htm file, and follow the instructions there to build the samples from the source.

Once the build process done, you should have libusc.a file somewhere in a directory inside speech-codecs\_bin directory (in my case, it's in ~/Desktop/ipp-samples/speech-codecs/_bin/osx32\_icc111/lib directory). The directory name corresponds to the platform where the samples are built for. (Note: for IPP version 6, the bin folder has been renamed to _bin)._

If you have any problems with installing and/or building the IPP or IPP samples, please read the IPP documentation or contact Intel for support.

### Running "configure" with IPP support ###

The configure script need to be modified, find IPP\_FLAGS in configure (e.g. IPP\_LDFLAGS="-L$IPPROOT/sharedlib")
and replace by
```
if test x$IPP_LDFLAGS = x; then
   IPP_LDFLAGS="-L$IPPROOT/sharedlib"
fi
```
libguide, hhe default OpenMP runtime library for Intel IPP has been changed from libguide to libiomp. See the User Guide in the doc directory for more information.
```
IPP_LIBS="-lippsc -lipps -lippsr -lippcore -lguide"
LIBS="-lusc $LIBS"
IPP_LIBS="-lusc $IPP_LIBS"
```
becomes
```
IPP_LIBS="-lippsc -lipps -lippsr -lippcore -liomp5"
LIBS="-lusc $LIBS"
IPP_LIBS="-lspeech $IPP_LIBS"
```

replace
```
libusc.a
$IPPSAMPLES/speech-codecs/bin/*gcc*/lib
```
by
```
libspeech.a
$IPPSAMPLES/speech-codecs/_bin/*osx*/lib
```


The configure script needs to be invoked with the appropriate IPP options in order to set up IPP include and library paths.

For this tutorial, we'll use three environment variables to hold the location of IPP and IPP samples. Sample bash session to run the configure script:

```
cd /your/pjproject/directory
export IPPROOT=/opt/intel/Compiler/11.1/080/Frameworks/ipp
export IPPSAMPLES=~/Desktop/ipp-samples
export IPP_LDFLAGS="-L$IPPROOT/Libraries -L/opt/intel/Compiler/11.1/080/lib"
./configure --enable-ipp --with-ipp=$IPPROOT --with-ipp-samples=$IPPSAMPLES
```

Note that you still need to enable IPP support in your config\_site.h in order to use the IPP features. This will be explained in the next section.

# PJMEDIA Configuration #

read pjsip documentation (http://trac.pjsip.org/repos/wiki/Intel_IPP_Codecs#PJMEDIAConfiguration)

## Enable IPP Support ##

By default, IPP support is disabled in PJMEDIA. To enable IPP support, declare the following in your config\_site.h:
```
#define PJMEDIA_HAS_INTEL_IPP	1
#define PJ_HAS_FLOATING_POINT 0
```

Note that you still need to set this macro even after IPP has been enabled with the configure command.

If you want to compile with floating port support, you must enable it in config\_site.h and link with libimf (Not tested).

# Static Linking #

## Leopard instructions ##

Read [Intel® documentation](http://software.intel.com/en-us/articles/intel-integrated-performance-primitives-for-mac-os-how-to-link-to-the-intel-ipp-for-mac-os-x-libraries-in-application/)

# Setting DLL/Shared Library Path #

By default, the build process links with the IPP dynamic libraries. Because of this, you'd need to set the DLL/shared library path before running PJSIP application that links with Intel IPP.

## Setting up DYLD\_LIBRARY\_PATH ##

On MacOS, you'd need to add Intel IPP shared library location to your DYLD\_LIBRARY\_PATH environment variable:
```
export DYLD_LIBRARY_PATH=/opt/intel/Compiler/11.1/080/lib
```
