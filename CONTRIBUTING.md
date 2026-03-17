# Contributing to DCPM & UUDRI Ontologies

Thank you for your interest in contributing to the Data Center Power Management (DCPM) and Unified Utility Data Reconciliation & Intelligence (UUDRI) ontologies. This document explains how to get involved.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Ontology Editing Guidelines](#ontology-editing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Proposing New Terms](#proposing-new-terms)
- [Reporting Issues](#reporting-issues)
- [License](#license)

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to the maintainers.

## How to Contribute

There are several ways to contribute:

- **Report bugs** -- file an issue if you find errors in the ontology, SHACL profiles, or validation scripts
- **Propose new terms** -- suggest new classes, properties, or relationships via the issue tracker
- **Improve documentation** -- clarify definitions, add examples, fix typos
- **Add example models** -- contribute new instance data demonstrating ontology usage
- **Add or improve SHACL profiles** -- create validation profiles for new use cases
- **Fix validation scripts** -- improve the Python validation tooling

## Development Setup

### Prerequisites

- Python 3.11+
- Git

### Getting Started

1. **Fork** the repository on GitHub.

2. **Clone** your fork:
   ```bash
   git clone https://github.com/<your-username>/draft-openpowerontology.git
   cd draft-openpowerontology
   ```

3. **Create a virtual environment** and install dependencies:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   make install
   ```

4. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

5. **Validate** before committing:
   ```bash
   make validate
   ```

## Ontology Editing Guidelines

We edit ontology files directly in Turtle (`.ttl`) format. We do not currently use tools like Protege or TopBraid Composer.

### General Rules

- **Use Turtle syntax** (`.ttl`) for all ontology files.
- **Use consistent prefixes** -- follow the prefix declarations already established in each file.
- **Annotate everything** -- every class and property must have at minimum:
  - `rdfs:label` -- a human-readable name
  - `rdfs:comment` -- a concise definition
- **Reuse existing vocabularies** where possible (Brick, QUDT, ASHRAE 223, OWL, RDFS).
- **Do not change namespace URIs** without discussion in an issue first.

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `dcpm:ChillerPlant`)
- **Properties**: `camelCase` (e.g., `dcpm:hasCoolingCapacity`)
- **Individuals/Instances**: `snake_case` or `camelCase` as appropriate to the context

### File Organization

```
DCPM/ontology/
  dcpmsrc/           # Source ontology files
    DCPM_Core/       # Core ontology and extensions
  example_models/    # Instance data examples
  shacl_profiles/    # SHACL validation profiles
  document/          # Ontology documentation

```

## Pull Request Process

1. **Validate locally** -- run `make validate` and ensure all checks pass.
2. **Keep PRs focused** -- one logical change per pull request.
3. **Write a clear description** -- explain what changed and why.
4. **Reference issues** -- link to any related GitHub issues (e.g., `Closes #42`).
5. **Update documentation** -- if your change adds or modifies terms, update the relevant glossary or documentation files.
6. **Wait for CI** -- the GitHub Actions workflow will automatically validate your RDF files. All checks must pass before merging.
7. **Request review** -- a maintainer will review your changes. Be prepared to iterate.

### What We Look For in Reviews

- Correctness of RDF syntax and OWL semantics
- Consistency with existing naming conventions and patterns
- Adequate `rdfs:label` and `rdfs:comment` annotations
- SHACL profile coverage for new data shapes
- No unintended breaking changes to existing terms

## Proposing New Terms

To propose a new class, property, or relationship:

1. **Open an issue** using the "Term Proposal" template (if available) or a blank issue.
2. Include:
   - **Term name** -- the proposed URI local name
   - **Type** -- class, object property, datatype property, or individual
   - **Definition** -- a clear, concise description
   - **Rationale** -- why this term is needed
   - **Scope** -- which ontology it belongs in (DCPM Core, DCPM Extension, UUDRI)
   - **Examples** -- how the term would be used in instance data
   - **References** -- links to standards or prior art (e.g., Brick, ASHRAE 223, QUDT)
3. Discussion will happen in the issue before implementation.
4. Once approved, submit a pull request with the implementation.

### Breaking Changes

Changes that modify or remove existing terms are considered breaking changes. These require:
- A dedicated issue with the "breaking change" label
- Discussion period (minimum 2 weeks)
- A migration guide if existing instance data would be affected
- A major version bump

## Reporting Issues

When filing an issue, please include:

- **Type**: bug, term proposal, documentation, question
- **Description**: what you observed or what you need
- **Steps to reproduce** (for bugs): commands run, files involved
- **Expected behavior** (for bugs): what should have happened
- **Environment** (for validation bugs): Python version, OS, rdflib version

## License

By contributing to this project, you agree that your contributions will be licensed under the [BSD 3-Clause License](LICENSE).
