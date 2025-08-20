{
  lib,
  nim65s-talks,
  homepage-css,
  talks-html,
  talks-pdfs,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  name = "homepage";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../Makefile
    ];
  };

  makeFlags = [
    "PREFIX=$(out)"
  ];

  buildInputs = [
    homepage-css
    nim65s-talks
    talks-html
    talks-pdfs
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p public
    cp ${homepage-css}/* public
    cp ${nim65s-talks}/*.pdf public
    cp ${talks-pdfs}/* public
    cp ${talks-html}/* public

    runHook postBuild
  '';

  meta = {
    description = "my talks;";
    homepage = "https://github.com/nim65s/talks";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
