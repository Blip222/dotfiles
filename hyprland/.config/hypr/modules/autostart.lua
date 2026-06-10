-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
    hl.exec_cmd("hyprpm reload -n")
end)
hl.on("hyprland.start", function()
	--   hl.exec_cmd(terminal)
	hl.exec_cmd("nm-applet --indicator")
	--   hl.exec_cmd("waybar & hyprpaper & firefox")
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("swaync")
end)

