{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ballin";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "minimaxir";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-EIGS/2rTDL0uK1hDCgLbi99rL9fGI105sIQASOcXyx0=";
  };

  cargoHash = "sha256-r1w3sp/kGd327qbqCOKCS1oysyqkZMIoMhkrv5JXz20=";

  meta = with lib; {
    description = "A colorful interactive physics simulator with thousands of balls, but in your terminal!";
    homepage = "https://github.com/minimaxir/ballin";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
