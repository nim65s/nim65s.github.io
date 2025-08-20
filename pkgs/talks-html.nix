{
  lib,
  stdenvNoCC,

  nim65s-talks,
  homepage-venv,
  # homepage-svgs, # TODO
  yarn-berry_4,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "talks-html";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../icons.js
      (lib.fileset.fileFilter (file: file.hasExt "md") ../talks)
      ../src
      ../Makefile
      ../template.html
      ../package.json
      ../style.css
      ../yarn.lock
    ];
  };

  missingHashes = ./missing-hashes.json;
  offlineCache = yarn-berry_4.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    inherit (lib.importJSON ./lock-hash.json) hash;
  };

  env.PYTHONPATH = "src";

  postConfigure = ''
    mkdir -p public
    cp ${nim65s-talks}/.metadata.json public/.old-talks.json
  '';

  makeFlags = [
    "PREFIX=$(out)"
    "talks-html"
  ];

  nativeBuildInputs = [
    homepage-venv.passthru.virtualenv
    yarn-berry_4
    yarn-berry_4.yarnBerryConfigHook
  ];

  meta = {
    description = "HTML index of my talks";
    homepage = "https://github.com/nim65s/talks";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
})
