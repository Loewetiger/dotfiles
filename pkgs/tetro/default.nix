{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "tetro-tui";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "Strophox";
    repo = "tetro-tui";
    rev = "v${version}";
    hash = "sha256-fuVXU7IQhTIWrO1MhGucixZ4dbSlnQXXqWAD61NJPSE=";
  };

  cargoHash = "sha256-ErkvqT0JrA4gxsAilTc+rhdFmALZMcP4nvZTK62T38s=";

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

