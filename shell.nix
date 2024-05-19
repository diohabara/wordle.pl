with (import <nixpkgs> { });
mkShell {
  buildInputs = [
    swiProlog
    nixfmt
  ];
}
