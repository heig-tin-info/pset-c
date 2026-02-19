.PHONY: all pset solution list clean mrproper dist deps deps-dev-template deps-reset-template $(SERIES_TARGETS)

ROOT_DIR := $(CURDIR)
TEXSMITH := uv run texsmith
UV := uv
SERIES_DIR := $(ROOT_DIR)/series
BUILD_ROOT := $(ROOT_DIR)/build/series
COMMON_CONFIG := $(SERIES_DIR)/common.yml
CPP_FLAGS := -std=c++20 -Wall -Wextra -pedantic
TEMPLATE_EXAM_PATH ?= ../template-exam

SERIES_FILES := $(sort $(wildcard $(SERIES_DIR)/series-*.md))
SERIES_TARGETS := $(basename $(notdir $(SERIES_FILES)))

define build_variant
	@name="$(1)"; \
	id="$${name#series-}"; \
	src="$(SERIES_DIR)/$${name}.md"; \
	out="$(BUILD_ROOT)/$${id}/$(2)"; \
	extra_args=""; \
	if [ "$(2)" = "solution" ]; then extra_args="-a solution=true"; fi; \
	mkdir -p "$$out"; \
	$(TEXSMITH) -o"$$out" -texam "$(COMMON_CONFIG)" "$$src" --build $$extra_args; \
	if [ -f "$$out/main.pdf" ]; then \
		mv "$$out/main.pdf" "$$out/$(2).pdf"; \
	elif [ -f "$$out/$${name}.pdf" ]; then \
		mv "$$out/$${name}.pdf" "$$out/$(2).pdf"; \
	else \
		echo "No PDF output found in $$out"; \
		exit 1; \
	fi
endef

define check_series_code
	@name="$(1)"; \
	id="$${name#series-}"; \
	assets_dir="$(SERIES_DIR)/assets/$${id}"; \
	if [ -d "$$assets_dir" ]; then \
		cpp_sources=$$(find "$$assets_dir" -maxdepth 1 -type f -name '*.cpp'); \
		if [ -n "$$cpp_sources" ]; then \
			g++ $(CPP_FLAGS) -c $$cpp_sources; \
		fi; \
	fi
endef

all: $(SERIES_TARGETS)

deps:
	$(UV) sync --extra dev

deps-dev-template:
	@test -d "$(TEMPLATE_EXAM_PATH)" || (echo "Missing template-exam checkout: $(TEMPLATE_EXAM_PATH)" && exit 1)
	$(UV) sync --extra dev
	$(UV) pip install -e "$(TEMPLATE_EXAM_PATH)"

deps-reset-template:
	$(UV) sync --extra dev --reinstall-package texsmith-template-exam

# Backward-compatible aggregate targets
pset: $(addprefix pset-,$(SERIES_TARGETS))
solution: $(addprefix solution-,$(SERIES_TARGETS))

list:
	@for s in $(SERIES_TARGETS); do echo $$s; done

$(SERIES_TARGETS): %: pset-% solution-%

pset-%:
	$(call check_series_code,$*)
	$(call build_variant,$*,pset)

solution-%:
	$(call check_series_code,$*)
	$(call build_variant,$*,solution)

clean:
	rm -rf $(ROOT_DIR)/build

mrproper: clean
	rm -f $(ROOT_DIR)/dist/*.pdf

dist: all
	@mkdir -p dist
	@for d in build/series/*; do \
		name=$$(basename "$$d"); \
		if [ -f "$$d/pset/pset.pdf" ]; then \
			cp "$$d/pset/pset.pdf" "dist/pset-$$name.pdf"; \
		fi; \
		if [ -f "$$d/solution/solution.pdf" ]; then \
			cp "$$d/solution/solution.pdf" "dist/pset-$$name-solution.pdf"; \
		fi; \
	done
	@for src in $(SERIES_DIR)/series-*.md; do \
		cp "$$src" "dist/$$(basename "$$src")"; \
	done
	uv run --extra dev pelican pelican/content -s pelicanconf.py -o dist
