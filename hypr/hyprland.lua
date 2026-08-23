-- Monitors

hl.monitor({
  output   = "HDMI-A-1",
  mode     = "2560x1440@144",
  position = "0x0",
  scale    = 1.25,
})

hl.monitor({
  output   = "DP-1",
  mode     = "2560x1440@100",
  position = "2048x96",
  scale    = 1.25,
})

-- workspaces

for i = 1, 9, 1 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = "HDMI-A-1"
  })
end

hl.workspace_rule({
  workspace = "10",
  monitor = "DP-1"
})


hl.env("GDK_SCALE", 1.25)
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- program defs
local terminal = "ghostty"

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)

hl.config({
  general = {
    gaps_in          = 4,
    gaps_out         = 8,
    border_size      = 1,
    col              = {
      active_border   = "rgba(7aa2f7FF)",
      inactive_border = "rgba(1a1b26FF)",
    },
    resize_on_border = false,
    allow_tearing    = false,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 12,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    blur             = {
      enabled = false,
    },
  },

  animations = {
    enabled = true,
  },

  xwayland = {
    force_zero_scaling = true
  },
})

-- Default curves and animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 0.51, stiffness = 100.0, dampening = 10.0 })

hl.animation({ leaf = "global", enabled = true, speed = 1.0, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 1.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 1.0, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.0, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.0, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.0, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.0, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.0, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 1.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 1.0, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.0, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.0, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.0, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.0, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.0, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.0, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1.0, bezier = "quick" })

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = true,
    middle_click_paste      = false
  },
})

hl.config({
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = -0.5, -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
    },
  },
})

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Return", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("noctalia msg session lock-and-suspend"))
hl.bind(mainMod .. " + CONTROL + Escape", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))


-- Move active window to a workspace
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
