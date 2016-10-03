SHARED=shared
WEB=website
LESSON=tema
IMGS=imgs
REVEALURL=../$(SHARED)/lib/reveal
TEMPLATE=$(SHARED)/pvli-template-pandoc.html
GENERAL=general
DOCS=docs.css
SHAREDDOCS=$(SHARED)/$(DOCS)
FINALDOCS=$(WEB)/$(SHAREDDOCS)

SRCS=$(wildcard $(LESSON)*/*.md)
INFOMD=$(wildcard $(GENERAL)/*.md)
DOTS=$(wildcard $(LESSON)*/*.dot)
PNGSO=$(wildcard $(LESSON)*/$(IMGS)/*.png)
JPGSO=$(wildcard $(LESSON)*/$(IMGS)/*.jpg)

HTML=$(addsuffix .html,$(addprefix $(WEB)/,$(basename $(SRCS:.md=.html))))
INFO=$(addsuffix .html,$(addprefix $(WEB)/,$(basename $(INFOMD:.md=.html))))
WEBSHARED=$(WEB)/$(SHARED)
SVGS=$(addsuffix .svg,$(addprefix $(WEB)/,$(basename $(DOTS:.dot=.svg))))
PNGS=$(addprefix $(WEB)/,$(PNGSO))
JPGS=$(addprefix $(WEB)/,$(JPGSO))


BASERUN=pandoc --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref -s --mathjax

all: $(HTML) $(SVGS) $(PNGS) $(JPGS) $(GENERAL) $(INFO) #$(WEB)/$(GENERAL)/criterios_evaluacion.html $(WEB)/$(GENERAL)/programa.html 

$(WEBSHARED): | $(WEB)
	cp -a $(SHARED) $(WEB)

$(FINALDOCS): $(SHAREDDOCS) | $(WEB)
	mkdir -p $(dir $@)
	cp -a $(SHAREDDOCS) $(WEB)/$(SHARED)

$(WEB)/$(GENERAL)/%.html: $(GENERAL)/%.md $(FINALDOCS) | $(WEB)
	mkdir -p $(dir $@)
	$(BASERUN) --css ../$(SHARED)/docs.css $< -o $@

$(WEB)/%.html: %.md  $(TEMPLATE) | $(WEBSHARED) 
	mkdir -p $(dir $@)
	$(BASERUN) -i --variable revealjs-url=$(REVEALURL) -t revealjs --template $(TEMPLATE) $< -o $@

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
