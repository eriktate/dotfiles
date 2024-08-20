# monitor setup

xrandr \
	--output HDMI-0 --primary --mode 3840x2160 --rate 60 --pos 0x1080 --scale 1x1 \
	--output DP-0 --mode 1920x1080 --rate 120 --pos 960x0 --scale 1x1

xset r rate 200 35 # keyrepeat
xset s off         # screen saver off
xset -dpms         # power saving off

# mouse speed
xinput --set-prop "pointer:Razer Razer Viper V3 Pro" "libinput Accel Speed" -1
