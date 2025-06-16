SOURCES = $(wildcard talks/*.typ)
OUTPUTS = $(SOURCES:talks/%.typ=public/talks/%.pdf)

all: ${OUTPUTS}

public/talks:
	mkdir -p $@

public/talks/%.pdf: talks/%.typ my-slides.typ public/talks
	typst compile --root . $< $@

watch: $(TALK) my-slides.typ public/talks
	typst watch --root . --open zathura $(TALK) public/$(TALK:.typ=.pdf)
