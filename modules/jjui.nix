{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    literalExpression
    mkIf
    mkOption;

  cfg = config.programs.jjui;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.jjui = {
    enable = mkEnableOption "jjui";

    package = lib.mkPackageOption pkgs "jjui" { nullable = true; };

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      example = literalExpression ''
        {
          ui.theme = "my-theme";
        }
      '';
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/jjui/config.toml`.

        See <https://github.com/idursun/jjui/blob/main/internal/config/default/config.toml>
        for all the options.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile = {
      "jjui/config.toml" = mkIf (cfg.settings != { }) {
        source = tomlFormat.generate "jjui-settings" cfg.settings;
      };
    };
  };
}

