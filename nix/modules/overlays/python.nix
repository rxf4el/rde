inputs@{ ... }: final: prev: {

  python3-overlay = final.buildEnv {
    name = "python3-overlay";
    paths = [
      (final.python3.withPackages (
        ps: with ps; [
          pyflakes
          pytest
          python-language-server
        ]
      ))
      final.mypy
      final.black
    ];
  };
}
