{ lib, stdenv, fetchFromGitLab, ncurses, gcc }:

stdenv.mkDerivation rec {
  pname = "pond";
  version = "1.0.0";

  src = fetchFromGitLab {
    owner = "alice-lefebvre";
    repo = "pond";
    rev = "1b74089f0d44f13efe8f695849d7cb8c7c6643de";
    hash = "sha256-xG2dQ0hzQMNGV2NreLzXQWeDE5QJc0j6A5JBXmSMavk=";
  };

  nativeBuildInputs = [
    ncurses
    gcc
  ];


  # copied from https://gitlab.com/Morgenkaff/flake-for-pond/
  patchPhase = ''
    sed -i 's/lcurses/lncurses/g' Makefile
    sed -i 's/o bin\/pond/o pond/g' Makefile

    sed -i 's/install: bin\/pond/install : pond/g' Makefile
    sed -i '/rm -f \/usr\/local\/games\/pond/d' Makefile
    sed -i '/cp bin/c\	cp pond bin/pond' Makefile


    sed -i '/uninstall/,$d' Makefile
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv pond $out/bin/
  '';

  meta = with lib; {
    description = "A soothing in-terminal idle screen with frogs and lilypads";
    homepage = "https://gitlab.com/alice-lefebvre/pond";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}

