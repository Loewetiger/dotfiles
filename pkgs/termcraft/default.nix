{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "termcraft";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "pagel-s";
    repo = "termcraft";
    rev = "v${version}";
    hash = "sha256-ZKYEcEis2OahUw0M90ms+KqAtv4EkHeybWVkZxTtl7g=";
  };

  cargoHash = "sha256-Y5JzFRSGZ+6bjdy5OM1nsIS81lxBu0NXYJgoKr5DdVs=";

  # doCheck = false;

  meta = with lib; {
    description = "Terminal-only 2D sandbox survival in Rust.";
    homepage = "https://github.com/pagel-s/termcraft";
    # license = licenses.;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}

