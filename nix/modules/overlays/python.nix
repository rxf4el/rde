inputs@{ ... }: final: prev: {

  python3-overlay = final.buildEnv {
    name = "python3-overlay";
    paths = [
      (self.python3.withPackages (
        ps: with ps; [
          pyflakes
          pytest
          python-language-server
        ]
      ))
      self.mypy
      self.black
    ];
  };
}
