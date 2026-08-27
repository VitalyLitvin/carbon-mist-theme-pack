-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Базовые IDE-привычки: сохранение из любого режима.
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file", silent = true })

if vim.g.neovide then
  vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<Esc><cmd>w<cr>", { desc = "Save file", silent = true })
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
