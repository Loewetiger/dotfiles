{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ascii_moon";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "rockydd";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-RWPXB3DSbwKm2AFgvD3/Qg7HQGiiEI+AVb0iuqZRCQo=";
  };

  cargoHash = "sha256-IBHPQWJcHKRRLlyaTWJlCNhCMyanBXPEWdPXUDPLv3c=";

  meta = with lib; {
    description = "A TUI (Terminal User Interface) application written in Rust that displays the moon phase in ASCII art.";
    homepage = "https://github.com/rockydd/ascii_moon";
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
