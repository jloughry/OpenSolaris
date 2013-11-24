include ../Makefiles/git1.mk

all:
	@echo "There is nothing in this directory to build."

include ../Makefiles/git2.mk

vi:
	vi $(documentation)

notes:
	(cd ../notes && make vi)

quotes:
	(cd ../notes && make quotes)

bibtex:
	(cd ../bibtex && make vi)

clean:
	@echo "\"make clean\" doesn't do anything here."
