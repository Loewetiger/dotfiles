{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
      se = "sudo --preserve-env=PATH env";
    };
    functions = {
      hmu = {
        description = "Fetch the newest changes from git and run home-manager switch";
        body = ''
          pushd ~/.config/home-manager
          if test -d .git
              git pull
          end
          home-manager switch --flake "path:."
          popd
        '';
      };
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.nushell = {
    enable = true;
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

  programs.fzf.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      pane_frames = false;
      ui.pane_frames.hide_session_name = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.command-not-found.enable = false;
}

