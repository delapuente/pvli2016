SHARED=shared
WEB=website
LESSON=tema
IMGS=imgs
REVEALURL=../$(SHARED)/lib/reveal
TEMPLATE=$(SHARED)/pvli-template-pandoc.html

SRCS=$(wildcard $(LESSON)*/*.md)
DOTS=$(wildcard $(LESSON)*/*.dot)
PNGSO=$(wildcard $(LESSON)*/$(IMGS)/*.png)
JPGSO=$(wildcard $(LESSON)*/$(IMGS)/*.jpg)

HTML=$(addsuffix .html,$(addprefix $(WEB)/,$(basename $(SRCS:.md=.html))))
WEBSHARED=$(WEB)/$(SHARED)
SVGS=$(addsuffix .svg,$(addprefix $(WEB)/,$(basename $(DOTS:.dot=.svg))))
PNGS=$(addprefix $(WEB)/,$(PNGSO))
JPGS=$(addprefix $(WEB)/,$(JPGSO))

all: $(HTML) $(SVGS) $(PNGS) $(JPGS)

$(WEBSHARED): | $(WEB)
	cp -a $(SHARED) $(WEB)

$(WEB)/%.html: %.md  $(TEMPLATE) | $(WEBSHARED) 
	mkdir -p $(dir $@)
	pandoc --filter pandoc-include -s --mathjax -i --variable revealjs-url=$(REVEALURL) -t revealjs --template $(TEMPLATE) $< -o $@

$(WEB)/%.svg: %.dot | $(WEB)
	mkdir -p $(dir $@)
	dot -T svg -o $@ $<
	
$(WEB)/%: % | $(WEB)
	mkdir -p $(dir $@)
	cp -a $< $(dir $@)

$(WEB):
	mkdir -p $@

clean: 
	rm -rf $(WEB)

.PHONY: all clean
