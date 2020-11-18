
function hadk() { source $HOME/.hadk.env; echo "Env setup for $DEVICE"; }
export PS1="HABUILD_SDK [\${DEVICE}] $PS1"
hadk

sdk_prompt() { echo "$1: enter PLATFORM_SDK first by pressing CTRL + D & try again!"; }
alias hh="mka hybris-hal"
alias hb="mka hybris-boot"
alias clean="mka clean"

if [ -f build/envsetup.sh ]; then
	echo "$ source build/envsetup.sh"
	source build/envsetup.sh
	echo "$ breakfast $DEVICE"
	breakfast $DEVICE
	echo "$ export USE_CCACHE=1"
	export USE_CCACHE=1
fi