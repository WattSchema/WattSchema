# Microsoft Fabric Support for Data Center Power Management Ontology

[Microsoft Fabric Ontology](https://learn.microsoft.com/en-us/fabric/iq/ontology/overview) is a new offering from Microsoft that has recently entered preview, and is a target for the DCPM ontology. 
We are still early days with it, and we have provided SQL Table definitions suitable for a large subset of DCPM. 

Fabric is largely driven from the Fabric Portal right now, but as Fabric Ontology matures we will provide additional support to make it easy to use the REST APIs to create a Fabric Ontology overlay for those tables.

## Table Definitions
Fabric Ontology requires that each type in the ontology is defined in its own table. 
This means that rather than having a larger "equipment" table with a 'type' column, we instead break each type off into its own table.
This may change as Fabric evolves, but for now, we are creating many tables.

The `fabric-ontology-schema.sql` file contains table definitions for many of the classes and relationships in the DCPM ontology.
It does not yet have every type and relationship, and is focused only on the DCPM_Core ontology and not companion ontologies such as Brick or RealEstateCore.

You should be able to use this file with an SQL Client or a script+OBDC drivers to create these tables in your Fabric workspace.

We hope to include a version of the simple_mock_datacenter, decomposed into CSV files to load into these tables.