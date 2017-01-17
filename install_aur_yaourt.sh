sudo pacman -Syu base-devel
cd ~
mkdir aur_inst && cd aur_inst
git clone https://aur.archlinux.org/package-query.git
git clone https://aur.archlinux.org/yaourt.git
cd package-query
makepkg -si
cd ../yaourt
makepkg -si
