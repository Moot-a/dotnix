# sudo ln -s ~/dotnix/nixos /etc/nixos <- ~ expands to root user directory not personal
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s /home/moota/dotnix/nixos /etc/nixos # <- Change moota with your usename
ln -s /home/moota/dotnix/home ~/.config/home-manager
# Remove folder before symlinking
ln -s /home/moota/dotnix/hypr ~/.config/hypr
# Remove kitty folder before symlinking
ln -s /home/moota/dotnix/kitty ~/.config/kitty
ln -s /home/moota/dotnix/zshrc ~/.zshrc
ln -s /home/moota/dotnix/starship ~/.config/starship.toml