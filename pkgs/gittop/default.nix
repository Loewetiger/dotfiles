{ lib, buildGo126Module, fetchFromGitHub }:

buildGo126Module rec {
  pname = "gittop";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "hjr265";
    repo = "gittop";
    rev = "v${version}";
    hash = "sha256-MmuBNzydnvLvIfYUERrqpb9QZYno7r62L33wRcDEDaw=";
  };

  vendorHash = "sha256-f2B9vARgoZYqZa0P2HmsP+eHc1bZUSWSuHAr7AId6Lc=";

  # rename the binary to git-top so it can also be used as "git top"
  postInstall = ''
    mv $out/bin/gittop $out/bin/git-top
  '';

  meta = with lib; {
    homepage = "https://github.com/hjr265/gittop";
    description = "A beautiful terminal UI for visualizing Git repository statistics, inspired by htop/btop.";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
