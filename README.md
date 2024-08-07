# Neorora

This is my personal AstroNvim configuration! This setup is tailored for developing in Python, PHP (WordPress and Laravel), and a bit of Rust. Buckle up for a delightful coding experience!

<img src="https://raw.githubusercontent.com/taiwbi/AstroConfig/main/screenshot.png" alt="Screenshot">

## 🌟 Features

- LSP, formatting, syntax highlighting, and diagnostic tools for PHP, Blade, Python, JavaScript, HTML & CSS, and Rust.
- A mesmerizing command line interface using [noice.nvim](https://github.com/folke/noice.nvim).
- All the other fabulous [AstroNvim](https://astronvim.com/) features.
- And the cherry on top: a Colorful anime girl [Alpha](https://github.com/goolord/alpha-nvim) dashboard ASCII art. Because why not?

## 🛠️ Installation

### Pre-Installation

1. **Backup your current Neovim configuration:**

   Save your current setup so you can revert if needed.

   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. **Fork this repository:**

   Press the "Fork" button at the top right to create your own repository to store your user configuration. Alternatively, you can clone this repository directly if GitHub tracking isn't your thing.

3. **Install dependencies:**

   I'm on Fedora Linux, so I use `dnf`. Adjust the package manager commands to match your distro.

   ```sh
   sudo dnf install neovim
   sudo dnf install node npm
   ```

   For PHP and Laravel development, grab composer, PHP, and the Blade LSP:

   ```sh
   sudo dnf install php composer
   composer global require haringsrob/laravel-dev-tools
   ```

   Ensure `composer` bin path is in your `$PATH`:

   ```sh
   # For BASH. Adjust based on your shell.
   if [[ ":$PATH:" != *":$HOME/.composer/vendor/bin:"* ]]; then
       export PATH="$PATH:$HOME/.composer/vendor/bin"
       echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
   fi
   ```

   For Rust development, install Rust tools:

   ```sh
   sudo dnf install rustup
   rustup-init
   rustup component add rustfmt
   ```

4. **Clone the repository:**

   ```sh
   git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
   ```

### Running Neovim

Now for the moment of truth! Fire up Neovim and bask in the glory of your new setup:

```sh
nvim
```

And there you have it! Enjoy coding with your new and improved AstroNvim configuration. Happy coding! 🚀
