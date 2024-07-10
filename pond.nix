{ lib, stdenv, pond, ncurses }:

stdenv.mkDerivation rec {
  pname = "pond";
  version = "1.0.0";

  src = pond;

  buildInputs = [ ncurses ];

  buildPhase = ''
    mkdir -p bin
    $CC -std=gnu99 -Wall -Os pond.c -lncurses -o bin/pond
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/pond $out/bin/pond
  '';

  meta = with lib; {
    description = "A soothing in-terminal idle screen with frogs and lilypads";
    homepage = "https://gitlab.com/alice-lefebvre/pond";
    license = licenses.gpl3;
    maintainers = [ maintainers.yourgithubusername ];
    platforms = platforms.unix;
  };
}
