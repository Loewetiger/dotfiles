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
    settings = {
      ui = {
        use_nerd_font_icons = true;
      };
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
}

