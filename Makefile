.PHONY: validate validate-verbose install check-venv help

help:
	@echo "Available targets:"
	@echo "  validate         - Run RDF validation on all configured files"
	@echo "  validate-verbose - Run validation with detailed output"
	@echo "  install          - Install dependencies (requires active venv)"
	@echo ""
	@echo "Example usage:"
	@echo "  python -m venv venv"
	@echo "  source venv/bin/activate"
	@echo "  make install"
	@echo "  make validate"

check-venv:
	@if [ -z "$$VIRTUAL_ENV" ]; then \
		echo "❌ No virtual environment detected."; \
		echo "Please activate a venv first:"; \
		echo "  python -m venv venv && source venv/bin/activate"; \
		exit 1; \
	fi
	@echo "✓ Virtual environment active: $$VIRTUAL_ENV"

install: check-venv
	pip install -r requirements.txt

validate:
	python scripts/validate_rdf.py

validate-verbose:
	python scripts/validate_rdf.py --verbose
