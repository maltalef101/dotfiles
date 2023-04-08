let is_tty1 = (^tty) == "/dev/tty1"
let xorg_running = (^pidof Xorg)

if $is_tty1 && xorg_running != 0 {
	 exec startx
}
