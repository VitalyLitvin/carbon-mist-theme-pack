-- Мини-IDE поверх LazyVim: файловое дерево слева + инструменты для git.
-- Многое LazyVim уже даёт из коробки (lazygit, gitsigns) — здесь только
-- добавления и настройки под «классический» IDE-вид.

return {
  -- ── Подсветка синтаксиса для Laravel/Blade/JS/Vue/Nuxt ───────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local parsers = {
        "php",
        "blade",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "json",
        "html",
        "css",
        "scss",
        "bash",
        "yaml",
      }
      for _, parser in ipairs(parsers) do
        if not vim.tbl_contains(opts.ensure_installed, parser) then
          table.insert(opts.ensure_installed, parser)
        end
      end
    end,
  },
  -- Фолбэк-подсветка Blade-шаблонов.
  { "jwalton512/vim-blade" },

  -- ── Тема: Carbonfox ───────────────────────────────────────────────────────
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          dim_inactive = false,
          styles = {
            comments = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
        },
        palettes = {
          carbonfox = {
            bg1 = "#161616",
            bg2 = "#1d1d1d",
            bg3 = "#232323",
            bg4 = "#3a3a3a",
            fg1 = "#e0e3e8",
            fg2 = "#b4bac3",
            fg3 = "#7f8792",
            comment = "#6f7782",
            red = "#b9829e",
            green = "#7ea586",
            yellow = "#6ea4ad",
            blue = "#7f9fc8",
            magenta = "#9f90c6",
            cyan = "#74a9c0",
            orange = "#8eaac7",
            pink = "#c09fcb",
            sel0 = "#252525",
            sel1 = "#393939",
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },

  -- ── Git: усиливаем gitsigns и добавляем helper-плагины ──────────────────
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 350,
        virt_text_pos = "eol",
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "󰍵" },
        topdelete = { text = "󰍵" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
    keys = {
      { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>ghb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame line" },
      { "<leader>ghB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
      { "<leader>ghd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this file" },
      { "<leader>ghD", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff against HEAD" },
      { "<leader>ght", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle git signs" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
    },
    keys = {
      { "<leader>gc", "", desc = "+conflicts" },
      { "<leader>gcc", "<cmd>GitConflictChooseCurrent<cr>", desc = "Choose current" },
      { "<leader>gcin", "<cmd>GitConflictChooseIncoming<cr>", desc = "Choose incoming" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous conflict" },
    },
  },
  {
    "tpope/vim-rhubarb",
    event = "VeryLazy",
  },
  -- ── Файловый сайдбар слева (neo-tree вместо snacks-explorer) ───────────
  -- Подключаем официальный LazyVim-extra: он вешает <leader>e / <leader>fe
  -- на neo-tree и корректно отключает дефолтный explorer.
  { import = "lazyvim.plugins.extras.editor.neo-tree" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- закрыть neo-tree, если это последнее окно
      window = {
        position = "left",
        width = 32,
      },
      filesystem = {
        follow_current_file = { enabled = true }, -- подсвечивать открытый файл в дереве
        use_libuv_file_watcher = true,            -- авто-обновление при изменениях на диске
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          hide_dotfiles = false, -- показывать .env, .gitignore и т.п.
          hide_gitignored = false, -- показывать .env и другие gitignored файлы
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },

  -- ── Поиск: показывать hidden/gitignored файлы в snacks picker ───────────
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.files = vim.tbl_deep_extend("force", opts.picker.sources.files or {}, {
        hidden = true,
        ignored = true,
      })
      opts.picker.sources.grep = vim.tbl_deep_extend("force", opts.picker.sources.grep or {}, {
        hidden = true,
        ignored = true,
      })
      opts.picker.sources.projects = vim.tbl_deep_extend("force", opts.picker.sources.projects or {}, {
        dev = { "~/Desktop/gitlab.mgfdev.ru/iac", "~/Desktop/aviatickets" },
        projects = { "/Users/im/Desktop/gitlab.mgfdev.ru/iac/flomarket-front" },
        recent = true,
      })
    end,
  },

  -- ── Git: diffview для просмотра диффов и истории ───────────────────────
  -- Дополняет lazygit (<leader>gg) и gitsigns (<leader>gh… — hunk-операции).
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Gblame" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (Fugitive)" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame (buffer)" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>go", "<cmd>GBrowse<cr>", desc = "Open on remote" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "", desc = "+diffview" },
      { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Открыть diff (working tree)" },
      { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Закрыть diffview" },
      { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "История текущего файла" },
      { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "История репозитория" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
  },
}
