-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.opt.winblend = 12
vim.opt.pumblend = 12
vim.opt.cursorline = true
vim.opt.relativenumber = false

-- editorconfig: не навязываем end_of_line, формат строк берётся из самого
-- файла. Иначе в проектах с `end_of_line = crlf` (так делает JetBrains)
-- каждый LF-файл открывается как dos: gitsigns помечает изменёнными все
-- строки, а сохранение тихо переписывает файл в CRLF. Отступы и прочие
-- правила .editorconfig по-прежнему применяются.
require("editorconfig").properties.end_of_line = nil

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
  vim.o.linespace = 1

  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_cursor_short_animation_length = 0.03
  vim.g.neovide_cursor_trail_size = 0.6
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_scroll_animation_length = 0.2

  -- Стекло «как в репо»: сильная прозрачность окна — хром и панели
  -- (lazygit в том числе) становятся матовым стеклом над размытым
  -- рабочим столом. Neovide рисует фоны всех групп, кроме Normal, с
  -- neovide_opacity. Режимы — <leader>ug: умеренное стекло / выкл.
  vim.g.neovide_opacity = 0.15
  vim.g.neovide_normal_opacity = 1.0
  vim.g.neovide_window_blurred = true

  -- Отступы как в wezterm, дают рамку из размытого фона
  vim.g.neovide_padding_top = 14
  vim.g.neovide_padding_bottom = 12
  vim.g.neovide_padding_left = 18
  vim.g.neovide_padding_right = 18

  -- Сильный блюр плавающих окон (lazygit и попапы). CursorLine без фона,
  -- поэтому известный баг Neovide (размытие активной строки) не задевает.
  vim.g.neovide_floating_blur_amount_x = 24.0
  vim.g.neovide_floating_blur_amount_y = 24.0
  vim.g.neovide_floating_corner_radius = 0.15

  vim.g.neovide_hide_mouse_when_typing = true
  -- refresh_rate не задаём: с vsync (по умолчанию) Neovide показывает
  -- warning при старте; ProMotion и так даёт 120 Гц

  -- Левый Option = Meta: начинают работать <A-j>/<A-k> (перенос строк в
  -- LazyVim) и <A-стрелки>. Правый Option по-прежнему печатает спецсимволы.
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"

  -- Цвет курсора — по режиму (группы Cursor* в plugins/theme.lua).
  -- Плавное мигание требует blink*-параметров; формат blinkon500, без
  -- дефиса перед числом, иначе E548.
  vim.opt.guicursor = {
    "n-sm:block-Cursor",
    "v:block-CursorVisual",
    "c:block-CursorCommand",
    "i-ci-ve:ver25-CursorInsert",
    "r-cr-o:hor20-CursorReplace",
    "t:block-TermCursor",
    "a:blinkwait300-blinkon500-blinkoff300",
  }
end

-- Все цветовые переопределения жили здесь в ColorScheme-автокоманде и
-- конфликтовали с темой. Теперь они собраны в одном месте — в палитре и
-- groups nightfox (см. lua/plugins/ide.lua), общая рампа bg0–bg4 решает
-- согласованность сама: neo-tree, попапы, gitsigns, FloatBorder и т.д.
-- Курсив выключен через options.styles темы.
