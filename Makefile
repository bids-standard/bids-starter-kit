.PHONY all clean

clean:
	rm -fr src/_build/

book: src
	jupyter-book build src

test:
	jupyter-book build src -W --builder linkcheck
