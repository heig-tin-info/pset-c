.PHONY: all pset solution check-code clean

TEXSMITH := uv run texsmith
ROOT_DIR := $(abspath ../..)
PSET_DIR := $(CURDIR)
PSET_DIR_REL := $(patsubst $(ROOT_DIR)/%,%,$(PSET_DIR))
BUILD_DIR := $(ROOT_DIR)/build/$(PSET_DIR_REL)
CONFIG_COMMON := $(ROOT_DIR)/series/common.yml
CONFIG := $(CONFIG_COMMON) $(PSET_DIR)/config.yml
SOURCES := $(wildcard $(PSET_DIR)/*.md)
MAIN_SOURCE := $(firstword $(SOURCES))
OUTPUT_BASENAME := $(basename $(notdir $(MAIN_SOURCE)))
TEMPLATE := exam
ASSET_DIR := $(PSET_DIR)/assets
CPP_SOURCES := $(wildcard $(ASSET_DIR)/*.cpp)
CPP_FLAGS := -std=c++20 -Wall -Wextra -pedantic

all: check-code pset solution

check-code:
ifneq ($(strip $(CPP_SOURCES)),)
	g++ $(CPP_FLAGS) -c $(CPP_SOURCES)
endif

pset: check-code
	mkdir -p $(BUILD_DIR)/pset
	$(TEXSMITH) -o$(BUILD_DIR)/pset -t$(TEMPLATE) $(CONFIG) $(SOURCES) --build
	@if [ -f "$(BUILD_DIR)/pset/main.pdf" ]; then \
		mv "$(BUILD_DIR)/pset/main.pdf" "$(BUILD_DIR)/pset/pset.pdf"; \
	elif [ -f "$(BUILD_DIR)/pset/$(OUTPUT_BASENAME).pdf" ]; then \
		mv "$(BUILD_DIR)/pset/$(OUTPUT_BASENAME).pdf" "$(BUILD_DIR)/pset/pset.pdf"; \
	else \
		echo "No PDF output found in $(BUILD_DIR)/pset"; \
		exit 1; \
	fi

solution: check-code
	mkdir -p $(BUILD_DIR)/solution
	$(TEXSMITH) -o$(BUILD_DIR)/solution -t$(TEMPLATE) $(CONFIG) $(SOURCES) --build -a solution=true
	@if [ -f "$(BUILD_DIR)/solution/main.pdf" ]; then \
		mv "$(BUILD_DIR)/solution/main.pdf" "$(BUILD_DIR)/solution/solution.pdf"; \
	elif [ -f "$(BUILD_DIR)/solution/$(OUTPUT_BASENAME).pdf" ]; then \
		mv "$(BUILD_DIR)/solution/$(OUTPUT_BASENAME).pdf" "$(BUILD_DIR)/solution/solution.pdf"; \
	else \
		echo "No PDF output found in $(BUILD_DIR)/solution"; \
		exit 1; \
	fi

clean:
	rm -rf $(BUILD_DIR)
