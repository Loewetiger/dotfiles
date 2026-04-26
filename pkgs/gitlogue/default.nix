{ lib, fetchFromGitHub, rustPlatform, perl }:

rustPlatform.buildRustPackage rec {
  pname = "gitlogue";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "unhappychoice";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-w+5X3NhHCLDXRGQx2JxpIayekMk242uia1bJSRjDDAE=";
  };

  nativeBuildInputs = [
    perl
  ];

  cargoHash = "sha256-Ne0dMpQJ2W/JgCXijosqXBr8B6C1XgK4KnOjByckcms=";

  meta = with lib; {
    description = "A cinematic Git commit replay tool for the terminal, turning your Git history into a living, animated story.";
    homepage = "https://github.com/unhappychoice/gitlogue";
    license = licenses.isc;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
