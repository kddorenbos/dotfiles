waybar &
#hyprpaper &
awww init &
sleep 1
awww-daemon --format xrgb &
#swww img ~/Downloads/4K-Beautiful-Desktop-Wallpaper-Colorful-Nature-Sunset-Landscape-Free-Download-2048x1152.jpg &
awww img Backgrounds/$(ls Backgrounds | shuf -n 1)
udiskie &
hyprctl dispatch workspace 1 &
gammastep -l manual:52.396610811891364:5.302530895614405 -t 6500K:4000K &
#shutdown 21:30 &
mpd &
#swayidle -w timeout 600 'swaylock -f' timeout 10 'hyprctl dispatch dpms off eDP-1' resume 'hyprctl dispatch dpms on' &
#kitty -d ~/Documents/notes --class float nvim ~/Documents/notes/index.md
