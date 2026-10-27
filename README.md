<div align="center">

# .config/nvim

**A minimal, fast Neovim configuration that leans on native tools wherever possible.**

`vim.pack` for plugins · the built-in LSP client · the `mini.nvim` suite instead of a pile of separate plugins

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Godot](https://img.shields.io/badge/Godot-4.x-478CBF?style=for-the-badge&logo=godotengine&logoColor=white)
![License](https://img.shields.io/github/license/soldred/nvim?style=for-the-badge)
![Last commit](https://img.shields.io/github/last-commit/soldred/nvim?style=for-the-badge)

[Inside](#-whats-inside) · [Requirements](#-requirements) · [Install](#-1-install-the-dependencies) · [Godot](#-godot-gdscript) · [Keys](#-handy-keys) · [Troubleshooting](#-troubleshooting)

</div>

> [!NOTE]
> This is my personal configuration, shaped around my own workflow, so it may change without notice. You're welcome to use it or borrow from it. I run Fedora on Wayland, so the Fedora steps are the tested ones and the other platforms are best effort.

## 🧩 What's inside

- 📦 **Plugins:** managed by the built-in `vim.pack` and pinned in `nvim-pack-lock.json`
- 🌳 **Syntax and text objects:** nvim-treesitter (`main` branch), treesitter-context and textobjects
- 🧠 **LSP:** native `vim.lsp` with nvim-lspconfig and Mason (Lua, Markdown, Go, Rust)
- ✨ **Completion and snippets:** `mini.completion` and `mini.snippets` with friendly-snippets
- 🧭 **Navigation:** neo-tree (file explorer) and fzf-lua (files, grep, git, diagnostics)
- 🎛️ **Quality of life:** `mini.clue` (key hints), `mini.surround`, `mini.diff`, `mini.notify`, `mini.cmdline`, `mini.statusline`, `vim-sleuth` and `nvim-colorizer`
- 🎮 **Godot:** GDScript language server, treesitter parsers, formatting with `gdformat`, and an external-editor bridge (see [Godot](#-godot-gdscript))
- 🎨 **Theme:** [solarized-osaka](https://github.com/craftzdog/solarized-osaka.nvim)

## 📋 Requirements

| Requirement | Why |
| --- | --- |
| **Neovim 0.12+** | `vim.pack` does not exist in older versions |
| `git` | installing plugins |
| C compiler (`gcc` or `clang`) and `make` | compiling treesitter parsers |
| **`tree-sitter-cli` 0.26.1+** | required by nvim-treesitter's `main` branch; install it with your package manager, **not npm** |
| `fzf`, `ripgrep`, `fd` | fzf-lua pickers (files, grep) |
| `curl`, `unzip`, `tar`, `gzip` | Mason downloads |
| `go` | Mason builds `gopls` with it (only if you write Go) |
| `wl-clipboard` (Wayland) or `xclip` (X11), Linux only | the system clipboard (`clipboard = "unnamedplus"`) |
| A [Nerd Font](https://www.nerdfonts.com/) set in your terminal | icons (`have_nerd_font = true`) |

Optional: `luarocks`, `python3` and `pip` are only needed for Mason packages that use them. Nothing in this config does.

## 📦 1. Install the dependencies

Pick your system. After this step, `nvim --version` should report 0.12 or newer and `tree-sitter --version` 0.26.1 or newer.

> [!TIP]
> The commands below install `wl-clipboard` for Wayland. **If you use X11, install `xclip` instead.**

### <img src="https://cdn.simpleicons.org/fedora" width="20" height="20" align="absmiddle" alt="" /> Fedora (tested)

```sh
sudo dnf install neovim git gcc make curl unzip fzf fd-find ripgrep tree-sitter-cli wl-clipboard golang
```

Check `nvim --version`. If the repository version is older than 0.12, install Neovim from the official tarball as described in the Debian/Ubuntu section. Nerd Fonts are not in the default repositories: download one from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) and set it in your terminal.

<details>
<summary>
  <img src="https://cdn.simpleicons.org/archlinux" width="16" height="16" align="absmiddle" alt="" />
  <b>Arch Linux</b>
</summary>

```sh
sudo pacman -S --needed neovim git base-devel curl unzip fzf fd ripgrep tree-sitter-cli wl-clipboard go
sudo pacman -S --needed ttf-jetbrains-mono-nerd   # a Nerd Font (I like this one)
```

</details>

<details>
<summary>
  <img src="https://cdn.simpleicons.org/debian" width="16" height="16" align="absmiddle" alt="" />
  <img src="https://cdn.simpleicons.org/ubuntu" width="16" height="16" align="absmiddle" alt="" />
  <b>Debian / Ubuntu and derivatives</b>
</summary>

Most tools come from `apt`:

```sh
sudo apt update
sudo apt install -y git gcc make curl unzip fzf fd-find ripgrep wl-clipboard golang-go
```

On Debian and Ubuntu the `fd` binary is called `fdfind`, so add a symlink (make sure `~/.local/bin` is in your `PATH`):

```sh
mkdir -p ~/.local/bin && ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

**Neovim 0.12+.** The version in the Debian/Ubuntu repositories is too old, so use the official release (for ARM, replace `x86_64` with `arm64`):

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc   # or ~/.zshrc
```

**tree-sitter-cli 0.26.1+.** The version in the repositories is usually older than that, so pick one of these:

```sh
# a) prebuilt binary (for ARM, replace x64 with arm64)
curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip > tree-sitter
chmod +x tree-sitter && sudo mv tree-sitter /usr/local/bin/

# b) or build it with Rust (https://rustup.rs)
cargo install --locked tree-sitter-cli
```

Option c) is to start Neovim once and run `:MasonInstall tree-sitter-cli`, then `:restart`.

</details>

<details>
<summary>
  <img src="https://cdn.simpleicons.org/apple/000/fff" width="16" height="16" align="absmiddle" alt="" />
  <b>macOS</b>
</summary>

Requires [Homebrew](https://brew.sh).

```sh
xcode-select --install                # C compiler and make
brew install neovim git fzf fd ripgrep tree-sitter-cli go
brew install --cask font-jetbrains-mono-nerd-font   # a Nerd Font
```

`curl`, `unzip`, `tar` and `gzip` ship with macOS, and the clipboard works out of the box.

</details>

<details>
<summary>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@v2.18.0/icons/windows11/windows11-original.svg" width="16" height="16" align="absmiddle" alt="" />
  <b>Windows</b>
</summary>

Run these in PowerShell. They use [Scoop](https://scoop.sh):

```powershell
scoop install git neovim gcc make ripgrep fd fzf tree-sitter unzip 7zip curl go
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF        # a Nerd Font
```

Then select the font in Windows Terminal's settings. If you prefer another package manager, install the same tools with it. The config works the same everywhere, only the paths differ (see below).

</details>

## 💾 2. Install the config

> [!WARNING]
> These commands move your current Neovim config and plugin data out of the way (to `*.bak`). Only the optional clean-up step deletes anything.

Back up your current Neovim files, then clone this repository into your config folder.

### <img src="https://cdn.simpleicons.org/linux" width="20" height="20" align="absmiddle" alt="" /> <img src="https://cdn.simpleicons.org/apple/000/fff" width="20" height="20" align="absmiddle" alt="" /> Linux and macOS

```sh
# Back up (required)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null || true

# Optional: clean up cache and state
rm -rf ~/.local/state/nvim ~/.cache/nvim

git clone https://github.com/soldred/nvim ~/.config/nvim
```

### <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@v2.18.0/icons/windows11/windows11-original.svg" width="20" height="20" align="absmiddle" alt="" /> Windows (PowerShell)

```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -ErrorAction SilentlyContinue
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -ErrorAction SilentlyContinue

git clone https://github.com/soldred/nvim $env:LOCALAPPDATA\nvim
```

> Optional: if you plan to turn this into your own config and push it to your own repository, remove the original history with `rm -rf ~/.config/nvim/.git` (on Windows: `Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim\.git`).

## 🚀 3. First launch

1. Start `nvim`. It asks you to confirm the plugin installation. Say yes and wait for it to finish.
2. Treesitter parsers compile in the background, so give it a minute. Run `:restart` afterwards.
3. Install the language servers and the formatter with Mason:

   ```vim
   :MasonInstall lua-language-server marksman gopls rust-analyzer stylua
   ```

   Only install the ones you need. The enabled servers are listed in `lua/plugins/lsp.lua`.
4. Run `:checkhealth` if anything looks off.

## 🎮 Godot (GDScript)

> [!NOTE]
> For Godot 4 projects. Godot has to be open on the project for the language server to work.

1. **Formatter (optional):** `:MasonInstall gdtoolkit` installs `gdformat` and `gdlint`. `<leader>f` in a `.gd` file runs `gdformat`, because Godot's language server cannot format.
2. **Language server:** nothing to set up. Godot itself serves it on `127.0.0.1:6005` (**Editor Settings > Network > Language Server**). If you change the port there, set the `GDScript_Port` environment variable before starting Neovim. Opening a `.gd` file while Godot is closed shows a connection error, which is expected.
3. **Open scripts from Godot in this Neovim:**
   - Start Neovim inside the project folder (`cd ~/projects/mygame && nvim .`). Whenever a `project.godot` is found, Neovim listens on `~/.cache/nvim/godot.sock`.
   - In Godot, open **Editor > Editor Settings > Text Editor > External**, enable **Use External Editor** and set:

     | Field | Value |
     | --- | --- |
     | Exec Path | the output of `which nvim`, for example `/usr/bin/nvim` |
     | Exec Flags | see below |

     ```
     --server /home/YOURNAME/.cache/nvim/godot.sock --remote-send "<C-\><C-N>:lua require('plugins.godot').open('{file}', {line}, {col})<CR>"
     ```

     Godot does not expand `~` or `$HOME`, so write the full path. Run `:echo stdpath("cache")` in Neovim to see it.
   - Optional: enable **Text Editor > Behavior > Auto Reload Scripts on External Change** so Godot picks up your edits.
4. **Debugging** stays in Godot: run the game from the editor and use its Debugger panel. You cannot click a breakpoint into the gutter from Neovim, so write the `breakpoint` keyword in the script instead.

## 🔑 Some handy keys

The leader key is `Space`. Press it and wait a moment, and `mini.clue` shows what is available.

| Key | Action |
| --- | --- |
| `<leader>e` | File explorer (project root) |
| `<leader><space>` / `<leader>/` / `<leader>,` | Find files / grep / buffers |
| `<leader>s…` / `<leader>g…` | Search (recent, word, diagnostics, help, keymaps) / git pickers |
| `gd` / `<leader>d` / `<leader>f` | Go to definition / line diagnostics / format buffer |
| `<leader>r` | Replace the word under the cursor, or the selection, in the file |
| `<leader>u` | Undo tree |
| `<C-n>` / `<C-p>` / `<C-y>` | Next / previous / accept completion item |
| `<C-j>` / `<C-l>` / `<C-h>` / `<C-c>` | Expand snippet / next placeholder / previous placeholder / stop |
| `<C-h/j/k/l>` | Move between windows |
| `J` / `K` (visual) | Move the selected lines down / up |

## 🔌 Managing plugins

- ➕ Add a plugin: put its URL in the `vim.pack.add({ ... })` list in `lua/plugins/init.lua`, add its settings file under `lua/plugins/`, and list that file in `lua/plugins/init.lua`.
- 🔄 `:PackUpdate [plugin ...]` updates everything or only the named plugins. Review the changes in the confirmation buffer, then `:write` to accept or `:quit` to discard.
- 🗑️ `:PackDel plugin ...` removes plugins, and `:restart` reloads Neovim.
- 📌 `nvim-pack-lock.json` pins exact plugin versions, so commit it after updating.

## 📁 Layout

```
init.lua                  entry point
lua/config/               options, keymaps, user commands
lua/plugins/init.lua      plugin list (vim.pack) and load order
lua/plugins/*.lua         one file of settings per plugin or area
nvim-pack-lock.json       pinned plugin versions
stylua.toml               formatter settings
```

Format the config (not required) with stylua (`:MasonInstall stylua`). Mason's `bin` folder is only on `PATH` inside Neovim, so run it from there:

```vim
:cd ~/.config/nvim
:!stylua .
```

From a regular terminal, call it by its full path instead (`~/.local/share/nvim/mason/bin/stylua .` on Linux and macOS).

## 🧰 Troubleshooting

- 🌳 **Treesitter errors or "tree-sitter CLI not found":** install `tree-sitter-cli` 0.26.1 or newer (see above), then run `:restart` and `:checkhealth nvim-treesitter`.
- 🔤 **Broken icons or empty boxes:** set a Nerd Font in your terminal.
- 🔍 **File picker finds nothing on Debian/Ubuntu:** check that the `fd` symlink exists and that `~/.local/bin` is on your `PATH`.
- 🧠 **No completion or diagnostics for a language:** install its server with `:Mason`, then check `:checkhealth vim.lsp`.
- ⏳ **`vim.pack` is nil or `vim.lsp.config` is missing:** your Neovim is too old, so install 0.12 or newer.

## License

See [LICENSE](LICENSE).
