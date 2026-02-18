{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  author = "Strophox";
  pname = "tetro-tui";
  version = "1.1.0";

  src = fetchzip {
    url = "https://github.com/Strophox/tetro-tui/releases/download/v${version}/x86_64-unknown-linux-gnu.zip";
    hash = "sha256-vcAGV70Sd59O4dlkCKVtOaAYOh2sg/321G4PAooZ5O8=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tetro-tui $out/bin/tetro
    chmod +x $out/bin/tetro
  '';

  meta = with lib; {
    description = "A cross-platform terminal game where tetrominos fall and stack.";
    homepage = "https://github.com/Strophox/tetro-tui";
    license = licenses.mit;
    maintainers = [ ];
  };
}

