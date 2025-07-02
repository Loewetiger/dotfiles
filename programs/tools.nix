{ pkgs, ... }:

{
  programs.mise.enable = true;

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    enableNushellIntegration = false;
  };

  programs.ripgrep.enable = true;

  programs.fd.enable = true;

  programs.yt-dlp.enable = true;

  programs.yazi = {
    enable = true;
    flavors.onedark = pkgs.onedark-yazi;
    theme.flavor.dark = "onedark";
  };

  programs.television = {
    enable = true;
    channels = {
      default.cable_channel = [
        {
          name = "hidden-files";
          source_command = "fd -I -t f";
          preview_command = ":files:";
        }
        {
          name = "docker-images";
          source_command = ''docker image list --format "{{.ID}} {{.Repository}}\t{{.Tag}}\t{{.Size}}"'';
          preview_command = ''docker image inspect {0} | jq -C'';
        }
      ];
    };
    settings = {
      ui = {
        use_nerd_font_icons = true;
        theme = "onedark";
      };
    };
  };

  programs.nh = {
    enable = true;
    flake = "path:/home/leon/.config/home-manager";
    clean = {
      enable = true;
    };
  };

  programs.bottom.enable = true;

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
  };

  programs.less = {
    enable = true;
    keys = ''
      #env
      LESS = -R
    '';
  };

  programs.jq.enable = true;
}

