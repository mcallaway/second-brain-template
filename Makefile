# Minimal makefile for Sphinx documentation
#

# Make makefile variables available to bash calls
.EXPORT_ALL_VARIABLES:

# You can set these variables from the command line.
SHELL         := /usr/local/bin/bash
#SPHINXOPTS    = -a -W --keep-going
SPHINXOPTS    = -W --keep-going
SPHINXBUILD   = sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

# Docker config, if sphinx-build is not locally installed.
BRANCH        = production
SPHINX_PRESENT   = $(shell $(SPHINXBUILD) -h >/dev/null 2>&1 && echo true || echo false )
SPHINX_CONTAINER = registry.hub.docker.com/mcallaway/python-sphinx:latest
DOCKERCMD     = docker run -it --rm \
				--name $@ \
				-v ${PWD}:/data \
				-w /data \
				-p 8000:8000 \
				$(SPHINX_CONTAINER)

# if sphinx-build is not in $PATH set it to run from docker image $(SPHINX_CONTAINER)
ifeq ($(SPHINX_PRESENT),false)
$(info Running sphinx-build from Docker image $(SPHINX_CONTAINER))
BUILDCMD = $(DOCKERCMD) $(SPHINXBUILD)
else
BUILDCMD = $(SPHINXBUILD)
endif

# Put it first so that "make" without argument is like "make help".
help:
	@$(BUILDCMD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O) --keep-going

.PHONY: help Makefile

resources:
	@MAKE -C resources

contacts:
	@MAKE -C contacts

stats: resources contacts
	@echo Build stats
	@FILECOUNT=$$(find . -mindepth 2 -type f $$( printf -- ' -not -path */%s/* ' .git .venv .vscode _build ) | wc -l | tr -d ' '); \
	WORDCOUNT=$$(find . -mindepth 2 -type f $$( printf -- ' -not -path */%s/* ' .git .venv .vscode _build ) | xargs -n1 wc -w | awk '{sum+=$$1}END{print sum}'); \
	echo File count $${FILECOUNT}; \
	echo Word count $${WORDCOUNT}; \
	sed -i '' -e "s/^- File count:.*/- File count: $${FILECOUNT}/" index.md ; \
	sed -i '' -e "s/^- Word count:.*/- Word count: $${WORDCOUNT}/" index.md ;

next:
	@./next.sh ||:

YESTERDAY=$(shell gdate -d yesterday +%A)
commit: stats html
	@echo Commit $(YESTERDAY)\'s work
	git add . && git commit -m "Add $(YESTERDAY)" && git push

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile stats
	$(BUILDCMD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# if sphinx-autobuild is not in $PATH set livehtml to run it from docker image $(SPHINX_CONTAINER)
ifeq (false, $(shell sphinx-autobuild -h 2>/dev/null || echo false))
livehtml: stats
	$(info Running sphinx-autobuild from Docker image $(SPHINX_CONTAINER))
	$(DOCKERCMD) sphinx-autobuild . _build/html --host 0.0.0.0
else
livehtml: stats
	sphinx-autobuild . _build/html --host 0.0.0.0
endif

