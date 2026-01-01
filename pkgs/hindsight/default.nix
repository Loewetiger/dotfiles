{ lib, fetchFromGitHub, rustPlatform, openssl, pkg-config }:

rustPlatform.buildRustPackage rec {
  pname = "hindsight";
  version = "efbabf4";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  src = fetchFromGitHub {
    owner = "chaosprint";
    repo = pname;
    rev = "efbabf48603fd4f9cbff44e4057a2eb648c71094";
    hash = "sha256-8KfiPfrWf9ioA2+6gF1PSQi6ED0Grh+H5jZGTEg4m5c=";
  };

  cargoHash = "sha256-lLN+QswPrdY19yW4w9jPA+6ebqvcOa80bY3B1nuxdIw=";

  meta = with lib; {
    description = "GitHub-style git activity visualizer for your terminal.";
    homepage = "https://github.com/chaosprint/hindsight";
    # license = licenses.;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
