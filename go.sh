#!/bin/sh

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

#Setup environment
ENV=.hadk.env
if [ -f "$HOME/$ENV" ]; then 
rm ~/.hadk.env && ln -s $SCRIPTPATH/.hadk.env ~/.hadk.env 
    echo "Link $ENV updated."

else ln -s $SCRIPTPATH/.hadk.env ~/.hadk.env 
    echo "Link $ENV created." 
fi

MERSDK=.mersdk.profile
if [ -f "$HOME/$MERSDK" ]; then 
rm ~/.mersdk.profile && ln -s $SCRIPTPATH/.mersdk.profile ~/.mersdk.profile
    echo "Link $MERSDK updated."

else ln -s $SCRIPTPATH/.mersdk.profile ~/.mersdk.profile 
    echo "Link $MERSDK created." 
fi

MERUBU=.mersdkubu.profile
if [ -f "$HOME/$MERUBU" ]; then 
rm ~/.mersdkubu.profile && ln -s $SCRIPTPATH/.mersdkubu.profile ~/.mersdkubu.profile
    echo "Link $MERUBU updated."

else ln -s $SCRIPTPATH/.mersdkubu.profile ~/.mersdkubu.profile
    echo "Link $MERUBU created." 
fi

#Update ~/.hadk.env
#sed -i '1iexport RELEASE="3.3.0.16"' ~/.hadk.env
source $ENV
echo "Environment updated."

mkdir -p $MER_TMPDIR
mkdir -p $ANDROID_ROOT/.repo/local_manifests
cp $SCRIPTPATH/vince.xml $ANDROID_ROOT/.repo/local_manifests/$DEVICE.xml
echo "Target $DEVICE manifest copied to .repo/local_manifests"

#Download Setup MER SDK
cd $MER_TMPDIR
TARBALL=Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2 
curl -k -O -C - http://releases.sailfishos.org/sdk/installers/latest/$TARBALL

SDK_ROOT=$PLATFORM_SDK_ROOT/sdks/sfossdk
sudo rm -rf $SDK_ROOT
mkdir -p $SDK_ROOT
cd $SDK_ROOT
sudo tar --numeric-owner -p -xjf $MER_TMPDIR/$TARBALL

#Setup convenience bash aliases
echo "export PATH=$HOME/bin:$PATH" >> ~/.bashrc
echo "export ANDROID_ROOT=$MER_ROOT/android/droid" >> ~/.bashrc
echo "export PLATFORM_SDK_ROOT=$PLATFORM_SDK_ROOT" >> ~/.bashrc
echo "alias sfossdk=$SDK_ROOT/mer-sdk-chroot" >> ~/.bashrc

cd $HOME

#sudo chroot $SDK_ROOT sudo zypper ref -f
#sudo chroot $SDK_ROOT sudo zypper --non-interactive in bc pigz atruncate android-tools-hadk


echo "TBCC OS SDK setup complete. You can start TBCC OS SDK by simply typing sfossdk on your bash shell. Good Luck!"
exec bash