.PHONY: all pset solution clean check-code list dist

ROOT_DIR := $(CURDIR)
EXAM_DIR ?=

SUB_MAKEFILES := $(shell find series -name Makefile -type f)
SUBDIRS := $(sort $(dir $(SUB_MAKEFILES)))

define RUN_MAKE
	@status=0; \
	if [ -n "$(EXAM_DIR)" ]; then \
		$(MAKE) -C "$(EXAM_DIR)" $(1) EXAM_DIR="$(abspath $(EXAM_DIR))" || status=$$?; \
	else \
		for d in $(SUBDIRS); do \
			$(MAKE) -C "$$d" $(1) || status=$$?; \
		done; \
	fi; \
	exit $$status
endef

all: pset solution

list:
	@for d in $(SUBDIRS); do echo $$d; done

pset:
	$(call RUN_MAKE,pset)

solution:
	$(call RUN_MAKE,solution)

check-code:
	$(call RUN_MAKE,check-code)

clean:
	$(call RUN_MAKE,clean)

dist: all
	@mkdir -p dist
	@for d in build/series/*; do \
		name=$$(basename $$d); \
		if [ -f "$$d/pset/pset.pdf" ]; then \
			cp "$$d/pset/pset.pdf" "dist/pset-$$name.pdf"; \
		fi; \
		if [ -f "$$d/solution/solution.pdf" ]; then \
			cp "$$d/solution/solution.pdf" "dist/pset-$$name-solution.pdf"; \
		fi; \
	done
