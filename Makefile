#Main Makefile, serves no purpose but to active the other Makefiles

SHELL = /bin/bash
DIRS = animals program

.PHONY: all debug clean


all: 
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir all; \
	done

debug:
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir debug; \
	done

clean:
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir clean; \
	done
