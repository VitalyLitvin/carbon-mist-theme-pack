-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.opt.winblend = 12
vim.opt.pumblend = 12
vim.opt.cursorline = true

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
  vim.o.linespace = 1

  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_cursor_short_animation_length = 0.03
  vim.g.neovide_cursor_trail_size = 0.6
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_scroll_animation_length = 0.2

  -- Матовое стекло: окно прозрачнее, контент плотнее
  vim.g.neovide_opacity = 0.5
  vim.g.neovide_normal_opacity = 0.75
  vim.g.neovide_window_blurred = true

  -- Отступы как в wezterm, дают рамку из размытого фона
  vim.g.neovide_padding_top = 14
  vim.g.neovide_padding_bottom = 12
  vim.g.neovide_padding_left = 18
  vim.g.neovide_padding_right = 18

  -- Мягкие скруглённые плавающие окна
  vim.g.neovide_floating_blur_amount_x = 18.0
  vim.g.neovide_floating_blur_amount_y = 18.0
  vim.g.neovide_floating_corner_radius = 0.15

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5

  -- Плавное мигание курсора требует blink*-параметров в guicursor
  vim.opt.guicursor = {
    "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20",
    "a:blinkon-500-blinkoff-300-blinkwait-300",
  }

  -- При желании: эффекты за курсором ("ripple", "torpedo", "pixiedust", ...)
  -- vim.g.neovide_cursor_vfx_mode = "ripple"

  -- Cmd+V paste в Neovide
  vim.keymap.set({ "n", "v", "i", "c" }, "<D-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { noremap = true, silent = true })
end

-- Keep active/inactive windows visually identical and remove italic styles.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#4a5260" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#4a5260" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#575f6e" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#4a5260", bg = "#4a5260" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#a5c5ff", bold = true })
    local no_italic = {
      "Comment", "SpecialComment", "Keyword", "Conditional", "Repeat", "Label",
      "Operator", "Exception", "Include", "Define", "PreProc", "Type", "Function",
      "@comment", "@comment.documentation", "@keyword", "@keyword.function", "@keyword.return",
    }
    for _, group in ipairs(no_italic) do
      pcall(vim.api.nvim_set_hl, 0, group, { italic = false })
    end
  end,
})
