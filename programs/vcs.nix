{ vars, ... }:

{
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
    ignores = [ ".jj" ];
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
      hints.resolving-conflicts = false;
    };
  };

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
}

