# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # hardware-configuration.nix is imported in flake.nix
    ];

# NixOS configuration for Star Citizen requirements
boot.kernel.sysctl = {
  "vm.max_map_count" = 16777216;
  "fs.file-max" = 524288;
};

boot.extraModulePackages = with config.boot.kernelPackages; [
	nct6687d
];

boot.kernelModules = [ "coretemp" "nct6683" ];

  # Bootloader.
  boot.loader.limine = {
	enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jadron-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
	
	services.tailscale.enable = true;
	services.tailscale.extraSetFlags = [
		"--ssh"
	];
	services.tailscale.useRoutingFeatures = "both";
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jdrmcm = {
    isNormalUser = true;
    description = "Jordyn McMillan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings = {
        substituters = ["https://nix-citizen.cachix.org"];
        trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
    };
	
  environment.sessionVariables = {
	XDG_PICTURES_DIR="${config.users.users.jdrmcm.home}/Pictures";
  };
	
	programs.mango.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  firefox
  limine
  pavucontrol
  vesktop
  bemenu
  xdg-utils
  btop
  hyprshot
	sunshine
	moonlight-qt
	SDL2
	lm_sensors
	liquidctl
	openlinkhub
  # wget
  ];
  
	services.wivrn.enable = true;

  fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
 
  programs = {
	zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	steam = {
		enable = true;
	};

	hyprland.enable = true;

	coolercontrol.enable = true;
	
  };

  # List services that you want to enable:
  hardware.bluetooth.enable = true;
  hardware.steam-hardware.enable = true;

  services = {
	pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		wireplumber.enable = true;
		jack.enable = false;
	};
	pulseaudio.enable = false;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 47984 47989 48010 9757 ];
  networking.firewall.allowedUDPPorts = [ 47998 47999 48000 48002 48010 9757 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
	hardware.wooting.enable = true;

  hardware.graphics = {
	enable = true;
  };
  
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
  	open = true;

	package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

	services.flatpak.enable = true;

	programs.nix-ld.enable = true;
}
