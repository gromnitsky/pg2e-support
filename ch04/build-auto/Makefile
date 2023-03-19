out := _out/book
targets = $(patsubst src/%.$1, \
	$(out)/%.$2, \
	$(wildcard src/*.$1))

dest := $(call targets,xhtml,xhtml) \
	$(call targets,dot,svg)

all: $(dest)



mkdir = @mkdir -p $(dir $@)
.DELETE_ON_ERROR:

$(out)/%.xhtml: src/%.xhtml
	$(mkdir)
	erb $< > $@
	$(make-depend)

$(out)/%.svg: src/%.dot
	$(mkdir)
	dot -Tsvg $< -o $@



book: _out/draft.epub
dest += src/package.opf

_out/draft.epub: $(dest)
	rm $@ -f
	printf application/epub+zip > mimetype
	zip -qX0 $@ mimetype
	rm mimetype
	cp -r src/package.opf src/META-INF $(out)
	(cd $(out); zip -qX $(CURDIR)/$@ `find * -type f`)
	-epubcheck $@



cache := _out/.cache
define make-depend
@mkdir -p $(cache)/$(dir $<)
./mkdep $@ $< > $(cache)/$(dir $<)/$*.d
endef

# load all .d files
# produced by $(make-depend)
-include $(patsubst %.xhtml, \
	$(cache)/%.d, \
	$(wildcard src/*.xhtml))
