#/home/pi/.config/lxsession/LXDE-pi/autostart
@sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/Default/Preferences && sed -i 's/"exit_type": "Crashed"/"exit_type": “Normal"/' ~/.config/chromium/Default/Preferences && \
chromium-browser --kiosk --no-first-run --check-for-update-interval=864000000 --noerrdialogs --disable-infobars --test-type --window-size=480,320 --start-fullscreen --start-maximized --window-position=0,0 /home/pi/rd1-boot/loading/index.html
