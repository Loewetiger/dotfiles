{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  author = "sinclairtarget";
  pname = "git-who";
  version = "0.6";

  src = fetchFromGitHub {
    owner = author;
    repo = pname;
    rev = "v${version}";
    hash = "sha256-/MCvFmZNEVnSrSezTiwH3uWPbh/a7mVxmKduc63E3LA=";
  };

  doCheck = false;

  vendorHash = "sha256-VdQw0mBCALeQfPMjQ4tp3DcLAzmHvW139/COIXSRT0s=";

  meta = {
    description = "Git blame for file trees";
    homepage = "https://github.com/sinclairtarget/git-who";
    license = lib.licenses.mit;
  };
}

