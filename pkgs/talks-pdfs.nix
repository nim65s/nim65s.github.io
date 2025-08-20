{
  lib,
  stdenvNoCC,

  nerd-fonts,
  typst-laas,
}:
stdenvNoCC.mkDerivation {
  name = "talks-pdfs";

  src = lib.fileset.toSource {
    root = ../.;
    fileset = lib.fileset.unions [
      ../Makefile
      ../media
      ../my-slides.typ
      ../talks
    ];
  };

  env.TYPST_FONT_PATHS = nerd-fonts.hack;

  makeFlags = [
    "PREFIX=$(out)"
    "talks-pdfs"
  ];

  nativeBuildInputs = [
    typst-laas
  ];

  meta = {
    description = "my talks;";
    homepage = "https://github.com/nim65s/talks";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
