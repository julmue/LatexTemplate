# project directory
dirProject = .
# document name
docName = main
# directory of header files
dirHeaders = $(dirProject)/headers
# directory of contents
dirContentFrontmatter = $(dirProject)/contentFrontmatter
dirContentMainmatter = $(dirProject)/contentMainmatter
dirContentBackmatter = $(dirProject)/contentBackmatter
# directory of bibliography
dirBibliography = $(project_dir)/bibliography

# directories to include
dirs = 	$(dirHeaders)\
		$(dirContentFrontmatter)\
		$(dirContentMainmatter)\
		$(dirContentMainmatter)\
		$(dirBibliography)
		
# searchpath environment variable for make
VPATH = $(dirs)
BIBINPUTS=$(dirBibliography):$(dirProject)

INCLUDE_DIRS = $(foreach dir, $(dirs), -I $(dir))

# xelatex options
xelatexOptions = -halt-on-error -file-line-error

pdf: $(docName).tex
	xelatex $(xelatexOptions) $<
	bibtex8 $(docName).aux
	# makeindex main.idx
	xelatex $(xelatexOptions) $<

tex: $(docName).tex

$(docName).tex: documentStructure
	m4 $(INCLUDE_FLAGS) $(INCLUDE_DIRS) $< > $(docName).tex

.PHONY: lint
lint: $(docName).tex
	lacheck  $<

.PHONY: clean
clean:
	rm *.pdf *.tex *.log *.aux *.toc *.out
