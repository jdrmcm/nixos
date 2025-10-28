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
				z = "zoxide";
				tv="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
			};
			
			initContent = ''
				setopt PROMPT_SUBST
				PROMPT="%F{172}%n%f in %F{106}%d%f %F{172}$%f "
				fastfetch
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
		
	};

	home.packages = with pkgs; [
		bat
		nix-search-tv
		fzf
		prismlauncher
		git
	];
}
