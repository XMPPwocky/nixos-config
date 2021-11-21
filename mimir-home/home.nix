customPackages:
{ config, pkgs, ... }:

let bitwig =
  pkgs.bitwig-studio4.override {
    alsa-lib = pkgs.alsa-lib-git;
  };
in
{
  imports = [
    apps/alacritty.nix
    apps/tmux.nix
    apps/neovim/default.nix

    apps/resilio.nix
    apps/duplicacy-web.nix

    apps/chromium.nix
    apps/firefox.nix

    apps/signal-desktop.nix

    ./cfg-defaults.nix
  ];

  programs.home-manager.enable = true;

  home.username = "mimir";
  home.homeDirectory = "/home/mimir";

  home.stateVersion = "21.05";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = (with pkgs; [
    fd
    ripgrep
    mosh

    discord
    tdesktop

    plexamp
    joplin-desktop

    libreoffice

    resilio-sync

    plasma-pa
    ark

    yubikey-agent

    pinentry-qt

    bitwig
    mixxx

    (customPackages.binaryninja.makeBinjaWrapper { binaryNinjaPath = "/home/mimir/binaryninja"; extraPythonPackages = (p: [ p.colorama p.scapy ]); })
  ]);

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mimir";
    userEmail = "mimir@xmppwocky.net";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
