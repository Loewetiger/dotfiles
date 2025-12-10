{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ascii_moon";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "rockydd";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Q3X06kzUMWuiCjM5bwUSH8idbXgJ8I5vYckjvB1mJ1o=";
  };

  cargoHash = "sha256-rikwRsTOJIvhr0BniQUd2t+WyE7ac5F70FW3IDEgYV0=";

  meta = with lib; {
    description = "A TUI (Terminal User Interface) application written in Rust that displays the moon phase in ASCII art.";
    homepage = "https://github.com/rockydd/ascii_moon";
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
