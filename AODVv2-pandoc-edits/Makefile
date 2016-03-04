
TEMPLATE = template.xml

SOURCES = \
	abstract.mkd \
	AODVv2.mkd \
	appendices.mkd
	
REFERENCES = 
		
draft.txt: $(TEMPLATE) $(SOURCES) $(REFERENCES)
	pandoc2rfc -t $(TEMPLATE) $(SOURCES)
	
draft.html: $(TEMPLATE) $(SOURCES) $(REFERENCES)
	pandoc2rfc -t $(TEMPLATE) -M $(SOURCES)

draft.xml: $(TEMPLATE) $(SOURCES) $(REFERENCES)
	pandoc2rfc -t $(TEMPLATE) -X $(SOURCES)

.PHONY: clean html txt xml
clean:
	pandoc2rfc -C

all: html xml txt
html: draft.html
xml: draft.xml
txt: draft.txt
