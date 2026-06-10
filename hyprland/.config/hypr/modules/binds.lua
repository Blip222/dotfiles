require("modules.Presets")
--local wallset = require("wallset")
---------------------
---- MY PROGRAMS ----
---------------------


local terminal = "kitty"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" 

-- Standard Window Management & Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

-- FIXED: Replaced legacy "hl.dsp.window.close()" with official working syntax
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.kill())

hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-2/launcher.sh || pkill rofi"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) 
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("bash ~/.config/waybar/scripts/launch.sh"))

-- Arrow keys focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

--Shift Arrow keys to move windows
hl.bind(mainMod .. " + ALT + Left", hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + ALT + Right", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + ALT + Up", hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + ALT + Down", hl.dsp.window.move({ direction = "down" }))

---------------------
-------MENU's--------
---------------------

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("bash ~/.config/scripts/quickScripts.sh"))

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("zsh ~/.local/bin/wallset"))


---------------------
---- WORKSPACES -----
---------------------

-- Multi-workspace Iteration loops
for i = 1, 10 do
	local key = i % 10 
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Scratchpad (Fixed to prevent overlay conflicts with hy3 toggles)
hl.bind(mainMod .. " + ALT + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse navigation behaviors
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---------------------
---- MULTIMEDIA -----
---------------------

hl.bind("SHIFT + F3", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("SHIFT + F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("SHIFT + F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("SHIFT + F4", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("SHIFT + F6", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("SHIFT + F5", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Playerctl media mappings
hl.bind("End + D", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("End + space", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("End + A", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

---------------------
---- SCREENSHOTS ----
---------------------

hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprshot -m output"))


---------------------
-------Layouts-------
---------------------


hl.bind("SUPER" .. "+ L", function()
    -- spawn windows
    hl.dispatch(hl.dsp.exec_cmd("kitty"))
    hl.dispatch(hl.dsp.exec_cmd("firefox"))
    hl.dispatch(hl.dsp.exec_cmd("kitty -e yazi"))
    hl.dispatch(hl.dsp.exec_cmd("firefox"))

    -- apply layout
    hl.dispatch(hl.dsp.layout("lua:two_col_special"))
end)



