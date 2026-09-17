.PHONY: all typst latex pset light solution list clean mrproper dist deps \
        deps-dev-template deps-reset-template check-code \
        $(SERIES_TARGETS) $(SERIES_ALIASES)

ROOT_DIR := $(CURDIR)
UV := uv
UV_RUN := uv run --no-sync
SERIES_DIR := $(ROOT_DIR)/series
BUILD_ROOT := $(ROOT_DIR)/build/series
COMMON_CONFIG := $(SERIES_DIR)/common.yml
LIGHT_PREP_SCRIPT := $(ROOT_DIR)/scripts/prepare_light.py
CPP_FLAGS := -std=c++20 -Wall -Wextra -pedantic
TEMPLATE_EXAM_PATH ?= ../texsmith-exam

# Output backend: 'typst' (default) or 'latex'. Both produce the same PDFs from
# the same Markdown sources; `make typst` and `make latex` just set this.
FORMAT ?= typst
ifeq ($(FORMAT),typst)
FORMAT_ARGS := --format typst
else ifeq ($(FORMAT),latex)
FORMAT_ARGS := --format latex
else
$(error Unknown FORMAT '$(FORMAT)'; expected 'typst' or 'latex')
endif

# Typst refuses to read sources outside its project root, so builds must stay
# under $(ROOT_DIR); BUILD_ROOT already does.
TEXSMITH := $(UV_RUN) texsmith $(FORMAT_ARGS)

SERIES_FILES := $(sort $(wildcard $(SERIES_DIR)/*/series-*.md))
SERIES_TARGETS := $(patsubst $(SERIES_DIR)/%,%,$(basename $(SERIES_FILES)))
# Bare names (`make series-20`) as aliases for the `<group>/<name>` targets.
SERIES_ALIASES := $(sort $(notdir $(SERIES_TARGETS)))

define series_group
$(patsubst %/,%,$(dir $(1)))
endef

define series_name
$(notdir $(1))
endef

define series_id
$(patsubst series-%,%,$(call series_name,$(1)))
endef

# $(1) = <group>/<name>, $(2) = variant (pset|light|solution)
define build_variant
	@src="$(SERIES_DIR)/$(1).md"; \
	base="$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))"; \
	out="$$$$base/$(FORMAT)/$(2)"; \
	extra_args=""; \
	if [ "$(2)" = "light" ]; then \
		light_src="$$$$base/light-src/$(call series_name,$(1)).md"; \
		mkdir -p "$$$$base/light-src"; \
		ln -sfn "$(ROOT_DIR)/assets" "$(BUILD_ROOT)/$(call series_group,$(1))/assets"; \
		$(UV_RUN) --extra dev python "$(LIGHT_PREP_SCRIPT)" "$$$$src" "$$$$light_src"; \
		src="$$$$light_src"; \
		extra_args="-a compact=true"; \
	fi; \
	if [ "$(2)" = "solution" ]; then extra_args="-a solution=true"; fi; \
	mkdir -p "$$$$out"; \
	$(TEXSMITH) -o"$$$$out" -texam "$(COMMON_CONFIG)" "$$$$src" --build $$$$extra_args; \
	if [ -f "$$$$out/main.pdf" ]; then \
		mv "$$$$out/main.pdf" "$$$$out/$(2).pdf"; \
	elif [ -f "$$$$out/$(call series_name,$(1)).pdf" ]; then \
		mv "$$$$out/$(call series_name,$(1)).pdf" "$$$$out/$(2).pdf"; \
	else \
		echo "No PDF output found in $$$$out"; \
		exit 1; \
	fi; \
	case "$(2)" in \
		pset) cp "$$$$out/pset.pdf" "$$$$base/$(call series_name,$(1)).pdf" ;; \
		light) cp "$$$$out/light.pdf" "$$$$base/$(call series_name,$(1))-light.pdf" ;; \
		solution) cp "$$$$out/solution.pdf" "$$$$base/$(call series_name,$(1))-solutions.pdf" ;; \
	esac
endef

define check_series_code
	@assets_dir="$(SERIES_DIR)/$(call series_group,$(1))/assets/$(call series_id,$(1))"; \
	if [ -d "$$$$assets_dir" ]; then \
		cpp_sources=$$$$(find "$$$$assets_dir" -maxdepth 1 -type f -name '*.cpp'); \
		if [ -n "$$$$cpp_sources" ]; then \
			g++ $(CPP_FLAGS) -fsyntax-only $$$$cpp_sources; \
		fi; \
	fi
endef

all: $(SERIES_TARGETS)

# Engine selection shortcuts.
typst:
	@$(MAKE) --no-print-directory all FORMAT=typst

latex:
	@$(MAKE) --no-print-directory all FORMAT=latex

deps:
	$(UV) sync --extra dev

deps-dev-template:
	@test -d "$(TEMPLATE_EXAM_PATH)" || (echo "Missing texsmith-exam checkout: $(TEMPLATE_EXAM_PATH)" && exit 1)
	$(UV) sync --extra dev
	$(UV) pip install -e "$(TEMPLATE_EXAM_PATH)"

deps-reset-template:
	$(UV) sync --extra dev --reinstall-package texsmith-exam

# Aggregate targets, one variant across every series.
pset: $(addprefix pset-,$(SERIES_TARGETS))
light: $(addprefix light-,$(SERIES_TARGETS))
solution: $(addprefix solution-,$(SERIES_TARGETS))
check-code: $(addprefix check-code-,$(SERIES_TARGETS))

list:
	@for s in $(SERIES_TARGETS); do echo $$s; done

define series_rules
$(1): pset-$(1) light-$(1) solution-$(1)

check-code-$(1):
	$(call check_series_code,$(1))

pset-$(1): check-code-$(1)
	$(call build_variant,$(1),pset)

light-$(1): check-code-$(1)
	$(call build_variant,$(1),light)

solution-$(1): check-code-$(1)
	$(call build_variant,$(1),solution)
endef

$(foreach s,$(SERIES_TARGETS),$(eval $(call series_rules,$(s))))

# `make series-20` -> `make info2/series-20`
define series_alias_rules
$(notdir $(1)):        $(1)
pset-$(notdir $(1)):     pset-$(1)
light-$(notdir $(1)):    light-$(1)
solution-$(notdir $(1)): solution-$(1)
endef

$(foreach s,$(SERIES_TARGETS),$(eval $(call series_alias_rules,$(s))))

clean:
	rm -rf $(ROOT_DIR)/build

mrproper: clean
	rm -f $(ROOT_DIR)/dist/*.pdf

dist: all
	@mkdir -p dist
	@for d in build/series/*/*; do \
		group=$$(basename "$$(dirname "$$d")"); \
		name=$$(basename "$$d"); \
		if [ -f "$$d/$(FORMAT)/pset/pset.pdf" ]; then \
			cp "$$d/$(FORMAT)/pset/pset.pdf" "dist/pset-$${group}-$${name}.pdf"; \
		fi; \
		if [ -f "$$d/$(FORMAT)/light/light.pdf" ]; then \
			cp "$$d/$(FORMAT)/light/light.pdf" "dist/pset-$${group}-$${name}-light.pdf"; \
		fi; \
		if [ -f "$$d/$(FORMAT)/solution/solution.pdf" ]; then \
			cp "$$d/$(FORMAT)/solution/solution.pdf" "dist/pset-$${group}-$${name}-solution.pdf"; \
		fi; \
	done
	@for src in $(SERIES_DIR)/*/series-*.md; do \
		group=$$(basename "$$(dirname "$$src")"); \
		cp "$$src" "dist/$${group}-$$(basename "$$src")"; \
	done
	$(UV_RUN) --extra dev pelican pelican/content -s pelicanconf.py -o dist
