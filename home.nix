{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "leon";
  home.homeDirectory = "/home/leon";

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
  home.packages = [
    pkgs.fd
    pkgs.nil # nix lsp
    pkgs.dua

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
    DIRENV_LOG_FORMAT = "";
  };
  
  programs.git = {
    enable = true;
    userName = "Leon Hajdari";
    userEmail = "loewetiger@tuta.io";
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
      language = [{
        name = "python";
        language-servers = [ "pyright" "ruff" ];

        formatter = {
          command = "black";
          args = [ "--line-length" "88" "--quiet" "-" ];
        };
      }];

      language-server = {
        pyright.config.python.analysis.typeCheckingMode = "basic";

        ruff = {
          command = "ruff-lsp";
          config.settings.args = [ "--ignore" "E501" ];
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      ls = "eza";
      l = "eza -l --all --group-directories-first --git";
    };
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
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
  };
  
  programs.bat.enable = true;

  programs.eza.enable = true;

  programs.ripgrep.enable = true;

  programs.yt-dlp.enable = true;
  
  programs.lazygit.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
