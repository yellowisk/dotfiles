-- Hyprland Configuration (migrated from hyprland.conf)
-- https://wiki.hypr.land/Configuring/

require("dms.colors")
require("dms.outputs")
require("dms.cursor")
require("dms.binds-user")
require("dms.windowrules")

-- ==================
-- XWAYLAND
-- ==================
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- ==================
-- STARTUP APPS
-- ==================
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd([[bash -c "wl-paste --watch cliphist store &"]])
end)

-- ==================
-- INPUT CONFIG
-- ==================
hl.config({
	input = {
		kb_layout = "us,br",
		kb_variant = ",abnt2",
		kb_options = "grp:alt_shift_toggle",
		numlock_by_default = true,
		touchpad = {
			scroll_factor = 0.75,
			natural_scroll = true,
		},
	},
})

-- ==================
-- GENERAL LAYOUT
-- ==================
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = { colors = { "rgb(94e2d5)", "rgb(cba6f7)" }, angle = 45 },
			inactive_border = "rgba(d0d0d0ff)",
		},
		layout = "dwindle",
	},
})

-- ==================
-- DECORATION
-- ==================
hl.config({
	decoration = {
		rounding = 12,
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		shadow = {
			enabled = true,
			range = 30,
			render_power = 5,
			offset = { 0, 5 },
			color = "rgba(00000070)",
		},
	},
})

-- ==================
-- ANIMATIONS
-- ==================
hl.config({
	animations = {
		enabled = true,
	},
})

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

-- ==================
-- LAYOUTS
-- ==================
hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		mfact = 0.5,
	},
})

-- ==================
-- MISC
-- ==================
hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 1,
	},
})
