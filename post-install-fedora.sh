#!/bin/bash

echo "Atualizando o sistema..."
sudo dnf upgrade -y

echo "Habilitando repositórios RPM Fusion..."
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Habilitando chave do vs code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

echo "Habilitando copr do Ani-Cli..."
sudo dnf copr enable derisis13/ani-cli -y

echo "Adicionando repositório Flatpak (Flathub)..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Checando cache do pacote VS Code..."
dnf check-update

echo "Instalando pacotes via DNF..."
sudo dnf install -y \
  fastfetch \
  vlc \
  steam \
  kitty \
  git \
  ani-cli \
  obs-studio \
  obs-studio-devel \
  obs-studio-libs \
  https://github.com/th-ch/youtube-music/releases/download/v3.8.0/youtube-music-3.8.0.x86_64.rpm \
  curl \
  code \
  alsa-lib-devel \
  fftw3-devel \
  pulseaudio-libs-devel \
  libtool \
  iniparser-devel \
  pkgconf \
  cava \
  qbittorrent \
  lutris \
  fuzzel \
  fzf \
  mpv \
  filezilla \
  flameshot \
  grub-customizer

echo "Instalando pacotes via Flatpak..."
flatpak install -y flathub \
  io.github.ungoogled_software.ungoogled_chromium \
  com.stremio.Stremio \
  com.discordapp.Discord \
  io.github.hmlendea.geforcenow-electron \
  com.protonvpn.www \
  md.obsidian.Obsidian

echo "Instalando PiP do Python..."
sudo dnf install -y python3-pip

echo "Instalando mov-cli..."
pip install --upgrade lxml mov-cli

echo "Instalando fontes locais..."
# Criar pasta de fontes locais (caso não exista)
mkdir -p ~/.local/share/fonts
cp "/home/julliermy/Post-Install-Fedora/fontes/"*.ttf ~/.local/share/fonts/

# Atualizar cache de fontes
fc-cache -fv

echo "Fontes instaladas com sucesso!"

echo "Instalação finalizada!"
