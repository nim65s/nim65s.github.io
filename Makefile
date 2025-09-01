PREFIX=/usr/local/homepages/gsaurel

TALKS_SOURCES = $(wildcard talks/*.typ)
TALKS_OUTPUTS = $(TALKS_SOURCES:talks/%.typ=public/%.pdf)
TEACH_SOURCES = $(wildcard teach/*/*/*.typ)
TEACH_OUTPUTS = $(TEACH_SOURCES:%.typ=public/%.pdf)

all: css html pdfs svgs
html: talks-html
pdfs: talks-pdfs teach-pdfs

css: public/style.css
svgs: public/creativecommons.svg

talks-html: public/talks.html
talks-pdfs: ${TALKS_OUTPUTS}
teach-pdfs: ${TEACH_OUTPUTS}

public/%.pdf: %.typ my-slides.typ
	typst compile --root . $< $@

public/talks.html: ${TALKS_SOURCES} src/homepage/talks_index.py template.html svgs
	talks-index

.yarn/install-state.gz:
	yarn install

public/style.css: style.css template.html public/index.html package.json yarn.lock .yarn/install-state.gz
	yarn css

public/creativecommons.svg: package.json yarn.lock .yarn/install-state.gz icons.js
	yarn svg

check: all

install:
	@mkdir -p $(PREFIX)
	install -Dm 644 public/* -t $(PREFIX)

watch: $(TALK) my-slides.typ
	typst watch --root . --open zathura $(TALK) public/$(TALK:.typ=.pdf)

update:
	nix flake update
	uv lock -U
	pre-commit autoupdate
	yarn up
	yarn-berry-fetcher missing-hashes yarn.lock > ./pkgs/missing-hashes.json
	echo "{ \"hash\": \"`yarn-berry-fetcher prefetch yarn.lock pkgs/missing-hashes.json`\" }" > ./pkgs/lock-hash.json

nim65s-talks:
	nix build .#nim65s-talks
	install -Dm644 result/*.pdf -t public
	install -Dm644 result/.metadata.json public/.old-talks.json
