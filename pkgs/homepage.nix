{
  lib,
  stdenvNoCC,

  fetchPnpmDeps,

  nodejs,
  pnpmConfigHook,
  pnpm,

  homepage-venv,
  nerd-fonts,
  nim65s-talks,
  typst-laas,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "homepage";
  version = "1.0.0";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../icons.js
      ../Makefile
      ../media
      ../my-slides.typ
      ../package.json
      ../pnpm-lock.yaml
      ../public/index.html
      ../src
      ../style.css
      ../talks
      ../teach
      ../template.html
    ];
  };

  env = {
    TYPST_FONT_PATHS = nerd-fonts.hack;
    PYTHONPATH = "src";
  };

  makeFlags = [
    "PREFIX=$(out)"
    "-j"
  ];

  buildInputs = [
    nim65s-talks
  ];

  nativeBuildInputs = [
    homepage-venv.passthru.virtualenv
    typst-laas
    nodejs
    pnpmConfigHook
    pnpm
  ];

  preBuild = ''
    cp ${nim65s-talks}/*.pdf public
    cp ${nim65s-talks}/.metadata.json public/.old-talks.json
  '';

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
    hash = "sha256-v/gGzoYBxDCNR5YfwB0iadcQKfoXP/JMNJdDzRMndK8=";
  };

  meta = {
    description = "my homepage";
    homepage = "https://github.com/nim65s/homepage";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
})
