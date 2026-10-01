-- ── Тема Carbon Mist: carbonfox + своя палитра под стекло Neovide ─────────
--
-- База (графитовая рампа bg1–bg4, fg, comment) прежняя, подобрана на глаз.
-- Акценты v2 разнесены по всему кругу оттенков при близкой светлоте
-- (OKLCH L≈0.75–0.84, C≈0.07–0.095): роли кода различаются цветом, а не
-- только яркостью, и при этом остаются приглушёнными. Контраст на bg1 —
-- от 7.8:1, на панели lazygit — от 4.5:1.
--
-- base/bright/dim заданы явно: если передать nightfox строку, он меняет
-- только base, а bright/dim остаются от ярких IBM-цветов carbonfox (на них
-- завязаны функции, константы и условия).

-- stylua: ignore
local mist = {
  red     = { base = "#e295a6", bright = "#f4a9b9", dim = "#a86776" }, -- роза: теги, return/this, ошибки
  orange  = { base = "#e6ac86", bright = "#f8c09b", dim = "#ae7d5c" }, -- персик: числа, константы, true/false
  yellow  = { base = "#e0c88e", bright = "#f3dca4", dim = "#ab9664" }, -- песок: типы, атрибуты, warn, git change
  green   = { base = "#9bc99b", bright = "#afdcb0", dim = "#6e956e" }, -- шалфей: строки, git add, insert
  cyan    = { base = "#86cccf", bright = "#9ddfe2", dim = "#5c989b" }, -- бирюза: поля, параметры, модули
  blue    = { base = "#93b6eb", bright = "#a7c9fc", dim = "#6685b1" }, -- барвинок: функции, папки, normal
  magenta = { base = "#baa4e5", bright = "#cdb7f6", dim = "#8874ac" }, -- лаванда: ключевые слова, visual
  pink    = { base = "#e0a5cc", bright = "#f3bade", dim = "#a97798" }, -- орхидея: import/export, декораторы
}

-- stylua: ignore
local base = {
  bg1 = "#161616", bg2 = "#1d1d1d", bg3 = "#232323", bg4 = "#3a3a3a",
  fg1 = "#e0e3e8", fg2 = "#b4bac3", fg3 = "#7f8792",
  comment = "#6f7782",
  sel0 = "#252525", sel1 = "#393939",
}

return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      local C = require("nightfox.lib.color")
      -- Подложка виртуального текста диагностик: nightfox считает её от
      -- исходных цветов spec, поэтому для переназначенных warn/hint — вручную.
      local function tint(hex)
        return C(base.bg1):blend(C(hex), 0.15):to_css()
      end

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
          carbonfox = vim.tbl_extend("force", base, mist),
        },
        specs = {
          carbonfox = {
            -- Роли, которые в carbonfox сливались (функции и поля были
            -- оттенками одного синего, конструкторы — как поля)
            syntax = {
              func = "blue.base",
              field = "cyan.base",
              ident = "yellow.bright", -- конструкторы и компоненты — родня типов
              preproc = "pink.base", -- import / export / from
            },
            -- В carbonfox warn был лавандовым, hint — бирюзовым «orange»
            diag = { warn = "yellow.base", hint = "cyan.base" },
            diag_bg = { warn = tint(mist.yellow.base), hint = tint(mist.cyan.base) },
          },
        },
        groups = {
          carbonfox = {
            -- У текущей строки нет своего фона: при прозрачности Neovide
            -- любой фон строки «проваливался» бы сквозь блюр. Позицию
            -- показывает номер строки — он окрашивается цветом режима
            -- (см. autocmds.lua), как курсор и секция режима в lualine.
            CursorLine = { bg = "NONE" },
            CursorLineNr = { fg = mist.blue.bright, style = "bold" },

            -- Курсор Neovide по режимам (guicursor в options.lua)
            Cursor = { fg = base.bg1, bg = mist.blue.bright },
            CursorInsert = { fg = base.bg1, bg = mist.green.base },
            CursorVisual = { fg = base.bg1, bg = mist.magenta.base },
            CursorReplace = { fg = base.bg1, bg = mist.red.base },
            CursorCommand = { fg = base.bg1, bg = mist.yellow.base },
            TermCursor = { fg = base.bg1, bg = mist.orange.base },

            -- Разметка (JSX/Vue/Blade): теги — роза, атрибуты — песок,
            -- уголки </> приглушены. Курсив у атрибутов nightfox задаёт
            -- в обход options.styles, снимаем явно.
            ["@tag"] = { fg = mist.red.base },
            ["@tag.builtin"] = { fg = mist.red.base },
            ["@tag.attribute"] = { fg = mist.yellow.base, style = "NONE" },
            ["@tag.delimiter"] = { fg = base.fg3 },

            -- Направляющая текущего блока меняет цвет с глубиной
            -- вложенности (snacks indent, см. ui.lua)
            SnacksIndent1 = { fg = mist.blue.dim },
            SnacksIndent2 = { fg = mist.magenta.dim },
            SnacksIndent3 = { fg = mist.cyan.dim },
            SnacksIndent4 = { fg = mist.yellow.dim },
            SnacksIndent5 = { fg = mist.green.dim },
            SnacksIndent6 = { fg = mist.pink.dim },
            SnacksIndent7 = { fg = mist.orange.dim },
            SnacksIndent8 = { fg = mist.red.dim },

            -- Панель lazygit — прежние «стеклянные» цвета: при сильном
            -- стекле окна сквозь неё просвечивает размытый рабочий стол
            -- (см. screenshots/lazygit.png в репо темы)
            LazygitPanel = { bg = "#38404e", fg = "#f2f4f8" },
            LazygitSelected = { bg = "#4a6db3" },
            -- Цвета для lazygit: snacks разрешает fg/bg в своей theme только
            -- как имена групп (hex напрямую не принимает), поэтому значения
            -- палитры прячем за именами.
            LazygitText = { fg = base.fg1 },
            LazygitMuted = { fg = base.fg3 },
            LazygitFaint = { fg = base.comment },
            LazygitBorder = { fg = "#5d6a7d" },
            LazygitBorderActive = { fg = mist.blue.bright },
            LazygitSearch = { fg = mist.cyan.base },
            LazygitRange = { bg = "#3c4a63" },
            LazygitUnstaged = { fg = mist.red.base },
            LazygitCherryBg = { fg = "#3c4a63" },
            LazygitCherryFg = { fg = mist.pink.base },
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
}
