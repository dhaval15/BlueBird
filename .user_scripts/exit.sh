ANS=$(echo "Lock|Logout|Hibernate|Reboot|Shutdown" | \
                rofi -sep "|" -dmenu -i -p '' "" -width 20 \
                -hide-scrollbar -eh 1 -line-padding 4 -padding 50 -lines 4 -theme "exit")
            case "$ANS" in
                *Lock) dm-tool lock;;
		*Hibernate) systemctl hibernate;;
                *Logout) awesome-client "awesome.quit()"; fluxbox-remote "exit";;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl poweroff
            esac
