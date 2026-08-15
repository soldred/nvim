# Installation

To install this config, run the following commands:

- Make a backup of your current Neovim files:

```sh
# Required
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null || true

# Optional: clean up cache and state
rm -rf ~/.local/state/nvim ~/.cache/nvim
```

- Clone the config:

```sh
git clone [https://github.com/soldred/nvim](https://github.com/soldred/nvim) ~/.config/nvim
```

- (Optional) If you plan to customize this configuration and push it to your own repository, remove the original `.git` folder:

```sh
rm -rf ~/.config/nvim/.git
```

- Start Neovim:

```sh
nvim
```

---

This configuration is designed to be minimal, fast, and reliant on native tools wherever possible.
