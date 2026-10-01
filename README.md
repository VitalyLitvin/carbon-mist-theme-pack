# Carbon Mist

[![License: MIT](https://img.shields.io/github/license/VitalyLitvin/carbon-mist-theme-pack)](LICENSE)
[![WezTerm](https://img.shields.io/badge/WezTerm-supported-blueviolet)](wezterm/wezterm.lua)
[![btop](https://img.shields.io/badge/btop-supported-blueviolet)](btop)
[![cava](https://img.shields.io/badge/cava-supported-blueviolet)](cava)
[![Neovide](https://img.shields.io/badge/Neovide%20%2F%20LazyVim-supported-blueviolet)](neovide)

Muted gray-blue desktop theme pack inspired by carbonfox + glassy Neovide.

## Included
- `neovide/lazyvim/` — LazyVim + Neovide config parts
- `wezterm/wezterm.lua`
- `cava/config`
- `btop/btop.conf`
- `btop/themes/carbonfox.theme`

## Install

### 1) LazyVim / Neovide
Copy files into your `~/.config/nvim/lua/`:
- `config/options.lua`
- `config/keymaps.lua`
- `config/autocmds.lua`
- `plugins/theme.lua`
- `plugins/ide.lua`
- `plugins/ui.lua`
- `plugins/lsp.lua`

Copy `neovide/lazyvim/lazyvim.json` to `~/.config/nvim/lazyvim.json` — LazyVim extras: neo-tree and language support for TypeScript, Vue, Tailwind, ESLint, Prettier, JSON, Docker.

Copy `neovide/config.toml` to `~/.config/neovide/config.toml` — transparent titlebar, `fork`.

### 2) WezTerm
Copy `wezterm/wezterm.lua` to:
- `~/.config/wezterm/wezterm.lua`

### 3) CAVA
Copy `cava/config` to:
- `~/.config/cava/config`

### 4) btop
Copy files:
- `btop/btop.conf` -> `~/.config/btop/btop.conf`
- `btop/themes/carbonfox.theme` -> `~/.config/btop/themes/carbonfox.theme`

## Notes
- Neovide glass: three modes cycled with `<leader>ug` — default is "как в репо" (0.15/1.0), moderate (0.6/0.94), off. Window color = theme bg1, padding and editor are one panel.
- lazygit panel: `backdrop 95` dims the editor behind the glass so it doesn't bleed through; window is 0.94×0.92.
- Palette v2 (Neovim): accents spread around the hue wheel at matched lightness (OKLCH L≈0.75–0.84, C≈0.07–0.095) on the unchanged graphite base — keywords lavender, imports orchid, tags/`return` rose, types/attributes sand, numbers/constants peach, strings sage, fields/params teal, functions periwinkle. Contrast on bg1 ≥ 7.8:1. Defined in `plugins/theme.lua`; WezTerm, btop and cava still use the v1 palette.
- Cursor color follows the mode (normal, insert, visual, replace, command, terminal); the current line number follows it too. The current-scope indent guide changes color with nesting depth.
- LSP on demand: servers are configured but don't start by themselves (tsserver alone takes ≈1 GB on a Nuxt project vs ~185 MB for Neovide). `<leader>cL` starts/stops them; the statusline shows `LSP` while they run.
- `.editorconfig` `end_of_line` is ignored — files keep their own line endings. Otherwise a JetBrains-style `end_of_line = crlf` opens every LF file as dos and gitsigns marks all lines as changed.
- Neovide keys: `Cmd+S` save, `Cmd+C` / `Cmd+V` copy/paste (paste works in lazygit too), `Cmd+=` / `Cmd+-` / `Cmd+0` zoom; left Option acts as Meta.
- Theme name: **Carbon Mist**.
