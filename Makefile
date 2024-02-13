
BASENAME = english-irregular


all: $(BASENAME).dict.dz $(BASENAME).index
.PHONY: all

$(BASENAME).dict.dz: %.dict.dz: %.dict
	dictzip --keep $<

$(BASENAME).dict $(BASENAME).index &: headers english_irregular_verbs.txt
	cat $^ | dictfmt -f --utf8 -s "English Irregular Verbs" $(BASENAME)


clean:
	rm $(BASENAME).dict $(BASENAME).dict.dz $(BASENAME).index
.PHONY: clean


PREFIX = /usr/share/dictd

install: $(PREFIX)/$(BASENAME).dict.dz $(PREFIX)/$(BASENAME).index
	dictdconfig -w
.PHONY: install

$(PREFIX)/$(BASENAME).dict.dz $(PREFIX)/$(BASENAME).index: $(PREFIX)/%: %
	install --compare -m 0644 $< $@
