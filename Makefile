# SRCS=$(wildcard *.md)
# DOTS=$(wildcard *.dot)

REVEALURL=shared/lib/reveal
# OUTDIR=slides
TEMPLATE=shared/pvli-template-pandoc.html

SRCS=$(wildcard tema*/*.md)
DOTS=$(wildcard tema*/*.dot)
# PNGS=$(wildcard tema*/*.png)
# JPGS=$(wildcard tema*/*.jpg)

OBJS=$(SRCS:.md=.html)
# PDFS=$(SRCS:.md=.pdf)
SVGS=$(DOTS:.dot=.svg)

all: dots html # pdf
	# cp -a shared slides

%.html: %.md $(TEMPLATE) # ideally, depend on all .dot files of that folder
	# $(eval DIR:=$(OUTDIR)/$(dir $<))
	# mkdir -p $(DIR)
	pandoc --filter pandoc-include -s --mathjax -i --variable revealjs-url=$(REVEALURL) -t revealjs --template $(TEMPLATE) $< -o $@

# %.pdf: %.html
# 	wkhtmltopdf "$(basename $@).html" $@ 

%.svg: %.dot
	# $(eval DIR:=$(OUTDIR)/$(dir $<))
	# mkdir -p $(DIR)
	dot -T svg -o $@ $<
	
.PHONY: all clean html dots

clean: 
	rm -f $(OBJS)
	# rm -f $(PDFS)
	rm -f $(SVGS)

# pdf: $(PDFS)

dots: $(SVGS)

# pngs: $(PNGS)

# jpgs: $(JPGS)

html: $(OBJS)

