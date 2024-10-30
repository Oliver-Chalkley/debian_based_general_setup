sudo apt install cargo -y
cargo install bob-nvim

# add .cargo/bin to .bashrc if not already there
if ! grep -q ".cargo/bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
fi
# add .local/share/bob/nvim-bin to .bashrc if not already there
if ! grep -q ".local/share/bob/nvim-bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"' >> ~/.bashrc
fi

bob complete bash >> ~/.bashrc
bob complete nvim >> ~/.bashrc
source ~/.bashrc
bob use latest
