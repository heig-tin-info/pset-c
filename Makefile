.PHONY: all pset light solution list clean mrproper dist deps deps-dev-template deps-reset-template $(SERIES_TARGETS)

ROOT_DIR := $(CURDIR)
UV := uv
UV_RUN := uv run --no-sync
TEXSMITH := $(UV_RUN) texsmith
SERIES_DIR := $(ROOT_DIR)/series
BUILD_ROOT := $(ROOT_DIR)/build/series
COMMON_CONFIG := $(SERIES_DIR)/common.yml
LIGHT_PREP_SCRIPT := $(ROOT_DIR)/scripts/prepare_light.py
CPP_FLAGS := -std=c++20 -Wall -Wextra -pedantic
TEMPLATE_EXAM_PATH ?= ../template-exam

SERIES_FILES := $(sort $(wildcard $(SERIES_DIR)/*/series-*.md))
SERIES_TARGETS := $(patsubst $(SERIES_DIR)/%,%,$(basename $(SERIES_FILES)))

define series_group
$(patsubst %/,%,$(dir $(1)))
endef

define series_name
$(notdir $(1))
endef

define series_id
$(patsubst series-%,%,$(call series_name,$(1)))
endef

define build_variant
	@name="$(1)"; \
	group="$(call series_group,$(1))"; \
	series="$(call series_name,$(1))"; \
	id="$(call series_id,$(1))"; \
	src="$(SERIES_DIR)/$(1).md"; \
	out="$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/$(2)"; \
	extra_args=""; \
	if [ "$(2)" = "light" ]; then \
		light_src="$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/light-src/$(call series_name,$(1)).md"; \
		mkdir -p "$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/light-src"; \
		ln -sfn "$(ROOT_DIR)/assets" "$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/assets"; \
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
	if [ "$(2)" = "pset" ]; then \
		cp "$$$$out/pset.pdf" "$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/$(call series_name,$(1)).pdf"; \
	elif [ "$(2)" = "light" ]; then \
		cp "$$$$out/light.pdf" "$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/$(call series_name,$(1))-light.pdf"; \
	elif [ "$(2)" = "solution" ]; then \
		cp "$$$$out/solution.pdf" "$(BUILD_ROOT)/$(call series_group,$(1))/$(call series_name,$(1))/$(call series_name,$(1))-solutions.pdf"; \
	fi
endef

define check_series_code
	@name="$(1)"; \
	group="$(call series_group,$(1))"; \
	series="$(call series_name,$(1))"; \
	id="$(call series_id,$(1))"; \
	assets_dir="$(SERIES_DIR)/$(call series_group,$(1))/assets/$(call series_id,$(1))"; \
	if [ -d "$$$$assets_dir" ]; then \
		cpp_sources=$$$$(find "$$$$assets_dir" -maxdepth 1 -type f -name '*.cpp'); \
		if [ -n "$$$$cpp_sources" ]; then \
			g++ $(CPP_FLAGS) -c $$$$cpp_sources; \
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
light: $(addprefix light-,$(SERIES_TARGETS))
solution: $(addprefix solution-,$(SERIES_TARGETS))

list:
	@for s in $(SERIES_TARGETS); do echo $$s; done

define series_rules
$(1): pset-$(1) light-$(1) solution-$(1)

pset-$(1):
	$(call check_series_code,$(1))
	$(call build_variant,$(1),pset)

light-$(1):
	$(call check_series_code,$(1))
	$(call build_variant,$(1),light)

solution-$(1):
	$(call check_series_code,$(1))
	$(call build_variant,$(1),solution)
endef

$(foreach s,$(SERIES_TARGETS),$(eval $(call series_rules,$(s))))

clean:
	rm -rf $(ROOT_DIR)/build

mrproper: clean
	rm -f $(ROOT_DIR)/dist/*.pdf

dist: all
	@mkdir -p dist
	@for d in build/series/*/*; do \
		group=$$(basename "$$(dirname "$$d")"); \
		name=$$(basename "$$d"); \
		if [ -f "$$d/pset/pset.pdf" ]; then \
			cp "$$d/pset/pset.pdf" "dist/pset-$${group}-$${name}.pdf"; \
		fi; \
		if [ -f "$$d/light/light.pdf" ]; then \
			cp "$$d/light/light.pdf" "dist/pset-$${group}-$${name}-light.pdf"; \
		fi; \
		if [ -f "$$d/solution/solution.pdf" ]; then \
			cp "$$d/solution/solution.pdf" "dist/pset-$${group}-$${name}-solution.pdf"; \
		fi; \
	done
	@for src in $(SERIES_DIR)/*/series-*.md; do \
		cp "$$src" "dist/$$(basename "$$src")"; \
	done
	$(UV_RUN) --extra dev pelican pelican/content -s pelicanconf.py -o dist
