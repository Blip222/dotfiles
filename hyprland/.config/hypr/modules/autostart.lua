-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
end)
hl.on("hyprland.start", function()
	--   hl.exec_cmd(terminal)
	hl.exec_cmd("nm-applet --indicator")
	--   hl.exec_cmd("waybar & hyprpaper & firefox")
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("swaync")

	--quick shell fixes wish I could tell you how they worked{

	-- Update activation environment variables for DBus/Systemd
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY")

	-- Force system-isolated startup of the portal background services
	hl.exec_cmd("/usr/lib/xdg-desktop-portal &")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-gtk &")

	-- Launch your Quickshell framework environment
	--hl.exec_cmd("quickshell")
	--}
end)
