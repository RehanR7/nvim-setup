# My Neovim Config — Full Guide

A from-scratch Neovim setup (Neovim **0.12+**, `lazy.nvim`, Lua). Built for Python-heavy work
(the `novbot` / `nov_scraper` project: Python, JSON, Markdown, CSS, SQLite3), with Git, LSP, formatting,
and AI inline completion.

This file answers three questions for someone who only opens Neovim now and then:

1. **What are the keys?** → [Cheat sheet](#1-cheat-sheet-the-keys-you-actually-use) and [full keymap reference](#4-full-keymap-reference)
2. **What is installed and why?** → [Plugins](#6-plugins-what-each-one-does)
3. **What are my settings?** → [Options](#5-settings-optionslua-explained)

> **Lost? Press `Space` and wait half a second.** which-key shows every leader shortcut available from that point.
> `Space f` → shows all the Find commands, `Space g` → Git, and so on.

Last updated: 2026-10-31 (tested on Neovim 0.12.4).

---

## Contents

1. [Cheat sheet](#1-cheat-sheet-the-keys-you-actually-use)
2. [Vim survival guide](#2-vim-survival-guide-the-basics-you-forget)
3. [How to find a key you forgot](#3-how-to-find-a-key-you-forgot)
4. [Full keymap reference](#4-full-keymap-reference)
5. [Settings (`options.lua`) explained](#5-settings-optionslua-explained)
6. [Plugins: what each one does](#6-plugins-what-each-one-does)
7. [Languages, LSP, formatting](#7-languages-lsp-formatting-and-treesitter)
8. [Everyday workflows](#8-everyday-workflows)
9. [Maintenance](#9-maintenance-updating-adding-restoring)
10. [Troubleshooting](#10-troubleshooting)
11. [Health-check warnings you can ignore](#11-health-check-warnings-you-can-ignore)
12. [Design decisions and conventions](#12-design-decisions-and-conventions)
13. [Changelog](#13-changelog)
14. [Setting up on a new machine](#14-setting-up-on-a-new-machine)

---

## 1. Cheat sheet: the keys you actually use

**Leader key = `Space`.** (`<leader>` below means press `Space`.)

| I want to… | Keys |
|---|---|
| Save | `:w` ⏎ (auto-formats on save) |
| Save and quit / quit / quit without saving | `:wq` / `:q` / `:q!` |
| Open / close the file tree | `<leader>e` |
| Find a file by name | `<leader>ff` |
| Search text in all files | `<leader>fg` |
| Switch between open files | `<leader>fb` |
| Search the help | `<leader>fh` |
| List all TODO/FIXME comments | `<leader>ft` |
| Go to definition / back | `gd` / `Ctrl-o` |
| Find all references | `grr` |
| Show docs under cursor | `K` |
| Rename a symbol everywhere | `<leader>lr` |
| Code actions (quick fixes) | `<leader>la` |
| Format the file now | `<leader>lf` |
| Show errors/warnings list | `<leader>dd` |
| Next / previous diagnostic | `]d` / `[d` |
| Git status UI (stage, commit, push) | `<leader>gg` |
| Next / previous changed hunk | `]c` / `[c` |
| Preview / stage / reset a hunk | `<leader>gp` / `<leader>gs` / `<leader>gr` |
| Jump anywhere on screen | `s` + 2 letters + label |
| Comment a line / selection | `gcc` / `gc` (in visual mode) |
| Surround word with quotes | `ysiw"` |
| Replace the word under cursor (whole file) | `<leader>s` |
| Delete without overwriting the clipboard | `<leader>D` + motion (e.g. `<leader>Dd`) |
| Accept AI suggestion (insert mode) | `Alt-f` |
| Open completion menu (insert mode) | `Ctrl-Space` |
| Escape insert mode | `Esc` or `Ctrl-c` |
| Clear search highlight | `Ctrl-c` (normal mode) |
| Restart Neovim | `<leader>re` |

---

## 2. Vim survival guide (the basics you forget)

Neovim is **modal**: the same key does different things depending on the mode.

| Mode | How to enter | What it's for |
|---|---|---|
| **Normal** | `Esc` (or `Ctrl-c`) | Moving around and giving commands. You start here. |
| **Insert** | `i` | Typing text |
| **Visual** | `v` (chars), `V` (lines), `Ctrl-v` (block) | Selecting text |
| **Command** | `:` | Commands like `:w`, `:q`, `:Lazy` |

### Getting into insert mode
`i` before cursor · `a` after cursor · `I` start of line · `A` end of line · `o` new line below · `O` new line above

### Moving
| Key | Moves |
|---|---|
| `h j k l` | left, down, up, right |
| `w` / `b` / `e` | next word / previous word / end of word |
| `0` / `^` / `$` | line start / first non-blank / line end |
| `gg` / `G` | top / bottom of file |
| `42G` or `:42` | go to line 42 |
| `{` / `}` | previous / next blank-line-separated block |
| `%` | jump to matching bracket |
| `Ctrl-d` / `Ctrl-u` | half page down / up (cursor stays centered) |
| `f<char>` / `t<char>` | jump to / just before next `<char>` on the line (`;` repeat, `,` reverse) |
| `Ctrl-o` / `Ctrl-i` | jump back / forward through your jump history |
| `[b` / `]b` | previous / next buffer (Neovim default) |

### Editing (verb + motion: `d` delete, `c` change, `y` yank/copy)
| Keys | Does |
|---|---|
| `x` | delete character |
| `dd` / `yy` / `cc` | delete / copy / change whole line |
| `dw` / `cw` / `yw` | delete / change / copy word |
| `d$` or `D` | delete to end of line |
| `diw` / `ciw` | delete / change the word under the cursor (from anywhere inside it) |
| `di"` / `ci(` / `dit` | delete inside quotes / parentheses / HTML tag |
| `p` / `P` | paste after / before |
| `u` / `Ctrl-r` | undo / redo (undo history survives closing the file) |
| `.` | repeat last change |
| `>>` / `<<` | indent / unindent line |
| `J` | join next line onto this one |
| `~` | toggle case |
| `r<char>` | replace one character |

Combine numbers: `3dd` deletes 3 lines, `d2w` deletes 2 words.

### Searching and replacing
| Keys | Does |
|---|---|
| `/text` ⏎ | search forward (`n` next, `N` previous; both keep the cursor centered) |
| `?text` ⏎ | search backward |
| `*` / `#` | search for the word under the cursor forward / backward |
| `:%s/old/new/g` | replace in whole file (live preview in a split window) |
| `:%s/old/new/gc` | same, but ask for confirmation each time |
| `<leader>s` | pre-fills `:%s/\<word\>/word/gI` for the word under the cursor, then you type the replacement |

Search is case-insensitive unless you type a capital letter (`ignorecase` + `smartcase`).

### Windows, buffers, tabs
| Keys | Does |
|---|---|
| `:vsplit` / `:split` | split side-by-side / stacked (new window opens right / below) |
| `Ctrl-w h/j/k/l` | move between windows |
| `Ctrl-w c` or `:close` | close this window |
| `Ctrl-w =` | make windows equal size |
| `:bnext` / `:bprev` / `:bd` | next / previous / close buffer |
| `Ctrl-^` | toggle between the current and previous file |
| `:e path/to/file` | open a file |

### Folding (code collapse)
Everything starts **expanded** (`foldlevel=99`). Folds are computed by Treesitter.
`za` toggle fold · `zc` close · `zo` open · `zM` close all · `zR` open all.

### Registers (clipboard)
This config uses the **system clipboard** for everything (`unnamedplus`): yanking and *deleting* both put text
in the clipboard. Two protections are set up:
- Visual-mode `p` pastes over a selection **without** replacing the clipboard, so you can paste repeatedly.
- `<leader>D` + motion deletes into the void, so the clipboard is left alone.

### Macros
`qa` start recording into register `a` → do things → `q` stop → `@a` replay → `@@` replay again.

---

## 3. How to find a key you forgot

| Need | Do |
|---|---|
| What can I press next? | Press `Space` (or `g`, `z`, `]`, `[`) and wait ~0.3 s — which-key pops up |
| Search all keymaps | `:Telescope keymaps` |
| Who defined this key? | `:verbose nmap <key>` (e.g. `:verbose nmap <Space>ff`) |
| Search the manual | `<leader>fh`, or `:help topic` |
| Keys inside a plugin window (file tree, Neogit, Trouble, Telescope, Lazy, Mason) | press `?` (neo-tree/Neogit/Trouble/Lazy), `g?` (Mason, Diffview), `Ctrl-/` in Telescope insert mode |
| All my own keymaps in one file | `lua/config/keymaps.lua` — every keybinding lives there |

---

## 4. Full keymap reference

All keymaps are defined in **`lua/config/keymaps.lua`** with a `desc`, so which-key shows them.
`<leader>` = `Space`. Mode: **n** normal · **v** visual · **x** visual (not select) · **o** operator-pending · **i** insert.

### Explorer
| Keys | Mode | Action |
|---|---|---|
| `<leader>e` | n | Toggle file explorer (neo-tree) |

### Find (Telescope + Trouble)
| Keys | Mode | Action |
|---|---|---|
| `<leader>ff` | n | Find files (includes hidden and git-ignored files; never lists `.git/` contents) |
| `<leader>fg` | n | Live grep (search text in project; uses ripgrep) |
| `<leader>fb` | n | Find open buffers |
| `<leader>fh` | n | Search help tags |
| `<leader>ft` | n | Todo search (TODO/FIXME/NOTE… in Trouble) |

### Git
Global (work anywhere):

| Keys | Mode | Action |
|---|---|---|
| `<leader>gg` | n | Open Neogit (status / commit / push UI) |
| `<leader>gv` | n | Diff view of the working tree (Diffview) |
| `<leader>gh` | n | File history of the current file |
| `<leader>gH` | n | File history of the whole repo |

Buffer-local (only in files tracked by git, provided by gitsigns):

| Keys | Mode | Action |
|---|---|---|
| `]c` / `[c` | n | Next / previous hunk (in a diff window: Vim's native next/previous change) |
| `<leader>gs` | n, v | Stage hunk (in visual mode: stage the selected lines) |
| `<leader>gu` | n | Undo stage hunk (calling stage again toggles it back) |
| `<leader>gr` | n | Reset hunk (discard the change) |
| `<leader>gS` | n | Stage whole buffer |
| `<leader>gR` | n | Reset whole buffer |
| `<leader>gp` | n | Preview hunk |
| `<leader>gb` | n | Toggle inline blame for the current line |
| `<leader>gd` | n | Diff this file against the index |
| `ih` | o, x | Text object: "inner hunk" (e.g. `dih` deletes a hunk, `vih` selects it) |

### Diagnostics (Trouble) — `<leader>d…`
| Keys | Mode | Action |
|---|---|---|
| `<leader>dd` | n | Diagnostics for the project (Trouble) |
| `<leader>dD` | n | Diagnostics for the current buffer only |
| `<leader>dq` | n | Quickfix list (Trouble) |

### LSP (active only when a language server is attached to the buffer)
| Keys | Mode | Action |
|---|---|---|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `grr` | n | Find references |
| `gri` | n | Go to implementation |
| `K` | n | Hover documentation |
| `Ctrl-k` | n | Signature help |
| `<leader>la` | n | Code action |
| `<leader>lr` | n | Rename symbol |
| `<leader>ld` | n | Show diagnostic under cursor (float) |
| `]d` / `[d` | n | Next / previous diagnostic (opens a float) |
| `<leader>lf` | n | Format buffer (conform; works without an LSP) |

Neovim's own built-in LSP keys also work: `gra` code action, `grn` rename, `grt` type definition, `grx` run code lens, `gO` document symbols.

### Flash (fast jumping)
| Keys | Mode | Action |
|---|---|---|
| `s` | n, x, o | Flash jump: type `s`, then 1–2 letters of the target, then the label shown |
| `S` | n, o | Flash Treesitter: select a code node (function, block…) by label. *In visual mode `S` is nvim-surround instead.* |
| `r` | o | Remote flash: e.g. `yr` + target, then a motion, yanks text somewhere else without moving |

`f`, `F`, `t`, `T` also get flash's enhanced repeat behavior.

### Editing helpers
| Keys | Mode | Action |
|---|---|---|
| `J` / `K` | v | Move selected lines down / up (re-indents) |
| `<` / `>` | v | Unindent / indent and **keep** the selection |
| `J` | n | Join lines, cursor stays put |
| `Ctrl-d` / `Ctrl-u` | n | Half-page down / up, cursor centered |
| `n` / `N` | n | Next / previous search result, cursor centered |
| `<leader>s` | n | Replace word under cursor in whole file (you type the replacement) |
| `<leader>X` | n | `chmod +x` the current file |
| `<leader>re` | n | Restart Neovim (`:restart`) |
| `Ctrl-c` | i | Same as `Esc` |
| `Ctrl-c` | n | Clear search highlighting |
| `p` | x | Paste over selection without losing the clipboard |
| `<leader>D` | n, v | Delete without yanking (`<leader>Dd` line, `<leader>Dw` word, or select then `<leader>D`) |

### AI inline completion (NeoCodeium, insert mode, Alt keys)
| Keys | Action |
|---|---|
| `Alt-f` | Accept the whole suggestion |
| `Alt-w` | Accept one word |
| `Alt-a` | Accept one line |
| `Alt-e` / `Alt-r` | Next / previous suggestion |
| `Alt-c` | Dismiss suggestion |

Ghost text is hidden automatically whenever the blink.cmp menu is open.
First-time setup on a machine: `:NeoCodeium auth`.

### Completion menu (blink.cmp, default preset, insert mode)
**The menu does not pop up by itself while typing** (it is configured to auto-show only in the command line / terminal,
so it doesn't fight the AI ghost text). Open it on demand:

| Keys | Action |
|---|---|
| `Ctrl-Space` | Open menu / toggle documentation |
| `Ctrl-n` / `Ctrl-p` (or `↓` / `↑`) | Next / previous item |
| `Ctrl-y` | Accept the selected item |
| `Ctrl-e` | Close the menu |
| `Ctrl-b` / `Ctrl-f` | Scroll documentation up / down |
| `Tab` / `Shift-Tab` | Jump forward / backward inside a snippet |
| `Ctrl-k` | Show / hide signature help |

### Plugin keys that work without a leader
| Keys | Plugin | Action |
|---|---|---|
| `gcc` / `gc{motion}` / `gc` (visual) | Comment.nvim | Toggle line comment |
| `gbc` / `gb{motion}` | Comment.nvim | Toggle block comment |
| `gco` / `gcO` / `gcA` | Comment.nvim | Add comment below / above / end of line |
| `ys{motion}{char}` | nvim-surround | Add surround, e.g. `ysiw"` wraps the word in quotes |
| `yss{char}` | nvim-surround | Surround the whole line |
| `ds{char}` | nvim-surround | Delete surround, e.g. `ds"` |
| `cs{old}{new}` | nvim-surround | Change surround, e.g. `cs"'` |
| `S{char}` | nvim-surround (visual) | Surround the selection |

Surround characters: `)` or `b`, `]` or `r`, `}` or `B`, `>` or `a`, `t` for HTML tag, `f` for function call.
Typing the *opening* bracket (`(`, `{`) adds inner spaces; the *closing* one doesn't.
`nvim-autopairs` automatically closes `(`, `[`, `{`, quotes while typing.

### Inside plugin windows
| Window | Keys |
|---|---|
| **neo-tree** | `<CR>` open file / expand folder · `a` new file (end with `/` for a folder) · `d` delete · `r` rename · `c` copy · `m` move · `y`/`x`/`p` copy/cut/paste · `H` toggle hidden files · `R` refresh · `/` filter · `s`/`S` open in vertical/horizontal split · `q` close · **`?` full list** |
| **Telescope** | `Ctrl-n`/`Ctrl-p` move · `Enter` open · `Ctrl-x` / `Ctrl-v` / `Ctrl-t` open in split / vsplit / tab · `Ctrl-q` send results to quickfix · `Esc` or `Ctrl-c` close · `Ctrl-/` (insert) or `?` (normal) shows all keys |
| **Neogit** | `?` help · `Tab` expand/collapse a diff · `s` stage · `u` unstage · `c` commit menu · `P` push menu · `F` pull menu · `b` branch menu · `q` close |
| **Diffview** | `Tab`/`Shift-Tab` next/previous file · `-` stage/unstage file · `g?` help · close with `:DiffviewClose` |
| **Trouble** | `?` help · `Enter` jump · `q` close |
| **Lazy** (`:Lazy`) | `U` update · `S` sync · `I` install · `X` clean · `R` restore from lockfile · `?` help |
| **Mason** (`:Mason`) | `i` install · `X` uninstall · `U` update all · `g?` help |

> `<Space>` inside neo-tree is deliberately **unbound** (default was "toggle node") so it doesn't delay leader keys. Use `<CR>` to expand folders.

### which-key groups (labels shown in the popup)
`<leader>l` LSP · `<leader>d` Diagnostics · `<leader>e` Explorer · `<leader>f` Find · `<leader>g` Git ·
`<leader>b` Buffer (reserved — **nothing is bound under it yet**; use `[b`/`]b`, `<leader>fb`, `:bd`).

---

## 5. Settings (`options.lua`) explained

File: **`lua/config/options.lua`**. Indentation uses **4 spaces** everywhere.

| Setting | Value | What it means in practice |
|---|---|---|
| `expandtab`, `tabstop`, `softtabstop`, `shiftwidth` | on, 4, 4, 4 | Tab key inserts 4 spaces; existing tabs display 4 wide; `>>` indents 4 |
| `number` + `relativenumber` | on | Current line shows its real number, other lines show distance (handy for `5j`, `12dd`) |
| `guicursor` | `""` | Neovim never changes the cursor shape; your terminal's cursor is used |
| `cursorline` | on | Current line is highlighted |
| `signcolumn` | `yes` | Left column always reserved (git signs/diagnostics don't shift the text) |
| `termguicolors` | on | 24-bit true color |
| `scrolloff` | 8 | Keep 8 lines visible above/below the cursor |
| `wrap` | off | Long lines scroll sideways instead of wrapping |
| `splitright`, `splitbelow` | on | New vertical split opens right, horizontal opens below |
| `ignorecase` + `smartcase` | on | Search ignores case unless you type a capital |
| `inccommand` | `split` | `:s/…/…/` shows a live preview in a split |
| `undofile` + `undodir` | on, `~/.local/share/nvim/undo` | Undo history is saved to disk, survives restarts |
| `swapfile`, `backup` | off | No `.swp` or `~` files |
| `updatetime` | 250 ms | Faster CursorHold events (git signs, diagnostics float) |
| `clipboard` | `unnamedplus` | All yank/delete/paste goes through the system clipboard (needs `wl-copy`/`xclip`) |
| `mouse` | `a` | Mouse works in all modes |
| `foldlevel` / `foldenable` | 99 / on | Folding available, but everything starts open |

**Autocommands** (also in `options.lua`)
- Yanked text flashes briefly so you can see what you copied.
- `nvim .` (or `nvim somedir`) auto-opens the neo-tree explorer on the left.
- Netrw (the built-in explorer) has its banner hidden and cursorline/relativenumber disabled locally to avoid a redraw flicker loop.
- Treesitter highlight/folding/indent are turned on per filetype (in `plugins/treesitter.lua`).

**Providers disabled:** perl, ruby, python3, node (nothing here needs them; silences `:checkhealth` warnings).

**Appearance:** colorscheme **catppuccin** (auto flavour: mocha on a dark terminal), statusline **lualine** with the
`dracula` theme (shows branch, diff, diagnostics, relative file path; one global bar), indent guides, inline color previews
for hex codes.

---

## 6. Plugins: what each one does

One plugin per file in `lua/plugins/`. "Loads" = when lazy.nvim starts it.

| Plugin | File | Purpose | Loads |
|---|---|---|---|
| lazy.nvim | `config/lazy.lua` | Plugin manager (`:Lazy`). Auto-checks for updates. luarocks disabled. | startup |
| catppuccin | `catppuccin.lua` | Colorscheme | startup (priority) |
| nvim-treesitter | `treesitter.lua` | Syntax highlighting, folding, indentation | startup |
| nvim-lspconfig, mason, mason-lspconfig | `lsp-config.lua` | Language servers (Mason installs them; `vim.lsp.enable` starts them) | file open |
| mason-tool-installer | `mason-tool-installer.lua` | Auto-installs formatters/linters: stylua, ruff, shfmt, prettier, sqlfluff | VeryLazy |
| lazydev | `lazydev.lua` | Lua LSP knows the Neovim API (no "undefined global vim") | Lua files |
| blink.cmp (+ friendly-snippets) | `completion.lua` | Completion menu: LSP, path, snippets, buffer; signature help | insert mode |
| NeoCodeium | `neocodeium.lua` | AI inline "ghost text" suggestions | insert mode |
| conform.nvim | `conform.lua` | Formatting (on save + `<leader>lf`) | file open |
| telescope (+ ui-select) | `telescope.lua` | Fuzzy finder; also makes `vim.ui.select` menus (code actions) a dropdown | `:Telescope` |
| neo-tree | `neo-tree.lua` | File explorer sidebar | `:Neotree` |
| gitsigns | `gitsigns.lua` | Git change marks in the gutter, hunk actions, blame | file open |
| neogit | `neogit.lua` | Magit-style Git UI | `:Neogit` |
| diffview | `diffview.lua` | Side-by-side diffs and file history | `:Diffview…` |
| trouble | `trouble.lua` | Pretty lists for diagnostics, quickfix, todos | `:Trouble` |
| todo-comments | `todo-comments.lua` | Highlights `TODO`, `FIXME`, `NOTE`… and makes them searchable | file open |
| flash | `flash.lua` | Jump anywhere with a few keystrokes | VeryLazy |
| nvim-surround | `surround.lua` | Add/change/delete surrounding quotes, brackets, tags | VeryLazy |
| Comment.nvim | `comment.lua` | Toggle comments | VeryLazy |
| nvim-autopairs | `autopairs.lua` | Auto-close brackets and quotes | insert mode |
| indent-blankline | `indent-blankline.lua` | Vertical indent guides | file open |
| nvim-highlight-colors | `colorizer.lua` | Shows `#ff8800` / `rgb()` colors inline | file open |
| lualine | `lualine.lua` | Status line | VeryLazy |
| which-key | `which-key.lua` | Popup of available keys | VeryLazy |

Exact plugin versions are pinned in **`lazy-lock.json`** (commit it after updating).

---

## 7. Languages, LSP, formatting and Treesitter

### Language servers (started via `vim.lsp.enable` in `lsp-config.lua`)
| Server | Language | Notes |
|---|---|---|
| `pyright` | Python | Type checking, completion, go-to-definition |
| `ruff` | Python | Fast lint diagnostics (installed by mason-tool-installer) |
| `lua_ls` | Lua | Configured with lazydev for the Neovim API |
| `bashls` | sh/bash | |
| `jsonls` | JSON | |
| `cssls` | CSS/SCSS/Less | |
| `sqlls` | SQL | Looks for a `.sqllsrc.json` root marker |

`mason-lspconfig` has `automatic_enable = false`: only the servers above start. (Before, Mason also auto-started
the `stylua` formatter as a second Lua "language server".)
Check what is running with `:checkhealth vim.lsp`; install/update servers with `:Mason`.

### Formatting (conform.nvim): runs automatically on every save
| Filetype | Formatter |
|---|---|
| Lua | `stylua` (config: `stylua.toml`, 4 spaces) |
| Python | `ruff_format` |
| sh | `shfmt` |
| HTML, JavaScript, JSON, Markdown, CSS | `prettier` |
| SQL | `sqlfluff` (dialect pinned to **sqlite**, no `.sqlfluff` file needed) |
| anything else | falls back to the LSP formatter if there is one |

- Timeout 10 s. Manual format: `<leader>lf`. Inspect: `:ConformInfo`.
- **Save without formatting once:** `:noautocmd w`

### Treesitter (`plugins/treesitter.lua`)
Parsers: bash, html, css, javascript, json, lua, markdown, python, query, sql, vim, vimdoc, yaml.
For these filetypes (plus `sh`) it turns on **highlighting**, **folding** and **indentation**.
Install another language: `:TSInstall <lang>` (and add it to both lists in `treesitter.lua` so it activates).
Update parsers: `:TSUpdate`.

### Python workflow notes
- Launch Neovim from a shell where **one** Python environment is active. Pyright uses the Python it finds on `PATH`;
  having both a `VIRTUAL_ENV` and a conda env active makes imports resolve against the wrong one.
- Save → `ruff_format` runs → `ruff` and `pyright` diagnostics update. `<leader>dd` lists them all.

---

## 8. Everyday workflows

**Open a project:** `cd project && nvim .` → tree opens. `<CR>` to open files.

**Find and edit:** `<leader>ff` (file) → `<leader>fg` (text) → `gd` to dive in → `Ctrl-o` to come back.

**Rename safely:** cursor on name → `<leader>lr` → type new name → ⏎.

**Fix an error:** `]d` to jump to it → `<leader>la` for a code action → or `<leader>dd` to see them all.

**Commit:**
1. `<leader>gp` previews a hunk, `<leader>gs` stages it (or use `<leader>gg` Neogit: `s` on files, `c` then `c` to commit).
2. In Neogit: `c` → commit popup, write message, `:wq`. Then `P` → push.
3. Review everything first with `<leader>gv`; close the diff view with `:DiffviewClose`.

**Move a block of lines:** select with `V`, then `J` / `K`.

**Rename a word everywhere in the file:** put the cursor on it → `<leader>s` → type the replacement → ⏎.

**Wrap text in quotes/brackets:** `ysiw"`, `ysiw)`; change `"` → `'`: `cs"'`; remove: `ds"`.

**Use AI suggestions:** keep typing; grey ghost text appears. `Alt-f` accepts it, `Alt-w` takes a word, `Alt-c` dismisses.

---

## 9. Maintenance: updating, adding, restoring

### Update everything
1. `:Lazy update` (or `U` inside `:Lazy`), then restart.
2. Make sure things still work. `:checkhealth` to look for new errors.
3. Commit the changed `lazy-lock.json`.

### Something broke after an update
- `:Lazy restore` puts every plugin back to the commit in `lazy-lock.json`.
- Or `git checkout lazy-lock.json` then `:Lazy restore`.

### Add a plugin (follow the conventions)
1. Create `lua/plugins/<name>.lua` returning one spec.
2. Prefer `opts = {}` over a `config` function; lazy-load with `event` / `cmd` / `ft` / `keys`.
3. Put **every keymap in `lua/config/keymaps.lua`** with a `desc`; if you add a new leader prefix, register its group in `M.wk_groups`.
4. Check API details against the version pinned in `lazy-lock.json`, not the plugin's `main` docs.
5. Restart, `:checkhealth <plugin>`, commit the file plus `lazy-lock.json`.

### Add a language
1. Server: add to `ensure_installed` **and** the `vim.lsp.enable` list in `lsp-config.lua`.
2. Formatter: add the tool to `mason-tool-installer.lua` and the filetype to `formatters_by_ft` in `conform.lua`.
3. Treesitter: add the parser to both lists in `treesitter.lua`.

### Useful commands
`:Lazy` · `:Mason` · `:checkhealth` (or `:checkhealth vim.lsp`) · `:ConformInfo` · `:lsp restart` ·
`:Neotree` · `:Neogit` · `:Trouble` · `:Telescope` · `:TSUpdate` · `:NeoCodeium auth` · `:messages` (recent errors)

LSP log file: `:lua vim.cmd.edit(vim.lsp.log.get_filename())`

### Config file map
```
~/.config/nvim
├── init.lua                  # loads options → keymaps → lazy
├── stylua.toml               # formatter style for Lua files (4 spaces)
├── lazy-lock.json            # pinned plugin versions (commit this)
└── lua
    ├── config
    │   ├── options.lua       # settings, autocmds, folding, netrw, providers
    │   ├── keymaps.lua       # ALL keybindings + which-key group labels
    │   └── lazy.lua          # bootstraps lazy.nvim
    └── plugins/              # one file per plugin (see section 6)
```

---

## 10. Troubleshooting

| Symptom | Fix |
|---|---|
| Completion menu never appears while typing | By design (see "Completion menu"). Press `Ctrl-Space`. To make it automatic, remove the `menu.auto_show` function in `plugins/completion.lua`. |
| No AI ghost text | `:NeoCodeium auth`, then `:checkhealth neocodeium`. It is also hidden while the blink menu is open. |
| `<leader>dd` deletes nothing / used to delete a line | It opens Diagnostics now. Delete-without-yank is `<leader>D…` (capital). |
| `gr` doesn't do anything | Use `grr` (references), `gri` (implementation), `gra` (actions), `grn` (rename). |
| `]c` doesn't jump in a non-git file | gitsigns only attaches in git-tracked files. In diff windows `]c` is Vim's native jump. |
| Format-on-save did something unexpected | `:ConformInfo`; skip once with `:noautocmd w`. |
| Lua files turned into tabs | `stylua.toml` must exist in the config root (it does). |
| No LSP features / "no client attached" | `:checkhealth vim.lsp` (shows enabled servers and the log path), `:Mason`, `:lsp restart`. A server only starts for its filetypes. |
| Python imports are underlined as unresolved | Activate the right venv/conda env **before** launching `nvim` (only one). |
| Weird/missing icons | Use a Nerd Font in your terminal. |
| Clipboard not working | Install `wl-clipboard` (Wayland) or `xclip` (X11). |
| Telescope file search is empty / slow | Needs `rg` and `fd` (`fdfind` on Ubuntu). `:checkhealth telescope`. |
| `<Space>` seems laggy in the file tree | It shouldn't be: the tree's own `<Space>` is disabled. Check `plugins/neo-tree.lua`. |
| Plugin broke after update | `:Lazy restore` (see Maintenance). |
| Stuck in a weird mode | `Esc` `Esc`; `:q` closes a window; `:qa!` quits everything without saving. |
| Accidentally recording a macro (`recording @q` in the status line) | Press `q` once. |

---

## 11. Health-check warnings you can ignore

`:checkhealth` is informational; these are expected on this machine:

| Warning | Why it is fine |
|---|---|
| lazy: *found existing packages at `…/site/pack/core`* and vim.pack: *lockfile absent* | Neovim 0.12 creates an empty `site/pack/core` folder itself. This config uses lazy.nvim, not `vim.pack`. Nothing to delete. |
| diffview: *`hg_cmd` not executable* | Mercurial isn't installed; only Git is used. |
| mason: Go, Ruby, RubyGem, Composer, PHP, julia, luarocks *not available* | Only needed when installing Mason packages written in those languages. None are used. |
| neo-tree: snacks/image.nvim/window-picker/file-operations *not installed* | Optional extras. |
| which-key: `mini.icons` not installed; "overlapping keymaps" | Icons come from nvim-web-devicons. Overlaps are normal for prefix keys (`gc`/`gcc`, `ys`/`yss`, `<Space>`/`<Space>ff`). |
| blink.cmp: *some providers may show as disabled* | Informational (cmdline provider is enabled dynamically). |

**Only you can do these on the machine** (config can't):
- Upgrade Neovim 0.12.4 → 0.12.6 (re-download the AppImage / package).
- Launch Neovim with a single active Python env (the report showed both `~/nov_scraper/venv` and the conda env `novbot`).

---

## 12. Design decisions and conventions

**Conventions**
- One plugin per file; `opts = {}` where possible; lazy-load via `event`/`cmd`/`ft`/`keys`.
- Every keymap has a `desc` and lives in `keymaps.lua`; new leader prefixes get a which-key group.
- Config files use labeled sections with separator comments (same style as `options.lua`).
- New autocmds go in the semantically right section, not a catch-all.
- Plugin API usage is checked against the pinned versions in `lazy-lock.json`.
- Changes are made in small phases, each tested before the next.

**Deliberate choices — don't "fix" these**
- **snacks.nvim is intentionally not used.** Don't add it.
- **blink.cmp** is on the stable `1.*` branch (no Rust build toolchain, fewer breaking changes). The AI plugin hides its own ghost text via a `filter` and a `BlinkCmpMenuOpen` autocmd instead of altering blink's behavior.
- LSP uses the modern `vim.lsp.config` / `vim.lsp.enable` API, not the old `lspconfig.x.setup`.
- **lazydev.nvim** (not the deprecated neodev) handles the Neovim Lua API.
- nvim-autopairs is **not** wired into blink.cmp (its completion interop module is nvim-cmp specific).
- Telescope `find_files` deliberately includes hidden and git-ignored files.
- Leader and local-leader are both `Space`.
- Flash uses bare `s` / `S` / `r` (operator-style, used mid-edit).
- `indent-blankline`'s `exclude.filetypes` is an explicit full list: `vim.tbl_deep_extend` merges arrays **by index** and
  would silently overwrite defaults, so never "append" to a list-valued option via `opts`.
- `VimEnter` autocmds that trigger other autocmds need `nested = true` (used for the `nvim .` neo-tree auto-open).

**Ideas not done yet**
- `nvim-treesitter-textobjects` (select/move by function/class — useful for Python).
- Buffer keymaps under the already-registered `<leader>b` group.

---

## 13. Changelog

### 2026-10-31 — health-check cleanup
**Fixed**
- `lazy.lua`: disabled luarocks/hererocks (nothing needs it) → removes the luarocks ❌ error.
- `conform.lua`: `sqlfluff` no longer needs a `.sqlfluff` file (`require_cwd = false`) → "Root directory not found" gone.
- `lsp-config.lua`: `automatic_enable = false` + explicit `ruff` → stops Mason auto-starting `stylua` as a second Lua LSP; the server list is now exactly what is written in the file.
- `keymaps.lua`:
  - **Delete-without-yank moved `<leader>d` → `<leader>D`**; it collided with the Diagnostics group so `<leader>dd` could never delete a line.
  - **`gr` / `gi` → `grr` / `gri`**: bare `gr` conflicted with Neovim's built-in `gra/grn/grr/gri/grt/grx` (timeout delay) and `gi` hid Vim's "insert at last position".
  - **gitsigns `]c` / `[c`** returned key strings from a non-expr mapping, so they did nothing in diff mode; now they call native `]c`/`[c` there.
  - Flash `S` no longer pretends to work in visual mode (nvim-surround owns it there).
- `options.lua`: disabled unused perl/ruby/python3/node providers; corrected the `guicursor` comment.
- `treesitter.lua`: shell scripts (`sh` filetype) now get highlighting/folding/indent.
- `neo-tree.lua`: freed `<Space>` inside the tree so leader keys aren't delayed.
- `telescope.lua`: `opts` is now a function (telescope really lazy-loads instead of loading at startup); `.git/` contents are excluded from file search.
- Added `stylua.toml` (4 spaces) so format-on-save doesn't convert Lua files to tabs.
- Added this guide.

**Left as-is on purpose:** `completion.lua` keeps `menu.auto_show` limited to cmdline/terminal (see troubleshooting); lualine uses the `dracula` theme with catppuccin (cosmetic choice).

---

## 14. Setting up on a new machine

```bash
git clone https://github.com/RehanR7/nvim-setup ~/.config/nvim
nvim            # first start: lazy.nvim installs plugins, Mason installs servers/tools (wait for it)
```
Then inside Neovim: `:NeoCodeium auth`, `:checkhealth`.

**Requirements:** Neovim ≥ 0.12 · `git` · `curl` · `tar` · `unzip` · `gcc`/`make` (parser builds) ·
`tree-sitter-cli` (`cargo install tree-sitter-cli`) · `ripgrep` · `fd` (`fdfind` on Ubuntu) · Node.js + npm (prettier, several LSPs) ·
Python 3 + pip (sqlfluff, pyright) · a clipboard tool (`wl-clipboard` or `xclip`) · a **Nerd Font** in the terminal.
