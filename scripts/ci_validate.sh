#!/usr/bin/env bash
# Thin wrapper for CI validation
# This script is called by GitHub Actions and can also be run locally

set -e  # Exit on first error

python scripts/validate_rdf.py "$@"
