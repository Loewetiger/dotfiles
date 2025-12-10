{ lib, fetchFromGitHub, rustPlatform, perl }:

rustPlatform.buildRustPackage rec {
  pname = "gitlogue";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "unhappychoice";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-tcq0TIB9Mfm3kt2PInMto7g2VNpDsOvBiQGNP8+nFvY=";
  };

  nativeBuildInputs = [
    perl
  ];

  cargoHash = "sha256-RZ+JiMy0zHu8aEn4ytRmFcvASRcsHDVK9ls77W7ann0=";

  meta = with lib; {
    description = "A cinematic Git commit replay tool for the terminal, turning your Git history into a living, animated story.";
    homepage = "https://github.com/unhappychoice/gitlogue";
    license = licenses.isc;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
