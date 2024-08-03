{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  author = "Strophox";
  pname = "tetrs";
  version = "0.1.6";

  src = fetchzip {
    url = "https://github.com/${author}/${pname}/releases/download/v${version}/x86_64-unknown-linux-gnu.zip";
    hash = "sha256-sUkD38rxqzH0JWGGfFwwPjA4HpeefnnpYbZ/fd2Cdzs=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tetrs_terminal $out/bin/tetrs
    chmod +x $out/bin/tetrs
  '';

  meta = with lib; {
    description = "Tetromino Game Engine + Terminal Application in Rust";
    homepage = "https://github.com/Strophox/tetrs";
    license = licenses.mit;
    maintainers = [ ];
  };
}
