
{ stdenv, cmake_macros, cmake }:

stdenv.mkDerivation rec {
  pname = "vn_lib";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ cmake_macros cmake ];
  # dontPatch = true;
  # dontFixup = true;
  # dontStrip = true;
  # dontPatchELF = true;
}
