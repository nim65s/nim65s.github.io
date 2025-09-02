{
  lib,
  stdenvNoCC,

  homepage-venv,
  nerd-fonts,
  nim65s-talks,
  typst-laas,
  yarn-berry_4,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "homepage";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../icons.js
      ../Makefile
      ../media
      ../my-slides.typ
      ../package.json
      ../public/index.html
      ../src
      ../style.css
      ../talks
      ../teach
      ../template.html
      ../yarn.lock
    ];
  };

  missingHashes = ./missing-hashes.json;
  offlineCache = yarn-berry_4.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    inherit (lib.importJSON ./lock-hash.json) hash;
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
    yarn-berry_4
    yarn-berry_4.yarnBerryConfigHook
  ];

  preBuild = ''
    cp ${nim65s-talks}/*.pdf public
    cp ${nim65s-talks}/.metadata.json public/.old-talks.json
  '';

  meta = {
    description = "my homepage";
    homepage = "https://github.com/nim65s/homepage";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
})
