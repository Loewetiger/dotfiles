{ lib, fetchFromGitHub, rustPlatform, perl }:

rustPlatform.buildRustPackage rec {
  pname = "gitlogue";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "unhappychoice";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-T9QhPWT6w6Ezdl33mPb24UB38ApZdY/JlFMWYJZw+gA=";
  };

  nativeBuildInputs = [
    perl
  ];

  cargoHash = "sha256-7MQOf/BQ5dDR7iIOKjyKah7CJuZN4OZm+CcHso7FecI=";

  meta = with lib; {
    description = "A cinematic Git commit replay tool for the terminal, turning your Git history into a living, animated story.";
    homepage = "https://github.com/unhappychoice/gitlogue";
    license = licenses.isc;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
