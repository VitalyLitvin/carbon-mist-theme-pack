-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Номер текущей строки окрашивается цветом режима — тем же, что курсор
-- Neovide (группы Cursor* в plugins/theme.lua)
local mode_cursor = {
  n = "Cursor",
  i = "CursorInsert",
  v = "CursorVisual",
  V = "CursorVisual",
  ["\22"] = "CursorVisual",
  s = "CursorVisual",
  S = "CursorVisual",
  R = "CursorReplace",
  c = "CursorCommand",
  t = "TermCursor",
}
vim.api.nvim_create_autocmd({ "ModeChanged", "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("mode_line_nr", { clear = true }),
  callback = function()
    local group = mode_cursor[vim.api.nvim_get_mode().mode:sub(1, 1)] or "Cursor"
    local color = vim.api.nvim_get_hl(0, { name = group, link = false }).bg
    if color then
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
    end
  end,
})
