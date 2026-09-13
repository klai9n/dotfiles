
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1280@60",
    position = "0x0",
    scale    = "1.6",
})

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@60",
    position = "1200x0",
    scale    = "1",
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu = "rofi -show run"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
   hl.on("hyprland.start", function () 
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
   hl.exec_cmd("waybar & awww-daemon")
 end)


--------------------------------------------------------------------------------
---- ENVIRONMENT VARIABLES
--------------------------------------------------------------------------------

-- النظام والحررر العام
hl.env("MPD_HOST", "/run/user/1000/mpd/socket")
hl.env("EDITOR", "nvim")

-- المظهر والمؤشر (GTK & Cursor)
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- إجبار جميع البرامج على استخدام منصة Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- تحسين دعم مشاركة الشاشة (Discord, Google Meet, إلخ)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- الإعدادات العامة للنظام
hl.config({
  xwayland = {
    force_zero_scaling = true
  },
  ecosystem = {
    no_update_news = true
  }
})

--------------------------------------------------------------------------------
---- LOOK AND FEEL (Merged Styles + Preserved Animations)
--------------------------------------------------------------------------------

-- General, Decoration, and Misc Settings
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 0,
        col = {
            active_border = "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 15,
        rounding_power = 3,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 1,
            ignore_opacity = true,
            noise = 0.0117,
            contrast = 0.8916,
            brightness = 0.8172,
            xray = false,
            popups = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = true,
        anr_missed_pings = 3,
        on_focus_under_fullscreen = 1,
    },
})

--------------------------------------------------------------------------------
---- ANIMATIONS & CURVES (Preserved Intact)
--------------------------------------------------------------------------------

-- Default curves and animations
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",        style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",      style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",      style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

--------------------------------------------------------------------------------
---- LAYER RULES (UI Components Style)
--------------------------------------------------------------------------------

-- App Launcher (Rofi)
hl.layer_rule({
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0,
    animation = "slide bottom",
})

-- Top Bar & OSD Components
hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = { namespace = "swayosd" },
    blur = true,
    ignore_alpha = 0,
})

-- Notifications (SwayNC)
hl.layer_rule({
    match = { namespace = "swaync-control-center" },
    blur = true,
    ignore_alpha = 0.5,
    animation = "slide right",
})

hl.layer_rule({
    match = { namespace = "swaync-notification-window" },
    blur = true,
    ignore_alpha = 0.5,
})

--------------------------------------------------------------------------------
---- ENVIRONMENT VARIABLES FOR GUM STYLING
--------------------------------------------------------------------------------

hl.env("GUM_CONFIRM_PROMPT_FOREGROUND", "6")
hl.env("GUM_CONFIRM_SELECTED_FOREGROUND", "0")
hl.env("GUM_CONFIRM_SELECTED_BACKGROUND", "2")
hl.env("GUM_CONFIRM_UNSELECTED_FOREGROUND", "0")
hl.env("GUM_CONFIRM_UNSELECTED_BACKGROUND", "8")

--------------------------------------------------------------------------------
---- LAYOUTS CONFIGURATION
--------------------------------------------------------------------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


--------------------------------------------------------------------------------
---- INPUT & DEVICES CONFIGURATION
--------------------------------------------------------------------------------

hl.config({
    -- Cursor behavior
    cursor = {
        inactive_timeout = 2,
    },

    -- Keyboard, Mouse, and Touchpad settings
    input = {
        kb_layout = "us,ara",
        kb_options = "grp:alt_shift_toggle",

        follow_mouse = 1,
        numlock_by_default = true,

        -- Sensitivity for mouse / trackpad
        sensitivity = 0.40,

        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.4,
        },
    },

    -- Misc settings
    misc = {
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
    },
})

--------------------------------------------------------------------------------
---- GESTURES
--------------------------------------------------------------------------------

-- 3-finger horizontal swipe to switch workspaces
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
--------------------------------------------------------------------------------
---- KEYBINDINGS CONFIGURATION (Merged & Cleaned - Hyprland Lua)
--------------------------------------------------------------------------------

local mainMod = "SUPER"
local home = os.getenv("HOME")

-- Variables & Path definitions
local terminal = "kitty"
local browser = home .. "/.config/hypr/scripts/launch-browser"
local webapp = home .. "/.config/hypr/scripts/launch-webapp"
local rofi_dir = home .. "/.config/rofi/scripts"
local scr_dir = home .. "/.config/hypr/scripts"
local osd_client = 'swayosd-client --monitor "$(hyprctl monitors -j | jq -r \'.[] | select(.focused == true).name\')"'

-- =============================================================================
-- WINDOW MANAGEMENT & CORE ACTIONS (Dispatchers)
-- =============================================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close Active Window" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Float" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Pseudo Window" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle Split Direction" })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(scr_dir .. "/pop-window"), { description = "Pop window out (float & pin)" })

-- Navigation Focus (Arrow Keys)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }), { description = "Focus Previous Workspace" })

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Workspaces Switching & Moving 
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace (Scratchpad) & Mouse Control
--hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(terminal .. " --class=Wiremix -e wiremix"), { description = "Wiremix" })
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- تغيير الحجم
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -100, y = 0 }))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 100, y = 0 }))

-- =============================================================================
-- APPLICATION LAUNCHERS
-- =============================================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + q", hl.dsp.window.close()) 
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("kitty --class floating_term"), { description = "Floating Terminal" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"), { description = "File Manager" })
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"), { description = "Obsidian" })
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("uwsm app -- bitwarden-desktop"), { description = "Passwords" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("uwsm app -- zeditor"), { description = "Zed" })
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(terminal .. " -e lazydocker"), { description = "Docker" })
hl.bind("ALT + slash", hl.dsp.exec_cmd(terminal .. " -e btop"), { description = "Activity Manager" })
hl.bind("ALT + M", hl.dsp.exec_cmd(terminal .. " -e rmpc"), { description = "Music Player" })
hl.bind("ALT + Q", hl.dsp.exec_cmd(terminal .. " -e yazi"), { description = "Yazi File Manager" })
hl.bind("ALT + N", hl.dsp.exec_cmd(terminal .. " -e nvim"), { description = "Neovim" })
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("uwsm-app -- kitty --class floating_term"), { description = "Floating Terminal" })
hl.bind("ALT + A", hl.dsp.exec_cmd(rofi_dir .. "/advanced_downloader.sh"), { description = "Music Downloader" })

-- Web Applications
hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd(webapp .. ' "https://gemini.google.com"'), { description = "Gemini" })
hl.bind("ALT + C", hl.dsp.exec_cmd(webapp .. ' "https://calendar.google.com"'), { description = "Calendar" })
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(webapp .. ' "https://github.com/vyrx-dev"'), { description = "Github" })
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(webapp .. ' "https://mail.google.com/mail/u/1/"'), { description = "Gmail" })
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(webapp .. ' "https://youtube.com/"'), { description = "YouTube" })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(webapp .. ' "https://app.todoist.com"'), { description = "Todoist" })
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd(webapp .. ' "https://devhints.io/"'), { description = "DevHints" })
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd(webapp .. ' "https://mangalik.net/"'), { description = "Mangalik" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(webapp .. ' "https://mangatime.org/"'), { description = "MangaTime" })
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(webapp .. ' "http://127.0.0.1:4567/library"'), { description = "Library" })

-- =============================================================================
-- ROFI MENUS & SYSTEM CONTROLS
-- =============================================================================

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"), { description = "App Launcher" })
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(rofi_dir .. "/rofisearch"), { description = "Find" })
hl.bind("ALT + comma", hl.dsp.exec_cmd(rofi_dir .. "/clipboard"), { description = "Clipboard" })
hl.bind("ALT + period", hl.dsp.exec_cmd(rofi_dir .. "/emoji"), { description = "Emoji" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(rofi_dir .. "/rofibeats"), { description = "Rofibeats" })
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(rofi_dir .. "/power-profiles"), { description = "Power Profiles" })
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(rofi_dir .. "/powermenu"), { description = "Power Menu" })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(rofi_dir .. "/powermenu"), { description = "Power Menu", locked = true })

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(rofi_dir .. "/wifi.sh"), { description = "Wifi Menu" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { description = "Notification Centre" })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(terminal .. " --title webapp-install -e " .. scr_dir .. "/webapp-install"), { description = "Web App Install" })
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd(scr_dir .. "/toggle-waybar"), { description = "Toggle Waybar" })
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd(scr_dir .. "/nightlight"), { description = "Toggle Nightlight" })
hl.bind(mainMod .. " + CTRL + I", hl.dsp.exec_cmd(scr_dir .. "/toggle-idle"), { description = "Toggle Idle/Lock" })

-- Themes & Wallpapers (Direct Execution)
hl.bind(mainMod .. " + CTRL + SPACE", function()
    hl.exec_cmd(rofi_dir .. "/selectWall")
end, { description = "Matugen Themes Apply" })

hl.bind(mainMod .. " + ALT + SPACE", function()
    hl.exec_cmd(rofi_dir .. "/wallPicker")
end, { description = "Wallpaper Picker" })

hl.bind("CTRL + ALT + SPACE", function()
    hl.exec_cmd(scr_dir .. "/change-theme")
end, { description = "Select Theme Wall" })

hl.bind(mainMod .. " + CTRL + SHIFT + SPACE", function()
    hl.exec_cmd("symphony switch")
end, { description = "Theme Switcher" })

hl.bind(mainMod .. " + CTRL + SHIFT + BACKSPACE", function()
    hl.exec_cmd("symphony switch --random")
end, { description = "Random Theme Switcher" })

hl.bind(mainMod .. " + I", function()
    hl.exec_cmd(terminal .. " --title symphony-tui -e symphony-tui")
end, { description = "Symphony TUI" })

hl.bind(mainMod .. " + ALT + I", function()
    hl.exec_cmd(terminal .. " --title symphony-browse -e symphony browse")
end, { description = "Browse Themes" })

hl.bind(mainMod .. " + ALT + up", function()
    hl.exec_cmd(scr_dir .. "/cycle-wallpaper")
end, { description = "Theme Wallpapers" })

hl.bind(mainMod .. " + ALT + right", function()
    hl.exec_cmd(scr_dir .. "/cycle-wallpaper next")
end, { description = "Next Wallpaper" })

hl.bind(mainMod .. " + ALT + left", function()
    hl.exec_cmd(scr_dir .. "/cycle-wallpaper prev")
end, { description = "Previous Wallpaper" })

-- System Power / Utility
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(scr_dir .. "/lock-screen"), { description = "Lock Screen" })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.exec_cmd(scr_dir .. "/graceful-reboot"), { description = "Reboot" })
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(scr_dir .. "/toggle-terminal-transparency"), { description = "Terminal Transparency" })
hl.bind(mainMod .. " + CTRL + BACKSPACE", hl.dsp.exec_cmd(scr_dir .. "/toggle-focus"), { description = "Toggle Focus Mode" })

hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl kill"), { description = "Kill Application" })
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(rofi_dir .. "/keyhints"), { description = "Show Keybindings" })

-- Screenshots & Recording
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scr_dir .. "/screenshot"), { description = "Screenshot with editing" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(scr_dir .. "/screenshot smart clipboard"), { description = "Screenshot to clipboard" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(scr_dir .. "/screenrecord --with-desktop-audio"), { description = "Record Screen" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scr_dir .. "/screenrecord --with-microphone-audio"), { description = "Record + Mic" })
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(home .. "/Scripts/screenrecord --with-desktop-audio --with-microphone-audio --with-webcam"), { description = "Record + Mic + Webcam" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })

-- =============================================================================
-- HARDWARE & MULTIMEDIA KEYS
-- =============================================================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(osd_client .. " --brightness raise"), { description = "Brightness up" })
hl.bind(mainMod .. " + ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd(osd_client .. " --brightness lower"), { description = "Brightness down" })
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("ddcutil setvcp 10 + 10"), { description = "Monitor Brightness up" })
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("ddcutil setvcp 10 - 10"), { description = "Monitor Brightness down" })
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(scr_dir .. "/toggle-monitor"), { description = "Toggle Monitor Power" })

-- =============================================================================
-- WINDOW & LAYER RULES (Hyprland 0.55+ Lua Syntax)
-- =============================================================================

-- إصلاح بعض مشاكل السحب مع XWayland
hl.window_rule({
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = false,
    fullscreen = false,
    pin = false
  },
  no_focus = true
})

-- منع التطبيقات من التكبير التلقائي
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- الشفافية العامة: 97% للنوافذ النشطة و 90% للغير نشطة
hl.window_rule({ match = { class = ".*" }, opacity = "0.97 0.9" })

-- قواعد الطبقات (Layer Rules)
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

-- =============================================================================
-- Floating Windows Configuration & Tags
-- =============================================================================

-- تطبيق خصائص العوم لمصطلح الوسم floating-window
hl.window_rule({
  match = { tag = "floating-window" },
  float = true,
  center = true,
  size = { 1020, 500 }
})

-- إضافة الوسم +floating-window للتطبيقات المحددة
hl.window_rule({ match = { class = "^(floating_term)$" }, tag = "+floating-window" })
hl.window_rule({ match = { class = "(blueman-manager|localsend|Wiremix|nmgui)" }, tag = "+floating-window" })
hl.window_rule({ match = { title = "^(.*Network Manager.*)$" }, tag = "+floating-window" })
hl.window_rule({ match = { title = "(webapp-install|share)" }, tag = "+floating-window" })
hl.window_rule({
  match = {
    class = "(xdg-desktop-portal-gtk)",
    title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)"
  },
  tag = "+floating-window"
})

-- =============================================================================
-- Individual App Rules
-- =============================================================================

-- Symphony TUI
hl.window_rule({
  match = { title = "symphony-tui" },
  float = true,
  center = true,
  size = { 720, 580 }
})

-- Symphony Browse
hl.window_rule({
  match = { title = "symphony-browse" },
  float = true,
  center = true,
  size = { 1200, 750 }
})

-- Easyeffects
hl.window_rule({
  match = { class = "com.github.wwmm.easyeffects" },
  float = true,
  center = true,
  size = { 950, 850 }
})

-- Steam Rules
hl.window_rule({
  match = { class = "steam" },
  float = true,
  opacity = "1 1",
  idle_inhibit = "fullscreen"
})
hl.window_rule({
  match = { class = "steam", title = "Steam" },
  center = true,
  size = { 1100, 700 }
})
hl.window_rule({
  match = { class = "steam", title = "Friends List" },
  size = { 460, 800 }
})

-- Screensaver
hl.window_rule({
  match = { class = "Screensaver" },
  fullscreen = true,
  float = true,
  center = true
})

-- Bitwarden (إخفاء من مشاركة الشاشة)
hl.window_rule({ match = { class = "^(Bitwarden)$" }, no_screen_share = true })

-- =============================================================================
-- Browsers Configuration
-- =============================================================================

-- تصنيف المتصفحات
hl.window_rule({
  match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser|[mM]icrosoft-edge|Vivaldi-stable|helium)" },
  tag = "+chromium-based-browser"
})
hl.window_rule({
  match = { class = "([fF]irefox|zen|librewolf)" },
  tag = "+firefox-based-browser"
})

-- إجبار متصفحات الكروميوم على وضع التبليط (Tile) وتحديد الشفافية
hl.window_rule({ match = { tag = "chromium-based-browser" }, tile = true, opacity = "1 0.97" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "0.90" })

-- إيقاف الشفافية لمواقع الفيديو
hl.window_rule({
  match = { initial_title = "((?i)(?:[a-z0-9-]+\\.)*youtube\\.com_/|app\\.zoom\\.us_/wc/home)" },
  opacity = "1.0 1.0"
})

-- =============================================================================
-- Special Overlays & Tools
-- =============================================================================

-- Waydroid Configuration
hl.window_rule({ match = { class = "^(waydroid)$" }, tag = "+waydroid-app" })
hl.window_rule({
  match = { tag = "waydroid-app" },
  float = true,
  fullscreen = true,
  size = { "100%", "100%" },
  center = true
})

-- Webcam Overlay
hl.window_rule({
  match = { title = "WebcamOverlay" },
  float = true,
  pin = true,
  no_initial_focus = true,
  no_dim = true,
  move = { "100%-w-40", "100%-w-40" }
})

-- Picture-in-picture Overlays (PIP)
hl.window_rule({ match = { title = "(Picture.?in.?[Pp]icture)" }, tag = "+pip" })
hl.window_rule({
  match = { tag = "pip" },
  float = true,
  pin = true,
  size = { 600, 338 },
  keep_aspect_ratio = true,
  border_size = 0,
  opacity = "1 1",
  move = { "100%-w-40", "4%" }
})

-- Virtual Keyboard
hl.window_rule({
  match = { class = "^(virtual-keyboard)$" },
  float = true,
  center = true,
  size = { "90%", "40%" },
  pin = true,
  no_initial_focus = true
})

-- Zathura Reader Rules
hl.window_rule({ match = { class = "^(org.pwmt.zathura)$" }, tag = "+floating-window" })
hl.window_rule({ match = { class = "^(org.pwmt.zathura)$" }, opacity = "0.98 0.92" })

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
