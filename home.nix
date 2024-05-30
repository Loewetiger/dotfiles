{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "leon";
  home.homeDirectory = "/home/leon";

  targets.genericLinux.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    dua

    # Dependencies for Helix. Could be specified in the languages section, but
    # I strongly dislike the hx --health output with the nix paths.
    nil
    nixpkgs-fmt

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
    ".wezterm.lua".source = ./.wezterm.lua;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/leon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # Only display direnv errors (removes a lot of noise)
    DIRENV_LOG_FORMAT = "";
  };

  programs.git = {
    enable = true;
    userName = "Loewetiger";
    userEmail = "loewetiger@tuta.io";
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        hyperlinks = true;
        diff-so-fancy = true;
      };
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        lsp.display-messages = true;
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter.command = "nixpkgs-fmt";
          auto-format = true;
        }
      ];
    };
  };

  programs.fish = {
    enable = true;
    plugins = [{
      name = "fzf";
      src = pkgs.fishPlugins.fzf-fish.src;
    }];
    functions = {
      hmu = {
        description = "Fetch the newest changes from git and run home-manager switch";
        body = ''
          set -l start_dir (pwd)
          cd ~/.config/home-manager
          if test -d .git
              git pull
          end
          home-manager switch
          cd $start_dir
        '';
      };
      # Based on https://github.com/kidonng/dotfiles/blob/4356fb2be6db24e9433826a86f2aa1d5c5b671ed/.config/fish/functions/__fzf_preview_file_content.fish
      preview = {
        description = "Preview the file with the appropiate cli tool";
        body = ''
          set bat_args -n --color always -r :500
          set mime (file -b --mime-type $argv)

          switch $mime[1]
            case "inode/directory"
              ${pkgs.tre-command}/bin/tre -d -c always -l 3 $argv
            case "text/*"
              bat $bat_args $argv
            case application/json
              bat $bat_args -l json $argv
            case image/{gif,jpeg,png,svg+xml,webp}
              ${pkgs.viu}/bin/viu -s -w $COLUMNS $argv
            case "*"
              file -b $argv
              echo "($mime[1])"
          end
        '';
      };
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  # Use the custom preview function for fzf.fish
  home.sessionVariables.fzf_preview_file_cmd = "preview";

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--preview 'preview {}'" ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
      aws.symbol = "  ";
      direnv = {
        disabled = false;
        format = "[$loaded$allowed]($style)";
        allowed_msg = "";
        not_allowed_msg = "";
        denied_msg = "󱧴 ";
        loaded_msg = "";
        unloaded_msg = "";
      };
      golang.symbol = " ";
      nix_shell.symbol = " ";
      python.symbol = " ";
      rust.symbol = " ";
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      update_check = false;
      keys.scroll_exits = false;
      sync.records = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bat.enable = true;

  programs.eza.enable = true;

  programs.ripgrep.enable = true;

  programs.fd.enable = true;

  programs.yt-dlp.enable = true;

  programs.lazygit.enable = true;

  programs.less.enable = true;

  # Home Manager Diff
  programs.hmd = {
    enable = true;
    runOnSwitch = true;
  };

  nix.gc = {
    automatic = true;
    options = "-d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
