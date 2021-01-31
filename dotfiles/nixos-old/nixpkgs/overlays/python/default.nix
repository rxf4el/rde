self: super:
{
  python3Env = super.buildEnv {
    name = "python3Env";
    paths = [
      (self.python3.withPackages (
        ps: with ps; [
          python-language-server
          pyflakes
          pip
        ]
      ))
      self.mypy
      self.black
      self.pytest
    ];
  };
}
