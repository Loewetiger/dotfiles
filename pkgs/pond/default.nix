{ lib, stdenv, fetchFromGitLab, ncurses }:

stdenv.mkDerivation rec {
  pname = "pond";
  version = "1.0.0";

  src = fetchFromGitLab {
    owner = "alice-lefebvre";
    repo = "pond";
    rev = "1b74089f0d44f13efe8f695849d7cb8c7c6643de";
    hash = "sha256-xG2dQ0hzQMNGV2NreLzXQWeDE5QJc0j6A5JBXmSMavk=";
  };

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
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
