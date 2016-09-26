SRCS=$(wildcard **/*.md)

OBJS=$(SRCS:.md=.html)

PDFS=$(SRCS:.md=.pdf)

all: $(PDFS)

#Esto con "recode", que transforma á, é... in &aacute;, pero no hace falta con utf-8 en el header si los archivos son utf-8
#cat "$^" | pandoc --filter=./filtro_cfi.py --base-header-level=3 --template=plantilla.html | recode -d ..html > "$(basename $@).html"
%.html: %.md
	cat "$^" | pandoc --filter pandoc-includle --base-header-level=3 --template=shared/pvli-template.html > "$(basename $@).html"
	# cat "$^" | pandoc --filter=./filtro_cfi.py --base-header-level=3 --template=plantilla.html > "$(basename $@).html"


%.pdf: %.html
	wkhtmltopdf "$(basename $@).html" $@ 

.PHONY: all clean pdf html

clean: 
	rm -f $(OBJS)
	rm -f $(PDFS)

pdf: $(PDFS)

html: $(OBJS)
