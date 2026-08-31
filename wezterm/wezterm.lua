local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- ── Core ──────────────────────────────────────────────────────────────
config.term = 'xterm-256color'
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.max_fps = 120
config.animation_fps = 60

-- ── Typography ────────────────────────────────────────────────────────
config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
  { family = 'Menlo' },
  { family = 'Apple Color Emoji' },
})
config.font_size = 16.0
config.line_height = 1.0
config.cell_width = 1.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- ── Window ────────────────────────────────────────────────────────────
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.94
config.macos_window_background_blur = 30
config.window_padding = { left = 18, right = 18, top = 14, bottom = 12 }
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true
config.scrollback_lines = 10000
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-- ── Cursor ────────────────────────────────────────────────────────────
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.cursor_thickness = 2

-- ── Carbonfox palette ─────────────────────────────────────────────────
local gh = {
  bg        = '#2a2a2a',
  bg_deep   = '#0f0f0f',
  bg_soft   = '#202020',
  bg_hover  = '#2a2a2a',
  border    = '#525253',
  fg        = '#f2f4f8',
  fg_bright = '#ffffff',
  fg_muted  = '#7b7c80',
  blue      = '#78A9FF',
  purple    = '#BE95FF',
  green     = '#25be6a',
  red       = '#EE5396',
  yellow    = '#08BDBA',
  cyan      = '#33B1FF',
}


config.colors = {
  foreground    = gh.fg,
  background    = gh.bg,
  cursor_bg     = gh.blue,
  cursor_fg     = gh.bg,
  cursor_border = gh.blue,
  selection_fg  = gh.fg_bright,
  selection_bg  = '#2a2a2a',
  scrollbar_thumb = gh.border,
  split         = gh.bg,

  ansi = {
    '#282828', gh.red, gh.green, gh.yellow,
    gh.blue, gh.purple, gh.cyan, '#dfdfe0',
  },
  brights = {
    '#525253', '#FF7EB6', '#42BE65', '#3DDBD9',
    '#A5C5FF', '#D4BBFF', '#7CC7FF', gh.fg_bright,
  },

  tab_bar = {
    background = gh.bg_deep,
    active_tab   = { bg_color = gh.bg,      fg_color = gh.fg_bright, intensity = 'Bold' },
    inactive_tab = { bg_color = gh.bg_deep, fg_color = gh.fg_muted },
    inactive_tab_hover = { bg_color = gh.bg_hover, fg_color = gh.fg },
    new_tab       = { bg_color = gh.bg_deep, fg_color = gh.fg_muted },
    new_tab_hover = { bg_color = gh.bg_hover, fg_color = gh.blue },
  },
}

config.window_frame = {
  font = wezterm.font({ family = 'SF Pro Text', weight = 'Medium' }),
  font_size = 12.0,
  active_titlebar_bg = gh.bg_deep,
  inactive_titlebar_bg = gh.bg_deep,
}

config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }

-- ── Tab bar ───────────────────────────────────────────────────────────
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

wezterm.on('format-tab-title', function(tab, _, _, _, hover)
  local title = tab.tab_title
  if not title or #title == 0 then
    title = tab.active_pane.title
  end
  title = title:gsub('^%s*(.-)%s*$', '%1')
  if #title > 22 then
    title = title:sub(1, 21) .. '…'
  end

  local bg, fg
  if tab.is_active then
    bg, fg = gh.bg, gh.fg_bright
  elseif hover then
    bg, fg = gh.bg_hover, gh.fg
  else
    bg, fg = gh.bg_deep, gh.fg_muted
  end

  return {
    { Background = { Color = gh.bg_deep } },
    { Foreground = { Color = bg } },
    { Text = '' },
    { Background = { Color = bg } },
    { Foreground = { Color = tab.is_active and gh.blue or gh.border } },
    { Text = ' ● ' },
    { Foreground = { Color = fg } },
    { Text = title .. ' ' },
    { Background = { Color = gh.bg_deep } },
    { Foreground = { Color = bg } },
    { Text = '' },
  }
end)

-- ── Keys ──────────────────────────────────────────────────────────────
config.keys = {
  { key = 'Enter', mods = 'CMD',       action = act.ToggleFullScreen },
  { key = 'd',     mods = 'CMD',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd',     mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w',     mods = 'CMD',       action = act.CloseCurrentPane { confirm = true } },
  { key = '[',     mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
  { key = ']',     mods = 'CMD',       action = act.ActivatePaneDirection 'Next' },
  -- Pane navigation (reliable on macOS, avoids Cmd+Arrow system conflicts)
  { key = 'LeftArrow',  mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CTRL|ALT', action = act.ActivatePaneDirection 'Down' },
  -- Tab navigation
  { key = 'LeftArrow',  mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  -- Window navigation (separate WezTerm windows, e.g. on different monitors)
  { key = 'LeftArrow',  mods = 'CMD|ALT', action = act.ActivateWindowRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|ALT', action = act.ActivateWindowRelative(1) },
  { key = 'k',     mods = 'CMD',       action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'f',     mods = 'CMD',       action = act.Search { CaseInSensitiveString = '' } },
}

return config
