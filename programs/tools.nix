{ pkgs, ... }:

{
  programs.mise.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "-numbers,-header,-grid";
    };
  };

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
    config = ''
      #env
      LESS = -R
    '';
  };

  programs.jq.enable = true;
}

