{config, pkgs, ...}:

{
	home.username = "jdrmcm";
	home.homeDirectory = "/home/jdrmcm";
	home.stateVersion = "25.05";

	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;

			shellAliases = {
				nrs = "sudo nixos-rebuild switch";
				tv="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
			};
			
			initContent = ''
				setopt PROMPT_SUBST
				#PROMPT="%F{172}%n%f in %F{106}%d%f %F{172}$%f "
				fastfetch
				eval "$(zoxide init zsh)"
				EDITOR="nvim"
			'';
		};

		neovim = {
			enable = true;
			extraLuaConfig = ''
				vim.opt.tabstop=2
				vim.opt.softtabstop=2
				vim.opt.shiftwidth=2
				vim.opt.expandtab=false
			'';
			defaultEditor = true;
		};

		bash = {
			enable = true;
			initExtra = ''
				zsh
			'';
		};

		fastfetch = {
			enable = true;
		};
		
		kitty = {
			enable = true;
			extraConfig = ''
				font_family JetbrainsMono NF Bold
				font_size 12
				bold_font auto
				italic_font auto
				bold_italic_font auto

				confirm_os_window_close 0
				cursor_trail 1
				linux_display_server auto
				scrollback_lines 2000
				wheel_scroll_min_lines 1
				enable_audio_bell false
				window_padding_width 4
			'';
		};

		zsh.oh-my-zsh = {
			enable = true;
			theme = "robbyrussell";
		};
		
		yazi = {
			enable = true;
			enableZshIntegration = true;
			settings = {
				mgr = {
					show_hidden = true;
				};
			};
		};
	};
	
	services = {
		hypridle = {
			enable = true;
			settings = {
				general = {
					after_sleep_cmd = "hyprctl dispatch dpms on";
				};
				listener = [
					{
						timeout = 300;
						on-timeout = "brightnessctl -s set 10";
						on-resume = "brightnessctl -r";
					}
					{
						timeout = 330;
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 350;
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
				];
			};
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = ''
			${builtins.readFile ./config/hypr/hyprland.conf}
		'';
	};

	home.packages = with pkgs; [
		bat
		nix-search-tv
		fzf
		prismlauncher
		git
		r2modman
		ani-cli
		brightnessctl
		libreoffice
		unzip
		zip
		filezilla
		claude-code
		lm_sensors
		limo
		protonup-qt
		wootility
		unrar
		protontricks
		steam-run
		lutris
		lunar-client
	];
}
