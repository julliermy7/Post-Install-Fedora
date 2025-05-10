#!/usr/bin/env bash

## Adaptado para Fedora KDE Plasma por Julliermy
## Baseado no script original de Aditya Shakya

dir="$HOME/.config/polybar/shades/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Opções
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"

# Confirmação
confirm_exit() {
	rofi -dmenu \
        -no-config \
		-i \
		-no-fixed-num-lines \
		-p "Are you sure? :" \
		-theme "$dir/confirm.rasi"
}

# Mensagem
msg() {
	rofi -no-config -theme "$dir/message.rasi" -e "Available Options - yes / y / no / n"
}

# Variável passada para o rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"

case $chosen in
    $shutdown)
		ans=$(confirm_exit)
		if [[ $ans =~ ^(yes|y|YES|Y)$ ]]; then
			systemctl poweroff
		elif [[ $ans =~ ^(no|n|NO|N)$ ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit)
		if [[ $ans =~ ^(yes|y|YES|Y)$ ]]; then
			systemctl reboot
		elif [[ $ans =~ ^(no|n|NO|N)$ ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
		# KDE Plasma lockscreen
		loginctl lock-session
        ;;
    $suspend)
		ans=$(confirm_exit)
		if [[ $ans =~ ^(yes|y|YES|Y)$ ]]; then
			mpc -q pause 2>/dev/null
			amixer set Master mute
			systemctl suspend
		elif [[ $ans =~ ^(no|n|NO|N)$ ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $logout)
		ans=$(confirm_exit)
		if [[ $ans =~ ^(yes|y|YES|Y)$ ]]; then
			qdbus org.kde.ksmserver /KSMServer logout 0 0 0
		elif [[ $ans =~ ^(no|n|NO|N)$ ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
