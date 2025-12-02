{ lib, fetchFromGitHub, rustPlatform, perl }:

rustPlatform.buildRustPackage rec {
  pname = "gitlogue";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "unhappychoice";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-OKRgtWa1HbUgczuS0EdMgosuKPaZJhzIfjwKZAAaBCs=";
  };

  nativeBuildInputs = [
    perl
  ];

  cargoHash = "sha256-cq1bjOxuGJDRLoO0p5tmGF4IjUojXF52p/n6mugPdPg=";

  meta = with lib; {
    description = "A cinematic Git commit replay tool for the terminal, turning your Git history into a living, animated story.";
    homepage = "https://github.com/unhappychoice/gitlogue";
    license = licenses.isc;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
