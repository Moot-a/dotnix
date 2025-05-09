{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.hostName = "moota";
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Time zone. (Recheck for windows dual boot compatibility win >/< linux)
  time.timeZone = "Europe/Zurich";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "fr_CH.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  environment.variables.LC_PAPER = "fr_CH.UTF-8";
  
	fileSystems = {
    "/win11" = {
      device = "/dev/disk/by-uuid/48487719487704CA";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "windows_names"
        "exec"
        "nofail"
        "umask=0000"
      ];
    };

    "/HDD2TB" = {
      device = "/dev/disk/by-uuid/7258796F587932C9";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "exec"
        "nofail"
      ];
    };

    "/Data" = {
      device = "/dev/disk/by-uuid/596CA0AC1A249C19";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "windows_names"
        "exec"
        "nofail"
        "umask=0000"
      ];
    };
  };

  console.keyMap = "sg";

  # NixOS settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  # Windowing
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.hypridle.enable = true;

  programs.hyprlock.enable = true;

  ## XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config.common.default = "*";

  };

  services.dbus.enable = true;

  # Printing.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  services.printing = {
    enable = true;
    # listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Users
  users.users.moota = {
    isNormalUser = true;
    description = "Elton Mota da Silva";
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "lpadmin"
      "cups"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      thunderbird
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    atkinson-hyperlegible
  ];

  # Gaming
  # hardware.graphics.enable = true;my_
  # hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.variables = {
    SDL_VIDEODRIVER = "";
  };

  ## Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;

  programs.kdeconnect.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    autosuggestions.strategy = [
      "history"
      "completion"
    ];
    autosuggestions.highlightStyle = "fg=8";

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell"; # ← Your prompt will be pure Oh My Zsh now
      plugins = [
        "git"
        "common-aliases"
        "sudo"
      ];
    };

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lh";
      la = "ls -lha";
      gs = "git status";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
    };

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "HIST_REDUCE_BLANKS"
      "APPEND_HISTORY"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
      "EXTENDED_HISTORY"
      "CORRECT"
    ];

    histSize = 100000;
    histFile = "~/.zsh_history";

    interactiveShellInit = ''
      		# Bind better search on up/down
      		autoload -Uz up-line-or-beginning-search
      		autoload -Uz down-line-or-beginning-search
      		zle -N up-line-or-beginning-search
      		zle -N down-line-or-beginning-search
      		bindkey "^[[A" up-line-or-beginning-search
      		bindkey "^[[B" down-line-or-beginning-search

      		# zoxide only (no starship anymore)
      		eval "$(zoxide init zsh)"
      	'';
  };

  environment.systemPackages = with pkgs; [
    home-manager
    kitty
    vscode-fhs
    discord
    htop
    ntfs3g
    tree
    git
    gnumake
    clang
    vlc
    youtube-music
    inkscape
    lutris
    prismlauncher
    heroic
    protonup
    protonup-qt
    gnutls # MC Dungeons
    kdePackages.xwaylandvideobridge
    textsnatcher
    obsidian
    qbittorrent
    gdu
    miru
    duc
    fzf
    fd
    gparted
    wl-clipboard
    zoxide
    ripgrep
    python313
    cups-browsed
    steamcmd
    ollama-rocm
    gcc
    lua-language-server
    python312Packages.setuptools
    kdePackages.filelight
    pdfarranger
    ventoy
    yt-dlp
    kdePackages.qtmultimedia
    joplin-desktop
    kdePackages.kate
    kdePackages.yakuake
    jq
    wine
    bat
    go
    rustup
    ghostty
    wofi
    waybar
    font-awesome
    nixfmt-rfc-style
    hyprshot
    hyprpaper
    swaynotificationcenter
    loupe
    starship
    hyprpicker
    stow
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.copySystemConfiguration = true;

  system.stateVersion = "24.05";

}
