-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Базовые IDE-привычки: сохранение из любого режима.
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file", silent = true })

if vim.g.neovide then
  vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<Esc><cmd>w<cr>", { desc = "Save file", silent = true })

  -- Буфер обмена как в macOS. "t" — чтобы Cmd+V работал и в lazygit/терминале.
  vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy", silent = true })
  vim.keymap.set({ "n", "v", "i", "c", "t" }, "<D-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { desc = "Paste", silent = true })

  -- Масштаб: Cmd+= / Cmd+- / Cmd+0 (сброс)
  local function zoom(factor)
    vim.g.neovide_scale_factor = factor and (vim.g.neovide_scale_factor or 1.0) * factor or 1.0
  end
  vim.keymap.set({ "n", "v", "i", "t" }, "<D-=>", function() zoom(1.1) end, { desc = "Zoom in" })
  vim.keymap.set({ "n", "v", "i", "t" }, "<D-->", function() zoom(1 / 1.1) end, { desc = "Zoom out" })
  vim.keymap.set({ "n", "v", "i", "t" }, "<D-0>", function() zoom() end, { desc = "Zoom reset" })

  -- Цикл прозрачности (по умолчанию — «как в репо»): сильное -> умеренное -> выкл.
  local glass_modes = {
    { o = 0.15, n = 1.0, name = "Стекло (как в репо)" },
    { o = 0.6, n = 0.94, name = "Стекло" },
    { o = 1.0, n = 1.0, name = "Без прозрачности" },
  }
  local glass_state = 1
  vim.keymap.set("n", "<leader>ug", function()
    glass_state = glass_state % #glass_modes + 1
    local m = glass_modes[glass_state]
    vim.g.neovide_opacity = m.o
    vim.g.neovide_normal_opacity = m.n
    vim.notify("Neovide: " .. m.name)
  end, { desc = "Toggle glass mode" })
end

-- Альтернатива для macOS: переключение между окнами без Ctrl+h/j/k/l
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left", silent = true })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down", silent = true })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up", silent = true })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right", silent = true })

-- Дополнительно: Alt+стрелки
vim.keymap.set("n", "<A-Left>", "<C-w>h", { desc = "Window left", silent = true })
vim.keymap.set("n", "<A-Down>", "<C-w>j", { desc = "Window down", silent = true })
vim.keymap.set("n", "<A-Up>", "<C-w>k", { desc = "Window up", silent = true })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { desc = "Window right", silent = true })

-- Переключение буферов (вкладок в привычном понимании IDE)
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })
