-- Monitor and workspace-to-monitor assignments
-- Migrated from hyprland.conf MONITOR CONFIG / DUAL MONITOR (TEMPORARY) blocks.

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.5",
})

-- DUAL MONITOR (TEMPORARY) — remove this block when unplugging HDMI-A-1
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
