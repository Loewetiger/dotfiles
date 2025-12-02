{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "fta";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "sgb-io";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-uuf82oWkv3z6PDfTujWDeKdxg0nuPRa5qoYB+aaRjtE=";
  };

  cargoHash = "sha256-T8sLMmWn40PtBT3PeSrAvtRsipZUwHRfwaMN8tOET6g=";

  meta = with lib; {
    description = "Rust-based static analysis for TypeScript projects";
    homepage = "https://github.com/sgb-io/fta";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
