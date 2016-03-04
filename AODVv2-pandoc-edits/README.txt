Using pandoc2rfc
----------------

A lot of people (myself included) struggle with writing raw XML for RFCs.
That is not to say that XML isn't a great format for storing RFCs, it's just
a pain for authoring, and I'm not alone in this opinion.

RFC 7328 introduces a new IETF tool called pandoc2rfc that will 'automagically'
convert a set of text files with markdown into XML suitable for use with the 
xml2rfc tool.  In fact, pandoc2rfc automates that conversion into 1 simple step.

As described in RFC 7328, pandoc2rfc uses an XML template file to conatin all
the boilerplate tags needed for an XML RFC, and includes the abstract, middle
and back sections as XML ENTITY references.  These XML entities are produced
by the pandoc2rfc XML conversion step.

The main advantage of using pandoc markdown rather than XML for authoring, is
that authors can concentrate on the content of the RFC, and let the tools
automatically number sections, format tables, check cross-references, etc.

For reference for the pandoc markdown syntax, there is a quick reference section
in the appendix of RFC 7328, and the pandoc documentation itself is a useful guide,
see: http://johnmacfarlane.net/pandoc/README.html

Also useful to remember is that if you need any more advanced XML tags in your 
document, pandoc2rfc will pass through any XML tags verbatim to xml2rfc.
This can be useful for comments, using <!-- -->. 


Provided Makefile
-----------------

I have provided a Makefile (gmake works, and other makes might) that automates 
the process, tracking dependencies, and producing txt, html, and xml outputs
for the RFC in question.

Some useful targets:

  rick@pc:\~$ make 
     Creates draft.txt
   
  rick@pc:\~$ make html
     Creates draft.html
   
  rick@pc:\~$ make xml
     Creates draft.xml
   
  rick@pc:\~$ make all
     Creates draft.txt, draft.html, draft.xml
   
  rick@pc:\~$ make clean
     Deletes draft.* and any intermediate files


Installing pandoc2rfc
---------------------

There is a package for Ubuntu named pandoc2rfc, which can be installed using:

  rick@pc:\~$ sudo apt-get install pandoc2rfc

For those who need to do a manual install, pandoc2rfc depends on the following 
packages:

  python-xml2rfc
  xml2rfc
  pandoc
  xsltproc
  docbook-xml

These should be readily available for most UNIX-like systems.
