# sudo ln -s ~/dotnix/nixos /etc/nixos <- ~ expands to root user directory not personal
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s /home/moota/dotnix/nixos /etc/nixos # <- Change moota with your usename
ln -s ~/dotnix/home ~/.config/home-manager
