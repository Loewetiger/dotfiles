{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
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
    neo
    pond
    tetrs

    dua
    fx
    git-absorb
    lnav
    pv
    television

    # Dependencies for Helix. Could be specified in the languages section, but
    # I strongly dislike the hx --health output with the nix paths.
    nil
    nixd
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

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile = {
    "alacritty/alacritty.toml".source = ./files/alacritty.toml;
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
    userName = vars.git.name;
    userEmail = vars.git.email;
    extraConfig = {
      diff = {
        algorithm = "histogram";
        colorMoved = "default";
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      rebase.autosquash = true;
      rerere.enabled = true;
      log.date = "iso";
      branch.sort = "-committerdate";
    };
    delta = {
      enable = true;
      options = {
        hyperlinks = true;
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = vars.git.name;
        email = vars.git.email;
      };
      ui = {
        pager = "less -FR";
        default-command = [ "log" ];
      };
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "onedark";
      editor = {
        mouse = false;
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
          language-servers = [ "nil" "nixd" ];
        }
      ];
      language-server.nixd = {
        command = "nixd";
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
    };
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
              eza --tree -L 3 --icons always --color always $argv
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
      # Overwrite the preview function of fzf.fish
      _fzf_preview_file = {
        description = "Print a preview for the given file based on its file type.";
        body = ''
          preview "$argv"
        '';
      };
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      ui.pane_frames.hide_session_name = true;
    };
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--preview 'preview {}'" ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 750;
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
      elixir.symbol = " ";
      gleam.symbol = " ";
      golang.symbol = " ";
      haskell.symbol = " ";
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = " ";
      };
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

  programs.mise.enable = true;

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
  };

  programs.ripgrep.enable = true;

  programs.fd.enable = true;

  programs.yt-dlp.enable = true;

  programs.lazygit = {
    enable = true;
    settings = {
      gui.spinner = {
        # Custom spinner from FiraCode
        frames = [ "" "" "" "" "" "" ];
        rate = 50;
      };
      gui.nerdFontsVersion = "3";
      update.method = "never";
    };
  };

  programs.git-cliff.enable = true;

  programs.less = {
    enable = true;
    keys = ''
      #env
      LESS = -R
    '';
  };

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

