-- UI polishing for a modern, muted Neovide look
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "carbonfox"
      opts.options.globalstatus = true
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }

      opts.sections = opts.sections or {}
      opts.sections.lualine_c = {
        {
          "filename",
          path = 1,
          symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]" },
        },
      }
      opts.sections.lualine_x = {
        "diagnostics",
        -- Горит, пока включены языковые серверы (<leader>cL, plugins/lsp.lua)
        {
          function()
            return "󰒋 LSP"
          end,
          cond = function()
            return vim.g.lsp_active == true
          end,
          color = "DiagnosticOk",
        },
        "filetype",
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.mode = "buffers"
      opts.options.separator_style = "slant"
      opts.options.always_show_bufferline = true
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icon = false
      opts.options.diagnostics = "nvim_lsp"
      opts.options.offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets = opts.presets or {}
      opts.presets.command_palette = true
      opts.presets.lsp_doc_border = true
      opts.presets.long_message_to_split = true
      opts.presets.bottom_search = false
    end,
  },




  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Направляющая текущего блока цветом по глубине (SnacksIndent1–8
      -- в plugins/theme.lua); обычные направляющие остаются серыми
      opts.indent = opts.indent or {}
      opts.indent.scope = vim.tbl_deep_extend("force", opts.indent.scope or {}, {
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },
      })

      opts.lazygit = opts.lazygit or {}
      -- Палитра lazygit = Carbon Mist. snacks резолвит fg/bg здесь только
      -- как имена hl-групп (hex напрямую не принимает); группы Lazygit*
      -- определены в plugins/theme.lua значениями палитры.
      opts.lazygit.theme = vim.tbl_deep_extend("force", opts.lazygit.theme or {}, {
        [241] = { fg = "LazygitFaint" }, -- второстепенный текст lazygit идёт цветом 241
        activeBorderColor = { fg = "LazygitBorderActive", bold = true },
        inactiveBorderColor = { fg = "LazygitBorder" },
        optionsTextColor = { fg = "LazygitMuted" },
        defaultFgColor = { fg = "LazygitText" },
        searchingActiveBorderColor = { fg = "LazygitSearch", bold = true },
        selectedLineBgColor = { bg = "LazygitSelected" },
        selectedRangeBgColor = { bg = "LazygitRange" },
        unstagedChangesColor = { fg = "LazygitUnstaged" },
        cherryPickedCommitBgColor = { fg = "LazygitCherryBg" },
        cherryPickedCommitFgColor = { fg = "LazygitCherryFg" },
      })
      opts.lazygit.win = vim.tbl_deep_extend("force", opts.lazygit.win or {}, {
        style = "terminal",
        -- Затемнение за панелью: без него сквозь стекло читается код
        -- редактора и панель с ним сливается
        backdrop = 95,
        border = "rounded",
        width = 0.94,
        height = 0.92,
        wo = {
          winhighlight = "Normal:LazygitPanel,FloatBorder:FloatBorder",
        },
      })
    end,
  },

}