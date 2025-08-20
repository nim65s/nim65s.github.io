{
  lib,
  stdenvNoCC,

  yarn-berry_4,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "homepage-svgs";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../icons.js
      ../Makefile
      ../package.json
      ../yarn.lock
    ];
  };

  missingHashes = ./missing-hashes.json;
  offlineCache = yarn-berry_4.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    inherit (lib.importJSON ./lock-hash.json) hash;
  };

  makeFlags = [
    "PREFIX=$(out)"
    "svgs"
  ];

  nativeBuildInputs = [
    yarn-berry_4
    yarn-berry_4.yarnBerryConfigHook
  ];

  meta = {
    description = "SVGs for my homepage";
    homepage = "https://github.com/nim65s/homepage";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
})
