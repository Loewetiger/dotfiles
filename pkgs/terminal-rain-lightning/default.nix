{ lib, pkgs, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonApplication rec {
  pname = "terminal-rain-lightning";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "rmaake1";
    repo = pname;
    rev = "b7199c634d6d38cfd546700b63acd6e746fc565c";
    sha256 = "sha256-IwXgxiofTvYUT/r5lG2BZrA/jKcHq+euonc+aCVCnF4=";
  };

  nativeBuildInputs = with python3Packages; [ setuptools ];

  propagatedBuildInputs = with pkgs; [ ncurses ];

  format = "pyproject";

  meta = with lib; {
    description = "A terminal-based rain and thunderstorm simulator";
    homepage = "https://github.com/rmaake1/terminal-rain-lightning";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
  };
}

