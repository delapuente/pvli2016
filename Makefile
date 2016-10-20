TEMAS=tema1 tema2 tema3 tema4 tema5 tema6 tema7 tema8 tema9

GENERALFILES=general/criterios_evaluacion.html general/grupos.html general/programa.html
TEMA1FILES=tema1/0101-1-introduccion-pvli.html tema1/0101-2-interpretes_js.html tema1/0102-tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA4FILES=tema4/0401-introduccion-arquitectura-videojuegos.html tema4/0402-ejemplo-componentes-completo.html tema4/0403-ejercicios.html
SHARED=shared
# WEB=website
# LESSON=tema
# IMGS=imgs
# REVEALURL=
REVEALURL=../$(SHARED)/lib/reveal
TEMPLATE=$(SHARED)/pvli-template-pandoc.html
GENERAL=general
DOCS=docs.css


# SHAREDDOCS=$(SHARED)/$(DOCS)
# FINALDOCS=$(WEB)/$(SHAREDDOCS)

# SRCS=$(wildcard $(LESSON)*/*.md)
# INFOMD=$(wildcard $(GENERAL)/*.md)
# DOTS=$(wildcard $(LESSON)*/*.dot)
# PNGSO=$(wildcard $(LESSON)*/$(IMGS)/*.png)
# JPGSO=$(wildcard $(LESSON)*/$(IMGS)/*.jpg)

# HTML=$(addsuffix .html,$(addprefix $(WEB)/,$(basename $(SRCS:.md=.html))))
# INFO=$(addsuffix .html,$(addprefix $(WEB)/,$(basename $(INFOMD:.md=.html))))
# WEBSHARED=$(WEB)/$(SHARED)
# SVGS=$(addsuffix .svg,$(addprefix $(WEB)/,$(basename $(DOTS:.dot=.svg))))
# PNGS=$(addprefix $(WEB)/,$(PNGSO))
# JPGS=$(addprefix $(WEB)/,$(JPGSO))


# BASERUN=pandoc --filter pandoc-include --filter /home/clnznr/programas/pandocfilters/examples/plantuml.py -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref -s --mathjax
BASERUN=pandoc  -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref


all: $(GENERAL) $(TEMAS) # $(HTML) $(SVGS) $(PNGS) $(JPGS) $(GENERAL) $(INFO) #$(WEB)/$(GENERAL)/criterios_evaluacion.html $(WEB)/$(GENERAL)/programa.html 


$(GENERAL): $(GENERALFILES)

tema1: $(TEMA1FILES)

tema4: $(TEMA4FILES)

%.html: %.md $(TEMPLATE)
	$(BASERUN) -i --variable revealjs-url=../$(SHARED)/lib/reveal -t revealjs --template $(TEMPLATE) $< -o $@

$(GENERAL)/%.html: $(GENERAL)/%.md $(SHARED)/$(DOCS)
	$(BASERUN) --css ../$(SHARED)/docs.css $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

# $(WEBSHARED): | $(WEB)
# 	cp -a $(SHARED) $(WEB)

# $(FINALDOCS): $(SHAREDDOCS) | $(WEB)
# 	mkdir -p $(dir $@)
# 	cp -a $(SHAREDDOCS) $(WEB)/$(SHARED)

# $(WEB)/$(GENERAL)/%.html: $(GENERAL)/%.md $(FINALDOCS) | $(WEB)
# 	mkdir -p $(dir $@)
# 	$(BASERUN) --css ../$(SHARED)/docs.css $< -o $@

# $(WEB)/%.html: %.md  $(TEMPLATE) | $(WEBSHARED) 
# 	mkdir -p $(dir $@)
# 	$(BASERUN) -i --variable revealjs-url=$(REVEALURL) -t revealjs --template $(TEMPLATE) $< -o $@

# $(WEB)/%.svg: %.dot | $(WEB)
# 	mkdir -p $(dir $@)
# 	dot -T svg -o $@ $<
	
# $(WEB)/%: % | $(WEB)
# 	mkdir -p $(dir $@)
# 	cp -a $< $(dir $@)

# $(WEB):
# 	mkdir -p $@

clean: 
	rm -f $(TEMA1FILES)
	rm -f $(TEMA4FILES)
	rm -f $(GENERALFILES)

.PHONY: all clean $(TEMAS) $(GENERAL) # clean
