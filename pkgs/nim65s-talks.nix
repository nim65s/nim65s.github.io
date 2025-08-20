{
  lib,
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "nim65s-talks";
  version = "2.0.2";

  src = fetchzip {
    url = "https://github.com/nim65s/talks/releases/download/v${finalAttrs.version}/nim65s-talks.tar.xz";
    hash = "sha256-IqOxizWHURfVmzvJzPKkm0QSgvKZWR+rvXG8ED7NtLU=";
  };

  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    install -Dm 644 .metadata.json *.pdf -t $out
  '';

  meta = {
    description = "my old talks";
    homepage = "https://github.com/nim65s/talks";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
})
