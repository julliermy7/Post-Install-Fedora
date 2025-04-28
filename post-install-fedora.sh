#!/bin/bash

echo "Atualizando o sistema..."
sudo dnf upgrade -y

echo "Habilitando repositórios RPM Fusion..."
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Adicionando repositório Flatpak (Flathub)..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Instalando pacotes via DNF..."
sudo dnf install -y \
  fastfetch \
  vlc \
  neovim \
  steam \
  kitty \
  git \
  obs-studio \
  obs-studio-devel \
  obs-studio-libs \
  https://github.com/th-ch/youtube-music/releases/download/v3.8.1/youtube-music-3.8.1.x86_64.rpm \
  curl \
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
cp "$HOME/Post-Install-Fedora/fontes/"*.ttf ~/.local/share/fonts/

# Atualizar cache de fontes
fc-cache -fv

echo "Fontes instaladas com sucesso!"

echo "Copiando arquivos de configuração..."

# Só pra garantir que o diretório de config existe
mkdir -p ~/.config

# Copia as configs para a pasta de config do user
cp -rf "$HOME/Post-Install-Fedora/configs/"* ~/.config/

# Copiando linuxtoolbox
cp -rf "$HOME/Post-Install-Fedora/linuxtoolbox/" "$HOME/linuxtoolbox"

# Fazendo backup do bash
echo "Fazendo backup do bash..."
cp "$HOME/.bashrc" "$HOME/.bashrc.backup"

# Copiando novo bashrc
echo "Copiando configuração do bash..."
cp -f "$HOME/Post-Install-Fedora/.bashrc" "$HOME/.bashrc"

echo "Bash copiado com sucesso."

echo "Arquivos de configuração copiados com sucesso."

echo "Instalação finalizada! Reinicie seu terminal para atualizar o bash."
