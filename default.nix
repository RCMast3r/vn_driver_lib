
{ stdenv, cmake_macros, cmake }:

stdenv.mkDerivation rec {
  pname = "vn_lib_cpp";
  version = "0.1.0";
  src = ./cpp;
  nativeBuildInputs = [ cmake_macros cmake ];
  buildInputs = [cmake_macros ];
  propagatedNativeBuildInputs = [ cmake_macros cmake ];

  # dontPatch = true;
  # dontFixup = true;
  # dontStrip = true;
  # dontPatchELF = true;
}
