hl.config({
	general = {
		border_size = 2,
		gaps_in = 5,
		gaps_out = 10,
		float_gaps = 6,
		resize_on_border = true,
		extend_border_grab_area = 8,
		hover_icon_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},

	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = false,
		},
		shadow = {
			enabled = false,
		},
	},

	group = {
		col = {
			border_active = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			border_inactive = "rgba(595959aa)",
		},
		groupbar = {
			font_size = 12,
			font_family = "monospace",
			font_weight_active = "ultraheavy",
			font_weight_inactive = "normal",
			indicator_height = 1,
			indicator_gap = 5,
			height = 22,
			gaps_in = 5,
			gaps_out = 0,
			text_color = "rgb(ffffff)",
			text_color_inactive = "rgba(ffffff90)",
			col = {
				active = "rgba(00000040)",
				inactive = "rgba(00000020)",
			},
			gradients = true,
			gradient_rounding = 0,
			gradient_round_only_edges = false,
		},
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "fr",
		kb_options = "grp:alt_shift_toggle",
		accel_profile = "flat",
		touchpad = {
			natural_scroll = true,
			disable_while_typing = false,
		},
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},

	scrolling = {
		column_width = 0.49,
	},

	master = {
		new_status = "master",
	},

	misc = {
		background_color = "rgb(000000)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_scale_notification = true,
		font_family = "Fira Code",
		focus_on_activate = true,
		anr_missed_pings = 3,
		on_focus_under_fullscreen = 1,
		initial_workspace_tracking = 0,
		allow_session_lock_restore = true,
		bell_sound = "none",
	},

	cursor = {
		hide_on_key_press = true,
		warp_on_change_workspace = 1,
	},

	render = {
		cm_auto_hdr = 0,
	},

	binds = {
		hide_special_on_workspace_change = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4.31, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.03, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.28, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.19, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.38, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.17, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.42, bezier = "quick" })
hl.animation({ leaf = "fadeSwitch", enabled = false })
hl.animation({ leaf = "layers", enabled = true, speed = 3.05, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.2, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.2, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.43, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.11, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false })
