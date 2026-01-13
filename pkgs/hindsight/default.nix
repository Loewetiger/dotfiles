{ lib, fetchFromGitHub, rustPlatform, openssl, pkg-config }:

rustPlatform.buildRustPackage rec {
  pname = "hindsight";
  version = "397a8f6";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  src = fetchFromGitHub {
    owner = "chaosprint";
    repo = pname;
    rev = "397a8f6fe69307a8ef937e0a96ccb18fd04dc859";
    hash = "sha256-OcvEd0aajjF84ltNhYNabE3kxdCm7MmCNNBq+HaDwp0=";
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
