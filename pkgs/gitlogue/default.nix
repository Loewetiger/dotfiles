{ lib, fetchFromGitHub, rustPlatform, perl }:

rustPlatform.buildRustPackage rec {
  pname = "gitlogue";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "unhappychoice";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-mZ2A6274Ujpo5rTewFaMUslZhLCKJ2iw43J8X3vuBBI=";
  };

  nativeBuildInputs = [
    perl
  ];

  cargoHash = "sha256-MueaRVomOiQsPSOnHpB/k9a8fNpKpFRilAXgIkVxZ94=";

  meta = with lib; {
    description = "A cinematic Git commit replay tool for the terminal, turning your Git history into a living, animated story.";
    homepage = "https://github.com/unhappychoice/gitlogue";
    license = licenses.isc;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
