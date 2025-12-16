{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ascii_moon";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "rockydd";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-F0N/2252oEKN4SktcNQPmKWK5Tbsgv4FmEV+wXdt2pk=";
  };

  cargoHash = "sha256-p4VjqWPXvPr/i5IaaTldrOgPzRzcP2JHSoT79pSC8sM=";

  meta = with lib; {
    description = "A TUI (Terminal User Interface) application written in Rust that displays the moon phase in ASCII art.";
    homepage = "https://github.com/rockydd/ascii_moon";
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
