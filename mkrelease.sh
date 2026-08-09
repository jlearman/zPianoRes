#!/usr/bin/env bash

# After building Zynthian, copy build folder as Artifacts/zPianoRes.lv2,
# and run this script to build the release.

PLUGNAME=zPianoRes

ZYN=true
if [[ $1 == "-z" ]] ; then
    ZYN=true
    shift
fi

if $ZYN ; then
    VERSION=$(git describe --tags --abbrev=0)
else
    VERSION=$(IFS=$' \r\n' /mnt/c/Softs/JUCE/Projucer.exe --get-version $PLUGNAME.jucer)
    strip CRLF from Win version of Projucer
    VERSION=$(echo $VERSION | sed -e "s:\r::" -e "s:\n::" )
    VERSION="v$VERSION"
fi
read -p "Version = '$VERSION'. Hit ENTER to continue" ANSWER

if $ZYN ; then
    FORMAT=lv2
    ARCH=zyn-$FORMAT
    BUILDDIR=Artifacts
else
    FORMAT=vst3
    ARCH=win-x64-$FORMAT
    BUILDDIR=Builds/VisualStudio2026/x64/Release/VST3/
fi

ZIP=$PLUGNAME-$VERSION-$ARCH.zip

set -ex

if false && $ZYN ; then
    # for JUCE projects only, add priories to Juce-produced lv2 ttl file
    ./fixttl.sh Artifacts/$PLUGNAME.lv2/dsp.ttl > tmp
    mv tmp Artifacts/$PLUGNAME.lv2/dsp.ttl
fi

mkdir -p Artifacts
rm -f Artifacts/$ZIP
zip -r Artifacts/$ZIP presets/ir/

cd $BUILDDIR
zip -r $OLDPWD/Artifacts/$ZIP $PLUGNAME.$FORMAT
cd -

cd release-readme
zip -r $OLDPWD/Artifacts/$ZIP README-$ARCH.txt
