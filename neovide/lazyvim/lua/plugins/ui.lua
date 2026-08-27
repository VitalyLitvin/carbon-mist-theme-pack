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
      opts.sections.lualine_x = { "diagnostics", "filetype" }
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
}
