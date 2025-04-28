{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
      se = "sudo --preserve-env=PATH env";
    };
    plugins = [{
      name = "fzf";
      src = pkgs.fishPlugins.fzf-fish.src;
    }];
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

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--preview 'preview {}'" ];
  };

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

