SRCS=$(wildcard **/*.md)
DOTS=$(wildcard **/*.dot)

OBJS=$(SRCS:.md=.html)
PDFS=$(SRCS:.md=.pdf)
SVGS=$(DOTS:.dot=.svg)

all: dots pdf

%.html: %.md
	pandoc --filter pandoc-include -s --mathjax -i --variable revealjs-url="../shared/lib/reveal" -t revealjs --template ../shared/reveal.html $< --variable theme=beige -o $@

%.pdf: %.html
	wkhtmltopdf "$(basename $@).html" $@ 

%.svg: %.dot
	dot -T svg -o $@ $<

.PHONY: all clean pdf html dots

clean: 
	rm -f $(OBJS)
	rm -f $(PDFS)
	rm -f $(SVGS)

pdf: $(PDFS)

dots: $(SVGS)

html: $(OBJS)
