#!/bin/bash
#
# Autostart run script for Kiosk mode, based on @AYapejian https://github.com/MichaIng/DietPi/issues/1737#issue-318697621
# - Please see /root/.chromium-browser.init (and /etc/chromium.d/custom_flags) for additional egl/gl init options

# Command line switches https://peter.sh/experiments/chromium-command-line-switches/
# --test-type gets rid of some of the chromium warnings that you may or may not care about in kiosk on a LAN
# --pull-to-refresh=1
# --ash-host-window-bounds="400,300"

#sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /root/.config/chromium/Default/Preferences
#sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /root/.config/chromium/Default/Preferences

# Resolution to use for kiosk mode, should ideally match current system resolution
RES_X=480
RES_Y=320

CHROMIUM_OPTS="--kiosk --no-first-run --check-for-update-interval=864000000 --noerrdialogs --disable-infobars --test-type --window-size=$RES_X,$RES_Y --start-fullscreen --start-maximized --window-position=0,0"
# If you want tablet mode, uncomment the next line.
#CHROMIUM_OPTS+=' --force-tablet-mode --tablet-ui'

# Add URL for first run:
URL="http://localhost:3000"
CHROMIUM_OPTS+=" --homepage $URL"

# Find absolute filepath location of Chromium binary.
FP_CHROMIUM=$(command -v chromium)
if [[ ! $FP_CHROMIUM ]]; then

	# Assume RPi
	FP_CHROMIUM="$(command -v chromium-browser)"

fi
#while ! wget -q --spider $URL; do
#    echo '!!!!  waiting for rd1 dashboard to launch...' && sleep 5;
#done
#killall -9 fbi
#sleep 3
#unclutter -idle 2 -display :0 -noevents -grab &
unclutter -idle 2 -noevents -grab &
printf "Starting chromium...\n\n\n\n"
echo $FP_CHROMIUM
echo $CHROMIUM_OPTS
$FP_CHROMIUM $CHROMIUM_OPTS
printf "Done loading chromium \n\n\n\n\n"
