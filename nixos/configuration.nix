# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, zlspkg, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  networking.hostName = "saitama"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Mononoki" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Ubuntu" ];
        sansSerif = [ "Vazirmatn" "Ubuntu" ];
        monospace = [ "Mononoki" ];
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soggy = {
    isNormalUser = true;
    description = "soggy";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "soggy" = import ./home.nix;
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # core software and libraries
    wget
    gcc
    clang
    git
    gnumake
    cmake
    ninja
    meson
    wl-clipboard
    libGL
    nix-index

    # tooling
    alacritty
    lazygit
    tmux
    unzip
    lf
    os-prober
    pipenv
    httpie
    ripgrep
    fzf
    pavucontrol
    just
    zlspkg.default

    # languages
    zigpkgs.master
    rustup
    odin
    go
    kotlin
    nixd
    nodejs_21
    python3
    bun

    # rice
    waybar
    mako
    swww
    networkmanagerapplet
    rofi-wayland
    tofi
    nwg-look
    libva
    qt5ct
    htop
    btop

    # general software
    gamemode
    steam
    discord
    discordo
    spotify
    _1password
    _1password-gui
    obs-studio
    r2modman
  ];

  xdg.portal.enable = true;
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";

    # For Hyprland on nvidia
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE="wayland";
    GBM_BACKEND="nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME="nvidia";

    # For building stuff
    CC = "clang";
    CXX = "clang++";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.hyprland = {
    enable = true;
    # enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;

      modesetting.enable = true;

      # Installs driver 535
      # package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];

  # disable integrated graphics
  boot.kernelParams = [
    "module_blacklist=i915"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
