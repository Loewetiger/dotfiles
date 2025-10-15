{ pkgs, ... }:

let
  makeDprintFormatter = extension: { command = "dprintg"; args = [ "fmt" "--stdin" extension ]; };
in
{
  imports = [ ../modules/dprint.nix ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ typescript-language-server ];
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
          name = "json";
          formatter = makeDprintFormatter "json";
        }
        {
          name = "toml";
          formatter = makeDprintFormatter "toml";
        }
        {
          name = "yaml";
          formatter = makeDprintFormatter "yaml";
        }
        {
          name = "markdown";
          formatter = makeDprintFormatter "md";
        }
        {
          name = "jjdescription";
          language-servers = [ "harper" ];
        }
        {
          name = "git-commit";
          language-servers = [ "harper" ];
        }
      ];

      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
      };
      language-server.harper = {
        command = "${pkgs.harper-jj}/bin/harper-ls";
        args = [ "--stdio" ];
      };
    };
  };

  programs.dprint = with pkgs.dprint-plugins; {
    enable = true;

    formatters = {
      json.pkg = dprint-plugin-json;
      toml.pkg = dprint-plugin-toml;
      yaml = {
        pkg = g-plane-pretty_yaml;

        config.yaml = {
          trailingComma = false;
        };
      };
      markdown = {
        pkg = dprint-plugin-markdown;

        config.markdown = {
          textWrap = "always";
        };
      };
    };
  };

  xdg.configFile = {
    "harper-ls/dictionary.txt".text = ''
      Nuxt
      mise
    '';
  };
}

