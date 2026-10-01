-- ── LSP по требованию ────────────────────────────────────────────────────
-- Языковые серверы — главный потребитель памяти: в Nuxt-проекте tsserver
-- (через vtsls) занимает ≈ 1.2 ГБ при ~185 МБ на сам Neovide. Поэтому они
-- настроены как обычно (LazyVim + extras в lazyvim.json), но сами не
-- стартуют: <leader>cL поднимает их для открытых буферов, повторное
-- нажатие гасит и отдаёт память. В статусной строке горит «LSP», пока
-- серверы включены.
--
-- Шлагбаум стоит на vim.lsp.start: через него Neovim запускает любой
-- сервер (vim.lsp.enable, mason-lspconfig, setup-функции extras).

local function toggle_lsp()
  vim.g.lsp_active = not vim.g.lsp_active
  if vim.g.lsp_active then
    -- Поднять серверы для уже открытых буферов; если lspconfig ещё не
    -- загружен (нет открытых файлов), они стартуют при открытии файла
    pcall(vim.cmd.doautoall, "nvim.lsp.enable FileType")
    vim.notify("LSP включён")
  else
    for _, client in ipairs(vim.lsp.get_clients()) do
      client:stop()
    end
    vim.notify("LSP выключен, память освобождена")
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.g.lsp_active = false
      local start = vim.lsp.start
      vim.lsp.start = function(...)
        if vim.g.lsp_active then
          return start(...)
        end
      end
    end,
    keys = {
      { "<leader>cL", toggle_lsp, desc = "Toggle LSP (по требованию)" },
    },
    opts = {
      servers = {
        -- PHP / Laravel. Не extra lang.php: тот ставит phpcs и php-cs-fixer,
        -- которым нужен локальный PHP, а PHP живёт в Docker.
        -- intelephense работает на Node.
        intelephense = {},
      },
    },
  },
}
