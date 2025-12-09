{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
      se = "sudo --preserve-env=PATH env";
      wg = "wget2";
      ze = "zellij";
    };
    functions = {
      hmu = {
        description = "Fetch the newest changes from git and run home-manager switch";
        body = ''
          pushd ~/.config/home-manager
          if test -d .git
              git pull
          end
          nh home switch "path:."
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
    plugins = with pkgs.nushellPlugins; [ polars ];
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
      elixir.symbol = " ";
      gleam.symbol = " ";
      golang.symbol = " ";
      haskell.symbol = " ";
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = " ";
        heuristic = true;
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

  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      theme = "onedark";
      pane_frames = false;
      show_startup_tips = false;
      ui.pane_frames.hide_session_name = true;
    };
  };

  programs.command-not-found.enable = false;
}

