{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "onedark";
      editor = {
        true-color = true;
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
          formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          auto-format = true;
          language-servers = [ "nixd" ];
        }
        {
          name = "jjdescription";
          language-servers = [ "typos" ];
        }
        {
          name = "git-commit";
          language-servers = [ "typos" ];
        }
      ];
      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
      };
      language-server.typos = {
        command = "${pkgs.typos-lsp}/bin/typos-lsp";
      };
    };
  };
}

