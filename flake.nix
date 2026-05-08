{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rstudio = pkgs.rstudioWrapper.override {
          packages =
            with pkgs.rPackages;
            [
              pscl
              car
              ggplot2
              caret
              lmtest
              stringi
              dplyr
              nortest
              scales
              lubridate
              NbClust
              glmnet
              hopkins
              cluster
              factoextra
              arules
              arulesViz
              fpc
              psych
              corrplot
              profvis
              pROC
              nnet
            ]
            ++ [ pkgs.rstudio ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rstudio
            pkgs.pandoc
            pkgs.texlive.combined.scheme-full
            pkgs.libintl
            pkgs.cmake
          ];
        };
      }
    );
}
