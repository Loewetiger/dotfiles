{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "tetro-tui";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "Strophox";
    repo = "tetro-tui";
    rev = "v${version}";
    hash = "sha256-LJeWszHq6QVsK4e8Ey27mzHjmkPF1C6x681UsCu/zsE=";
  };

  cargoHash = "sha256-y0TH7DTRhxYqNBLzlj+xXZTCipUsBM60DVTCA/wSDbY=";

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

