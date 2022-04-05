.PHONY: all clean

clean:
	rm -fr src/_build/

book: clean
	jupyter-book build src

test:
	jupyter-book build src -W --builder linkcheck
