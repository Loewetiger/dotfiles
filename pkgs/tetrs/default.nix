{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  author = "Strophox";
  pname = "tetrs";
  version = "0.2.7";

  src = fetchzip {
    url = "https://github.com/Strophox/tetrs/releases/download/v0.2.7/x86_64-unknown-linux-gnu.zip";
    hash = "sha256-J6IaxzZALvrb0p7G/keuHo1taVt58oYn5odoBQ+xyR8=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tetrs_tui $out/bin/tetrs
    chmod +x $out/bin/tetrs
  '';

  meta = with lib; {
    description = "Tetromino Game Engine + Terminal Application in Rust";
    homepage = "https://github.com/Strophox/tetrs";
    license = licenses.mit;
    maintainers = [ ];
  };
}

