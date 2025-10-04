{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.dprint;

  formatterModule = types.submodule {
    options = {
      pkg = mkOption {
        type = types.package;
        description = "dprint plugin package (wasm)";
      };

      config = mkOption {
        type = types.attrs;
        description = "The configuration for the formatter";
        default = { };
      };
    };
  };

  makeDprintConfig = formatters:
    let
      mergedConfig = foldl' (acc: formatter: acc // formatter.config) { } (attrValues formatters);
      plugins = map (formatter: "${formatter.pkg}/plugin.wasm") (attrValues formatters);
    in
    mergedConfig // { inherit plugins; };
  dprintWrapped = pkgs.writeShellScriptBin "dprintg" ''
    exec ${cfg.package}/bin/dprint --config "${config.xdg.configHome}/dprint/dprint.json" "$@"
  '';
in
{
  options.programs.dprint = {
    enable = mkEnableOption "dprint";

    package = mkOption {
      type = types.package;
      description = "dprint package";
      default = pkgs.dprint;
    };

    formatters = mkOption {
      type = types.attrsOf formatterModule;
      default = { };
      description = "Attribute set of formatters plugins to configure";
      example = literalExpression ''
        {
          typescript = {
            pkg = pkgs.dprint-plugins.dprint-plugin-typescript;
            config = {
              typescript = {
                lineWidth = 120;
              };
            };
          };
        }
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package dprintWrapped ];

    xdg.configFile."dprint/dprint.json" = mkIf (cfg.formatters != { }) {
      text = builtins.toJSON (makeDprintConfig cfg.formatters);
    };
  };
}
