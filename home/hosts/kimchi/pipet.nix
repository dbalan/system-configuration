{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "pipet-${version}";
  version = "1.0.1";

  goPackagePath = "github.com/dbalan/pipet";

  src = fetchFromGitHub {
    owner = "dbalan";
    repo = "pipet";
    rev = "v${version}";
    sha256 = "0hhpphf4f020r9pjpfgrpyhjpwrhid23zc9s6hb7i1v0a2cmf6ws";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = with stdenv.lib; {
       description = "Snippet manager for small bits of text";
       licence = licences.bsd3;
  };
}
