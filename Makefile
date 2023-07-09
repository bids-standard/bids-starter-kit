.PHONY: all clean

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

# Put it first so that "make" without argument is like "make help".
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean:
	rm -fr src/_build/

update_bep_list:
	python tools/print_bep_list.py

update_faq: update_bep_list
	faqtory build

update_filename_templates:
	python tools/print_filename_templates.py

book: clean update_faq update_filename_templates ## build the book
	jupyter-book build src

view: book ## view the book
	$(BROWSER) $$PWD/src/_build/html/index.html

latin_check:
	cd tools && python no-bad-latin.py

test: ## build the book and tests the links
	jupyter-book build src -W --builder linkcheck
