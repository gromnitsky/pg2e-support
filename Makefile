repo := ../pg2e

src := $(wildcard $(repo)/ch01/*.c) \
	\
	$(shell find $(repo)/ch02/min -type f) \
	$(repo)/ch02/toc-3level.txt \
	\
	$(repo)/ch03/tex2img \
	$(repo)/ch03/5-to-xhtml \
	$(repo)/ch03/hyphenation.html \
	$(repo)/ch03/novel.style.2.html \
	\
	$(repo)/ch04/toc \
	$(repo)/ch04/headers-numbering \
	$(repo)/ch04/snippets \
	$(repo)/ch04/footnotes \
	$(repo)/ch04/emdash \
	$(shell find $(repo)/ch04/build-auto -type f)

dest := $(patsubst $(repo)/%, %, $(src))

# copies the code examples from the book's repo
all: $(dest)

$(dest): %: $(repo)/%; $(copy)

define copy
@mkdir -p $(dir $@)
cp $< $@
endef



web:
	$(MAKE) -C $(repo) pdf
	cp -p $(repo)/_out/draft.pdf website/pg2e.pdf
	rsync -av --progress website/ alex@sigwait.org:/home/alex/public_html/p/pg2e
