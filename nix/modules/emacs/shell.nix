
let
  pkgs = import <nixpkgs> {};


  # bring in yellowbrick from pypi, building it with a recursive list
  yellowbrick = pkgs.python3.pkgs.buildPythonPackage rec {
    pname = "yellowbrick";
    version = "1.0.1" ;

    src = pkgs.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "1q659ayr657p786gwrh11lw56jw5bdpnl6hp11qlckvh15haywvk";
    };

    # no tests because this is a simple example
    doCheck = false;

    # dependencies for yellowbrick
    buildInputs = with pkgs.python3Packages; [
      pytest 
      pytestrunner 
      pytest-flakes  
      numpy 
      matplotlib 
      scipy 
      scikitlearn
    ];
  };
in
pkgs.mkShell {
  name = "simpleEnv";
  buildInputs = with pkgs; [
    # basic python dependencies
    python3
    python3Packages.numpy
    python3Packages.scikitlearn
    python3Packages.scipy
    python3Packages.matplotlib
    # a couple of deep learning libraries
    python3Packages.tensorflow
    # python3Packages.tensorflowWithCuda # note if you get rid of WithCuda then you will not be using Cuda
    python3Packages.Keras
    python3Packages.pytorch # used for speedy examples
    # python3Packages.pytorchWithCuda

    # Lets assume we also want to use R, maybe to compare sklearn and R models
    R
    rPackages.mlr
    rPackages.data_table # "_" replaces "."
    rPackages.ggplot2

    yellowbrick
  ];
  shellHook = ''
      '';
}
