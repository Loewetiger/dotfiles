{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "tetro-tui";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "Strophox";
    repo = "tetro-tui";
    rev = "v${version}";
    hash = "sha256-nT3NLrbjMZVAb7K75QZkLbZDDi1jKLNsoDnb3ENELrk=";
  };

  cargoHash = "sha256-hOpjoKq3QKffa4qTlN1tvLW739UggRWAGe464UqkpiM=";

  postInstall = ''
    mv $out/bin/tetro-tui $out/bin/tetro
  '';

  meta = with lib; {
    description = "A terminal-based but modern tetromino-stacking game that is very customizable and cross-platform.";
    homepage = "https://github.com/Strophox/tetro-tui";
    license = licenses.mit;
    maintainers = [ ];
  };
}

