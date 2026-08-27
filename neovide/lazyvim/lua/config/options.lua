-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.opt.winblend = 12
vim.opt.pumblend = 12

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
  vim.g.neovide_cursor_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_opacity = 0.10
  vim.g.neovide_window_blurred = true
  vim.g.neovide_background_color = "#2b2b2b"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5
  vim.o.linespace = 1
  -- Cmd+V paste в Neovide
  vim.keymap.set({ "n", "v", "i", "c" }, "<D-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { noremap = true, silent = true })
end

-- Keep active/inactive windows visually identical and remove italic styles.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#2b2b2b" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#2b2b2b" })
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

