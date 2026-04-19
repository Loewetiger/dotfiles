{ lib, buildGo126Module, fetchFromGitHub }:

buildGo126Module rec {
  pname = "gittop";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "hjr265";
    repo = "gittop";
    rev = "v${version}";
    hash = "sha256-hRnO7e+1BooeDl+nK8+DzEdB4oj9cXokz1gfeWT8/Cg=";
  };

  vendorHash = "sha256-vvpMEu8/OOAADfWZTbJmq5osAPfz36ZfHzjXro6oNg0=";

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
