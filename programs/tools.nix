{ ... }:

{
  programs.mise.enable = true;

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
  };

  programs.ripgrep.enable = true;

  programs.fd.enable = true;

  programs.yt-dlp.enable = true;

  programs.television = {
    enable = true;
    settings = {
      ui = {
        use_nerd_font_icons = true;
      };
    };
  };

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

