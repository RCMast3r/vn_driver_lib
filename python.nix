{ lib, python311Packages }:

python311Packages.buildPythonPackage {
  pname = "py_vn_lib";
  version = "1.0.0";

  
  propagatedBuildInputs = [ python311Packages.distlib ];

  src = ./python;
}