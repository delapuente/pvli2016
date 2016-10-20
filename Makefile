GENERAL=general/criterios_evaluacion.html general/grupos.html general/programa.html
TEMA1=tema1/0101-1-introduccion-pvli.html tema1/0101-2-interpretes_js.html tema1/0102-tooling.html tema1/compilado.dot.svg  tema1/instrucciones.dot.svg  tema1/interpretes.dot.svg  tema1/trabajo_curso.dot.svg  tema1/trabajo_general.dot.svg  tema1/trabajo_manual.dot.svg
TEMA2=
TEMA3=
TEMA4=tema4/0401-introduccion-arquitectura-videojuegos.html tema4/0402-ejemplo-componentes-completo.html tema4/0403-ejercicios.html
TEMA5=
TEMA6=
TEMA7=
TEMA8=
TEMA9=

TEMAS=$(TEMA1) $(TEMA2) $(TEMA3) $(TEMA4) $(TEMA5) $(TEMA6) $(TEMA7) $(TEMA8) $(TEMA9) 
TODO=$(GENERAL) $(TEMAS)
BASERUN=pandoc  -s --mathjax --filter pandoc-include -M secPrefix= -M figPrefix= -M eqnPrefix= -M tblPrefix= --filter pandoc-crossref

all: $(TODO)

%.html: %.md shared/pvli-template-pandoc.html
	$(BASERUN) -i --variable revealjs-url=../shared/lib/reveal -t revealjs --template shared/pvli-template-pandoc.html $< -o $@

general/%.html: general/%.md shared/docs.css
	$(BASERUN) --css ../shared/docs.css $< -o $@

%.dot.svg: %.dot
	dot -T svg $< -O

clean: 
	rm -f $(TODO)

.PHONY: all clean
