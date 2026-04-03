# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


#settings {{{

#imports
{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelParams = [ "video=HDMI-A-2:1920x1080@60" ];
	boot.initrd.availableKernelModules = [ "i915" ];

	#graphics
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
			intel-media-driver
			vpl-gpu-rt
			intel-compute-runtime
		];
	};
	environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "iHD";
	};
	hardware.enableRedistributableFirmware = true;

	#networking
	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	#time and localization
	# Set your time zone.
	time.timeZone = "Europe/Amsterdam";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "nl_NL.UTF-8";
		LC_IDENTIFICATION = "nl_NL.UTF-8";
		LC_MEASUREMENT = "nl_NL.UTF-8";
		LC_MONETARY = "nl_NL.UTF-8";
		LC_NAME = "nl_NL.UTF-8";
		LC_NUMERIC = "nl_NL.UTF-8";
		LC_PAPER = "nl_NL.UTF-8";
		LC_TELEPHONE = "nl_NL.UTF-8";
		LC_TIME = "nl_NL.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	# }}}

	#accounts  {{{

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.kevin = {
		isNormalUser = true;
		description = "kevin";
		extraGroups = [ "networkmanager" "wheel" "cdrom" ];
		packages = with pkgs; [];
	};
	# }}}

	# system serfices {{{
	programs.hyprland.enable = true;
	programs.waybar.enable = true;
	services.xserver.enable = true;
	services.displayManager.ly.enable = true;
	#   services.xserver.displayManager.lightdm.enable = true;
	#   services.xserver.displayManager.lightdm.greeters.slick.enable = true;
	#	services.xserver.displayManager.lightdm.greeters.slick.extraConfig = ''
	#	active-monitor=2
	#	background=/home/kevin/Backgrounds/4K-Beautiful-Desktop-Wallpaper-Colorful-Nature-Sunset-Landscape-Free-Download-2048x1152.jpg
	#	'';
	services.udisks2.enable = true;
	programs.steam.enable = true;
	services.tlp.enable = true;
	programs.k3b.enable = true;
	virtualisation.docker.enable = true;
	boot.kernel.sysctl."kernel.sysrq" = 1;
	programs.kdeconnect.enable = true;
	services.journald.extraConfig = 
		''
		SystemMaxUse=50M
		Storage=volatile
		'';
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	powerManagement.cpuFreqGovernor = "performance";
	nixpkgs.config.allowUnfree = true;
	# }}}

	# system upgrade and garbage collextion{{{

	system.autoUpgrade = {
		enable = true;
		flake = "/home/kevin/.nixos/#nixos";
		dates = "22:00";
		flags = [
			"--update-input"
			"nixpkgs"
			"--no-write-lock-file"
			"-L" # print build logs
		];
	};  

	nix.gc.automatic = true;
	nix.gc.options = "--delete-older-than 7d";

	programs.gamemode.enable = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	# }}}

	#enable cron service{{{
		services.cron = {
		enable = true;
		systemCronJobs = [
	#''
	#00 22 * * 1,3,5,6 root rtcwake -m disk -s 36000 && firefox --kiosk monkeytype.com
	#00 22 * * 0,2,4 root rtcwake -m disk -s 28800 && firefox --kiosk monkeytype.com
	#00 14 * * 0,2,4 root exit
	#''
			''
			45 14 * * * root hyprctl dispatch exit
			''
		];
	};
	# }}}

	#Packages{{{
	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		pkgs.neovim
		pkgs.vimPlugins.vim-wayland-clipboard
		pkgs.kitty
		pkgs.mc
		pkgs.waybar
		pkgs.firefox
		pkgs.vimb
		pkgs.ytfzf
		pkgs.mpv
		pkgs.kodi
		pkgs.pulsemixer
		pkgs.wofi
		pkgs.ani-cli
		pkgs.mov-cli
		pkgs.mpd
		pkgs.ncmpcpp
		pkgs.htop
		pkgs.lightdm-slick-greeter
		pkgs.swww
		pkgs.prismlauncher
		pkgs.bottles
		pkgs.udiskie
		pkgs.udisks2
		pkgs.logisim
		pkgs.dosfstools
		pkgs.libreoffice
		pkgs.discord
		pkgs.runelite
		pkgs.tlp
		pkgs.cmatrix
		pkgs.btop
		pkgs.bluez
		pkgs.python312Packages.ds4drv
		pkgs.bleachbit
		pkgs.lynx
		pkgs.tmux
		pkgs.spotdl
		pkgs.font-awesome
		pkgs.dunst
		pkgs.retroarch
		pkgs.git
		pkgs.gh
		pkgs.kdePackages.kdeconnect-kde
		pkgs.cdrkit
		pkgs.texliveFull
		pkgs.zathura
		pkgs.gcc
		pkgs.wget
		pkgs.unzip
		pkgs.gnumake
		pkgs.ripgrep
		#pkgs.python3Full
		pkgs.lua5_1
		pkgs.lua51Packages.luarocks
		pkgs.neovim-node-client
		pkgs.nodejs_24
		pkgs.tree-sitter
		pkgs.wl-clipboard
		pkgs.fd
		pkgs.vimPlugins.mason-lspconfig-nvim
		pkgs.lua51Packages.jsregexp
		pkgs.mgba
		pkgs.fzf
		pkgs.qemu
		pkgs.kdePackages.k3b
		pkgs.yt-dlp
		pkgs.tg
		pkgs.discordo
		pkgs.feh
		pkgs.twitch-tui
		pkgs.docker
		pkgs.dwarf-fortress
		pkgs.nerd-fonts.jetbrains-mono
		pkgs.jetbrains-mono
		pkgs.libnotify
		pkgs.gdb
		pkgs.zenity
		pkgs.mixxx
		pkgs.the-powder-toy
		pkgs.hyprpaper
		pkgs.rmpc
		pkgs.wpm
		pkgs.meson
		pkgs.aalib
		pkgs.pkg-config
		pkgs.cmake
		pkgs.ffmpeg-full
		pkgs.mcaselector
		pkgs.kjv
		pkgs.webcamoid
		pkgs.linuxKernel.packages.linux_6_12.akvcam
		pkgs.obs-studio
		pkgs.ollama
		pkgs.oterm
		pkgs.tintin
		pkgs.cava
		#pkgs.neofetch
		pkgs.ardour
		pkgs.nps
		pkgs.hyprutils
		pkgs.calc
		#inputs.yt-x.packages."${system}".default
		pkgs.warp-terminal
		pkgs.ghostty
		pkgs.newsboat
	];
	# }}}

	# jargon i guess{{{
	#Comments about ssh and the system version
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

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
	system.stateVersion = "24.11"; # Did you read the comment?
}
# }}}
