{ vars, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = vars.git.name;
      user.email = vars.git.email;
      diff = {
        algorithm = "histogram";
        colorMoved = "default";
        sopsdiffer.textconv = "${pkgs.sops}/bin/sops decrypt";
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      rebase.autosquash = true;
      rerere.enabled = true;
      log.date = "iso";
      branch.sort = "-committerdate";
    };
    ignores = [ ".jj/" "mise.local.toml" ];
    attributes = [
      "*.enc.yaml diff=sopsdiffer"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      hyperlinks = true;
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
      aliases = {
        autofix = [ "resolve" "--tool" "mergiraf" ];
      };
    };
  };

  programs.jjui = {
    enable = true;
  };

  programs.lazygit = {
    enable = true;
    # The integration allows lazygit to change the working directory.
    # I don't need this, and it conflicts with my abbreviation.
    enableFishIntegration = false;
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

