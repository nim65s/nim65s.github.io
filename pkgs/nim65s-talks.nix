{
  lib,
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "nim65s-talks";
  version = "3.0.0";

  src = fetchzip {
    url = "https://github.com/nim65s/talks-legacy/releases/download/v${finalAttrs.version}/nim65s-talks.tar.xz";
    hash = "sha256-s95GbLZ4+GEAmZr4rpylPfzNg3NepP2YPrJLjBe0sks=";
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
