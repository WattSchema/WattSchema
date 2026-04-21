# WattSchema - Standard Power System Management Ontologies

Open-source ontologies for modeling data center power infrastructure, utility billing, and energy optimization, for both RDF and Microsoft Fabric.


## WattSChema

The WattSchema ontology, initially developed by [Hanwha Q CELLS](https://qcells.com/), provides a semantic model for **mission-critical power infrastructure** in data centers. It covers:

- **Power distribution** -- Switchgear, transformers, UPS, BESS, ATS/STS, PDUs, rack PDUs, busbars, generators
- **Telemetry and measurement** -- 40+ measurement types (power, energy, voltage, current, battery metrics, harmonics, temperature)
- **Spatial hierarchy** -- Sites, electrical rooms, data halls, battery rooms, generator yards, racks
- **Control and protection** -- Setpoints, controllers, KPIs, surge protection
- **Grid interconnection** -- Points of interconnection (POI), import/export limits
- **Value streams** -- Energy arbitrage, demand charge management, incentive programs

The WattSchema was known as the DCPM ontology during its development and we have not yet finished all the changes to its new name.

## Standards Alignment

The ontology is built on and interoperate with established standards:

| Standard | Usage |
|----------|-------|
| [Brick Schema](https://brickschema.org/) | Building and equipment taxonomy |
| [ASHRAE 223P](https://open223.info/) | Thermal systems and physical space modeling |
| [QUDT](https://qudt.org/) | Units, quantities, and dimensions |
| [OPC UA DI](https://opcfoundation.org/) | Device metadata and network properties |
| [W3C OWL/RDF/RDFS](https://www.w3.org/OWL/) | Core ontology language |
| [W3C SHACL](https://www.w3.org/TR/shacl/) | Data validation shapes |

## Repository Structure

```
WattSchema/ontology/
  WattSchema_Core/            # Core power management ontology in RDF, along with a few extensions to Brick  
  example_models/             # Instance data (mock data centers)
  document/                   # Ontology documentation and glossaries
  shacl_profiles/             # An example SHACL profile that is suitable for some (but not all) applications
  fabric_defs/                # SQL definitions of tables that can be used with Microsoft Fabric
scripts/                      # Validation tooling (Python). RDF only, for now.
```

## Quick Start

### Prerequisites

- Python 3.11+
- Git

### Setup

```bash
git clone https://github.com/WattSchema/WattSchema
cd WattSchema

python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

make install
```

### Validate

```bash
# Run all validations (parse + SHACL)
make validate

# Verbose output
make validate-verbose

# Validate a single file
python scripts/validate_rdf.py --file WattSchema/ontology/WattSchema_Core/WattSchema_CORE.ttl

# SHACL validation against a specific profile
python scripts/validate_rdf.py \
   --file WattSchema/example_models/simple_mock_dc.ttl \
   --validator shacl \
   --shacl-shapes your/site/specific/rules.ttl
```

### Explore the Ontology

The ontologies are in standard [Turtle](https://www.w3.org/TR/turtle/) format (`.ttl`). You can explore them with:

- Any text editor
- [Protege](https://protege.stanford.edu/) (ontology editor)
- [RDFLib](https://rdflib.readthedocs.io/) (Python)
- SPARQL queries against the loaded graph

## Example: Querying the Ontology

```sparql
# Find all power equipment types
SELECT ?device ?label WHERE {
  ?device rdfs:subClassOf* dcpm:PowerDeviceType .
  ?device rdfs:label ?label .
}

# Find all measurement types for a UPS
SELECT ?point ?label WHERE {
  ?ups a dcpm:UPSType .
  ?ups dcpm:hasTelemetryPoint ?point .
  ?point rdfs:label ?label .
}
```

## Microsoft Fabric Support
[Microsoft Fabric Ontology](https://learn.microsoft.com/en-us/fabric/iq/ontology/overview) is a new offering from Microsoft that has recently entered preview, and is a target for the WattSchema ontology. 
We are still early days with it, and we have provided SQL Table definitions suitable for a large subset of WattSchema. 
Fabric is largely driven from the Fabric Portal right now, but as Fabric Ontology matures we will provide additional support to make it easy to use the REST APIs to create a Fabric Ontology overlay for those tables.

## Documentation

| Document | Description |
|----------|-------------|
| [WattSchema Core Overview](WattSchema/ontology/document/WattSchema_CORE_OVERVIEW.md) | Full reference for all WattSchema classes, properties, and relationships |
| [WattSchema Glossary](WattSchema/ontology/document/WattSchema_Ontology_Glossary_v0.1.md) | Term definitions for all WattSchema entities |

## Validation

This repository includes automated validation using both **RDF parse checking** and **SHACL constraint validation**.

### What Gets Validated

| Rule | Type | Description |
|------|------|-------------|
| Watt Schema Core Ontologies | Parse | Core power management ontology files |
| Watt Schema Simple Mock (v1 SHACL) | SHACL | Validates `simple_mock_dc.ttl` against the optimization profile |

### SHACL Profiles

SHACL profiles in `WattSchema/ontology/shacl_profiles/` define possible **application-specific validation constraints**:

It is important to distinguish between different uses of SHACL:
- **Ontology-level constraints** -- Rules intrinsic to ontology semantics that apply to all users
- **Profile-level constraints** -- Rules that vary by use case (e.g., what telemetry points a chiller must expose for optimization)

The rules in the `shacl_profiles/example_profile` are intended to be a good starting point for many applications, but are not meant to be the universal set of SHACL rules that apply in all cases.  

### CI/CD

GitHub Actions automatically validates all RDF files on every push to `main` and every pull request. See [`.github/workflows/validate-rdf.yml`](.github/workflows/validate-rdf.yml).

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:

- Reporting bugs and proposing new terms
- Development setup and ontology editing conventions
- Pull request process and review criteria
- Naming conventions and file organization

## License

This project is licensed under the [BSD 3-Clause License](LICENSE).

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
