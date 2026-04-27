# Watt Schema Power System SHACL Shapes

> **Namespace:** `wattsch: <https://qcells.com/schema/dcpm/#>`
> **Ontologies referenced:** Brick (`brick:`), ASHRAE 223 (`s223:`), QUDT Units (`unit:`), QUDT Schema (`qudt:`)

This document describes the SHACL node shapes defined for the Watt Schema ontology. Each shape enforces structural and telemetry constraints on power system equipment.

Applications are not required to use it, but it is a recommended set of constraints that will be helpful for many applications.

> **Unit path:** All unit constraints accept either `brick:hasUnit` **or** `qudt:hasUnit` via `sh:alternativePath ( brick:hasUnit qudt:hasUnit )`.

---

## Table of Contents

1. [SiteShape](#siteshape)
2. [POIShape](#poishape)
3. [UtilityMeterShape](#utilitymetershape)
4. [TransformerShape](#transformershape)
5. [SwitchgearShape](#switchgearshape)
6. [GeneratorShape](#generatorshape)
7. [ATSShape](#atsshape)
8. [STSShape](#stsshape)
9. [UPSShape](#upsshape)
10. [BESSShape](#bessshape)
11. [BMSShape](#bmsshape)
12. [PDUShape](#pdushape)
13. [RackPDUShape](#rackpdushape)
14. [BuswayShape](#buswayshape)
15. [ITRackShape](#itrackshape)
16. [FeederShape](#feedershape)
17. [MCCShape](#mccshape)
18. [MotorFeederShape](#motorfeeder-shape)
19. [SPDShape](#spdshape)
20. [GroundingNetworkShape](#groundingnetworkshape)
21. [PQMeterShape](#pqmetershape)
22. [ControllerShape](#controllershape)
23. [GatewayShape](#gatewayshape)
24. [ElectricalRoomShape](#electricalroomshape)
25. [DataHallShape](#datahallshape)
26. [BatteryRoomShape](#batteryroomshape)
27. [GeneratorYardShape](#generatoryardshape)
28. [GeneratorRoomShape](#generatorroomshape)
29. [TelemetryPointShape](#telemetrypointshape)
30. [TelemetryStreamShape](#telemetrystreamshape)

---

## SiteShape

**Shape IRI:** `wattsch:SiteShape`
**Target Class:** `wattsch:SiteType`
**Description:** SHACL shape requiring each site to have proper power system components.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Datatype | Description |
|---|---|---|---|---|---|---|
| `wattsch:latitude` | Site Latitude | — | 1 | — | `xsd:float` | Site must include latitude in decimal degrees |
| `wattsch:longitude` | Site Longitude | — | 1 | — | `xsd:float` | Site must include longitude in decimal degrees |
| `wattsch:siteId` | Site Identifier | — | 1 | — | `xsd:string` | Site must have a unique identifier |
| `wattsch:hasPointOfInterconnection` | Point of Interconnection | `wattsch:PointOfInterconnection` | — | — | — | Site's grid connection point(s) |
| `wattsch:hasValueStream` | Value Stream | `wattsch:ValueStream` | — | — | — | Revenue or cost optimization pathway associated with the site |
| `wattsch:containsEquipment` | Contains Equipment | `wattsch:PowerDeviceType` | — | — | — | Power devices physically contained within the site |
| `wattsch:isLocationOf` | Is Location Of | `wattsch:PowerDeviceType` | — | — | — | Power devices located at this site |
| `rec:ownedBy` | Owned By | `rec:Organization` | 1 | 1 | — | Site must be owned by exactly one Organization |

---

## POIShape

**Shape IRI:** `wattsch:POIShape`
**Target Class:** `wattsch:PointOfInterconnection`
**Description:** SHACL shape for grid interconnection points.

| Property Path | Name | Allowed Class(es) | Description |
|---|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:UtilityMeterType` | POI feeds utility meter |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:UtilityMeterType` | POI supplies power to utility meter |
| `wattsch:hasValueStream` | Value Stream | `wattsch:ValueStream` | Value stream program associated with this POI |

---

## UtilityMeterShape

**Shape IRI:** `wattsch:UtilityMeterShape`
**Target Class:** `wattsch:UtilityMeterType`
**Description:** SHACL shape defining required telemetry points and relationships for utility meters.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Import Active Power Point | `wattsch:ImportActivePower` or `wattsch:ActivePower` | `unit:KiloW` | 1 | Utility meter must track imported active power (kW) |
| Import Active Energy Point | `wattsch:ImportActiveEnergy` or `wattsch:ActiveEnergy` | `unit:KiloW-HR` | 1 | Utility meter must track imported active energy (kWh) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:TransformerType` \| `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:ATSType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:TransformerType` \| `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:ATSType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SPDType` \| `wattsch:SwitchgearType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:PQMeterType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` \| `wattsch:SiteType` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |
| `wattsch:hasValueStream` | hasValueStream target | `wattsch:ValueStream` |

---

## TransformerShape

**Shape IRI:** `wattsch:TransformerShape`
**Target Class:** `wattsch:TransformerType`
**Description:** SHACL shape requiring transformer to have monitoring, connectivity, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Primary Side Voltage Point | `wattsch:PrimaryKV` | `unit:KiloV` | 1 | Transformer must monitor primary side voltage (kV) |
| Secondary Side Voltage Point | `wattsch:SecondaryKV` | `unit:KiloV` | 1 | Transformer must monitor secondary side voltage (kV) |
| Active Power Point | `wattsch:ActivePower` | `unit:KiloW` | 1 | Transformer must monitor active power throughput (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:ATSType` \| `wattsch:SwitchgearType` \| `wattsch:UPSType` |
| `wattsch:fedBy` | fedBy source | `wattsch:UtilityMeterType` \| `wattsch:GeneratorSetType` \| `wattsch:SwitchgearType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:ATSType` \| `wattsch:SwitchgearType` \| `wattsch:UPSType` |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:UtilityMeterType` \| `wattsch:GeneratorSetType` \| `wattsch:SwitchgearType` |
| `wattsch:primarySource` | primarySource | `wattsch:UtilityMeterType` \| `wattsch:GeneratorSetType` |
| `wattsch:backupSource` | backupSource | `wattsch:GeneratorSetType` \| `wattsch:UtilityMeterType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:SPDType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:PQMeterType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` \| `wattsch:SiteType` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |

---

## SwitchgearShape

**Shape IRI:** `wattsch:SwitchgearShape`
**Target Class:** `wattsch:SwitchgearType`
**Description:** SHACL shape requiring switchgear to have rated specifications, telemetry, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:ratedVoltage` | Rated Voltage | — | 1 | Switchgear must have a rated voltage specification |
| `wattsch:busbarRating` | Busbar Current Rating | `xsd:float` | 1 | Switchgear must specify busbar current rating in amperes |
| `wattsch:breakerCount` | Breaker Count | `xsd:integer` | — | Number of circuit breakers installed in switchgear |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Bus Active Power Point | `wattsch:ActivePower` | `unit:KiloW` | 1 | Switchgear must monitor bus active power (kW) |
| Bus Voltage Point | `wattsch:Voltage` | `unit:V` | 1 | Switchgear must monitor bus voltage (V) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:UPSType` \| `wattsch:BESSType` \| `wattsch:PDUType` \| `wattsch:TransformerType` \| `wattsch:BuswayType` \| `wattsch:MCCType` | 1 |
| `wattsch:fedBy` | fedBy source | `wattsch:ATSType` \| `wattsch:TransformerType` \| `wattsch:UtilityMeterType` \| `wattsch:BESSType` | — |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:UPSType` \| `wattsch:BESSType` \| `wattsch:PDUType` \| `wattsch:TransformerType` \| `wattsch:BuswayType` \| `wattsch:MCCType` | — |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:ATSType` \| `wattsch:TransformerType` \| `wattsch:UtilityMeterType` \| `wattsch:BESSType` | — |
| `wattsch:primarySource` | primarySource | `wattsch:ATSType` \| `wattsch:TransformerType` \| `wattsch:UtilityMeterType` | — |
| `wattsch:backupSource` | backupSource | `wattsch:GeneratorSetType` \| `wattsch:BESSType` \| `wattsch:ATSType` | — |
| `wattsch:protects` | protects target | `wattsch:UPSType` \| `wattsch:TransformerType` \| `wattsch:PDUType` \| `wattsch:BESSType` \| `wattsch:FeederType` | — |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SPDType` \| `wattsch:SwitchgearType` | — |
| `wattsch:connectedTo` | connectedTo target | `wattsch:PQMeterType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` | — |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` | — |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` | — |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` | — |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` | — |
| `wattsch:hasValueStream` | hasValueStream target | `wattsch:ValueStream` | — |

---

## GeneratorShape

**Shape IRI:** `wattsch:GeneratorShape`
**Target Class:** `wattsch:GeneratorSetType`
**Description:** SHACL shape requiring generator to have fuel monitoring, operating status, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:fuelType` | Fuel Type Metadata | `xsd:string` | 1 | Generator must specify fuel type (Diesel, Natural Gas, Propane, etc.) |
| `wattsch:ratedPower` | Rated Power | — | 1 | Generator must have rated power capacity |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Fuel Level Point | `wattsch:FuelLevel` | `unit:PERCENT` | 1 | Generator must monitor fuel level (%) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:ATSType` \| `wattsch:SwitchgearType` \| `wattsch:TransformerType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:ATSType` \| `wattsch:SwitchgearType` \| `wattsch:TransformerType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:SPDType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:GeneratorYard` \| `wattsch:GeneratorRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |

---

## ATSShape

**Shape IRI:** `wattsch:ATSShape`
**Target Class:** `wattsch:ATSType`
**Description:** SHACL shape requiring ATS to have source selection, monitoring, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:transferTimeMS` | Transfer Time (ms) | `xsd:float` | — | ATS transfer time during source changeover in milliseconds |
| `wattsch:numberOfPoles` | Number of Poles | `xsd:integer` | 1 | ATS must specify number of poles (1P, 2P, 3P, 4P) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:SwitchgearType` \| `wattsch:UPSType` \| `wattsch:TransformerType` | 1 |
| `wattsch:fedBy` | fedBy source | `wattsch:TransformerType` \| `wattsch:UtilityMeterType` \| `wattsch:GeneratorSetType` | — |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:SwitchgearType` \| `wattsch:UPSType` \| `wattsch:TransformerType` | — |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:TransformerType` \| `wattsch:UtilityMeterType` \| `wattsch:GeneratorSetType` | — |
| `wattsch:primarySource` | primarySource | `wattsch:TransformerType` \| `wattsch:UtilityMeterType` | — |
| `wattsch:backupSource` | backupSource | `wattsch:GeneratorSetType` \| `wattsch:TransformerType` | — |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:SPDType` | — |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` | — |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` | — |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` | — |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` | — |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` | — |

---

## STSShape

**Shape IRI:** `wattsch:STSShape`
**Target Class:** `wattsch:STSType`
**Description:** SHACL shape requiring STS to have advanced monitoring and control capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:transferTimeMS` | Transfer Time (ms) | `xsd:float` | 1 | STS must specify ultra-fast transfer time in milliseconds |
| `wattsch:numberOfPoles` | Number of Poles | `xsd:integer` | 1 | STS must specify number of poles |

---

## UPSShape

**Shape IRI:** `wattsch:UPSShape`
**Target Class:** `wattsch:UPSType`
**Description:** SHACL shape requiring UPS to have battery health, runtime monitoring, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| State of Charge Point | `wattsch:SoC` | `unit:PERCENT` | 1 | UPS must monitor battery state of charge (%) |
| State of Health Point | `wattsch:SoH` | `unit:PERCENT` | 1 | UPS must monitor battery state of health (%) |
| Remaining Backup Time Point | `wattsch:RemainingTime` | `unit:MIN` | 1 | UPS must provide remaining runtime estimation (min) |
| Input Active Power Point | `wattsch:ImportActivePower` | `unit:KiloW` | 1 | UPS must monitor input active power (kW) |
| Output Active Power Point | `wattsch:ExportActivePower` | `unit:KiloW` | 1 | UPS must monitor output active power (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:PDUType` \| `wattsch:BuswayType` \| `wattsch:STSType` | 1 |
| `wattsch:fedBy` | fedBy source | `wattsch:SwitchgearType` \| `wattsch:ATSType` \| `wattsch:TransformerType` | — |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:PDUType` \| `wattsch:BuswayType` \| `wattsch:STSType` | — |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:SwitchgearType` \| `wattsch:ATSType` \| `wattsch:TransformerType` | — |
| `wattsch:primarySource` | primarySource | `wattsch:SwitchgearType` \| `wattsch:ATSType` | — |
| `wattsch:backupSource` | backupSource | `wattsch:SwitchgearType` \| `wattsch:ATSType` | — |
| `wattsch:protects` | protects target | `wattsch:PDUType` \| `wattsch:BuswayType` | — |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:SPDType` | — |
| `wattsch:connectedTo` | connectedTo target | `wattsch:BMSType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` | — |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` | — |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` | — |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` | — |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` | — |

---

## BESSShape

**Shape IRI:** `wattsch:BESSShape`
**Target Class:** `wattsch:BESSType`
**Description:** SHACL shape requiring BESS to have monitoring capabilities and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:ratedStorageCapacity` | Rated Storage Capacity | — | 1 | BESS must specify rated energy storage capacity (kWh) |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| State of Charge | `wattsch:SoC` | `unit:PERCENT` | 1 | BESS must monitor state of charge (%) |
| State of Health | `wattsch:SoH` | `unit:PERCENT` | 1 | BESS should monitor state of health (%) |
| Minimum State of Charge | `wattsch:MinSOC` | `unit:PERCENT` | 1 | BESS minimum SoC limit |
| Maximum State of Charge | `wattsch:MaxSOC` | `unit:PERCENT` | 1 | BESS maximum SoC limit |
| Charge Power Setpoint | `wattsch:ChargePowerSetpoint` | `unit:KiloW` | 1 | BESS charge power setpoint (kW) |
| Discharge Power Setpoint | `wattsch:DischargePowerSetpoint` | `unit:KiloW` | 1 | BESS discharge power setpoint (kW) |
| Charge Efficiency | `wattsch:ChargeEfficiency` | `unit:UNITLESS` | 1 | BESS charge efficiency (unitless ratio, 0–1) |
| Discharge Efficiency | `wattsch:DischargeEfficiency` | `unit:UNITLESS` | 1 | BESS discharge efficiency (unitless ratio, 0–1) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds (discharge) target | `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:fedBy` | fedBy (charge) source | `wattsch:SwitchgearType` \| `wattsch:BuswayType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo (discharge) target | `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:suppliedBy` | suppliedBy (charge) source | `wattsch:SwitchgearType` \| `wattsch:BuswayType` |
| `wattsch:primarySource` | primarySource (charging source) | `wattsch:SwitchgearType` \| `wattsch:BuswayType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:SPDType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:BMSType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` \| `wattsch:BatteryRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |
| `wattsch:hasValueStream` | hasValueStream target | `wattsch:ValueStream` |

---

## BMSShape

**Shape IRI:** `wattsch:BMSShape`
**Target Class:** `wattsch:BMSType`
**Description:** SHACL shape for BMS monitoring and connection.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:connectedTo` | connectedTo target | `wattsch:BESSType` \| `wattsch:UPSType` \| `wattsch:GatewayType` \| `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:BatteryRoom` \| `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## PDUShape

**Shape IRI:** `wattsch:PDUShape`
**Target Class:** `wattsch:PDUType`
**Description:** SHACL shape requiring PDU to have power monitoring, distribution, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:circuitCount` | Circuit Count | `xsd:integer` | 1 | PDU must specify number of electrical circuits |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Input Active Power | `wattsch:ImportActivePower` or `wattsch:ActivePower` | `unit:KiloW` | 1 | PDU must monitor input active power (kW) |
| Voltage Monitoring | `wattsch:Voltage` or `wattsch:InputVoltageLN` | `unit:V` | 1 | PDU must monitor input voltage |
| Input Current Point | `wattsch:Current` | `unit:A` | 1 | PDU must monitor input current (A) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:BuswayType` \| `wattsch:RackPDUType` \| `wattsch:ITRackType` |
| `wattsch:fedBy` | fedBy source | `wattsch:UPSType` \| `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:STSType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:BuswayType` \| `wattsch:RackPDUType` \| `wattsch:ITRackType` |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:UPSType` \| `wattsch:SwitchgearType` \| `wattsch:BuswayType` \| `wattsch:STSType` |
| `wattsch:primarySource` | primarySource | `wattsch:UPSType` \| `wattsch:SwitchgearType` |
| `wattsch:backupSource` | backupSource | `wattsch:UPSType` \| `wattsch:SwitchgearType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:UPSType` \| `wattsch:SwitchgearType` \| `wattsch:SPDType` |
| `wattsch:protects` | protects target | `wattsch:RackPDUType` \| `wattsch:ITRackType` \| `wattsch:BuswayType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` \| `wattsch:DataHall` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |

---

## RackPDUShape

**Shape IRI:** `wattsch:RackPDUShape`
**Target Class:** `wattsch:RackPDUType`
**Description:** SHACL shape requiring rack PDUs to have outlet-level power monitoring and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:outletCount` | Outlet Count | `xsd:integer` | 1 | Rack PDU must specify number of power outlets |
| `wattsch:circuitCount` | Circuit Count | `xsd:integer` | 1 | Rack PDU must specify number of circuits |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Input Voltage Point | `wattsch:InputVoltageLN` | `unit:V` | 1 | Rack PDU must monitor input line-to-neutral voltage (V) |
| Output Power Point | `wattsch:ExportActivePower` | `unit:KiloW` | 1 | Rack PDU must monitor output active power (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:ITRackType` |
| `wattsch:fedBy` | fedBy source | `wattsch:PDUType` \| `wattsch:BuswayType` \| `wattsch:UPSType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:ITRackType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:DataHall` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## BuswayShape

**Shape IRI:** `wattsch:BuswayShape`
**Target Class:** `wattsch:BuswayType`
**Description:** SHACL shape requiring busway to have monitoring, connections, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Power Monitoring | `wattsch:InputActivePower` | `unit:KiloW` | 1 | Busway must have power monitoring capabilities (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:PDUType` \| `wattsch:RackPDUType` \| `wattsch:RPPType` \| `wattsch:ITRackType` \| `wattsch:BESSType` |
| `wattsch:fedBy` | fedBy source | `wattsch:UPSType` \| `wattsch:PDUType` \| `wattsch:SwitchgearType` \| `wattsch:BESSType` |
| `wattsch:suppliesPowerTo` | suppliesPowerTo target | `wattsch:PDUType` \| `wattsch:RackPDUType` \| `wattsch:RPPType` \| `wattsch:ITRackType` \| `wattsch:BESSType` |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:UtilityMeterType` \| `wattsch:UPSType` \| `wattsch:SwitchgearType` \| `wattsch:BESSType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` \| `wattsch:UPSType` \| `wattsch:SPDType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:ControllerType` \| `wattsch:PQMeterType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:DataHall` \| `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |
| `wattsch:hasSOP` | hasSOP target | `wattsch:SOP` |

---

## ITRackShape

**Shape IRI:** `wattsch:ITRackShape`
**Target Class:** `wattsch:ITRackType`
**Description:** Terminal load — consumes power only.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Active Power | `wattsch:ActivePower` | `unit:KiloW` | 1 | IT Rack power consumption (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:fedBy` | fedBy source | `wattsch:RackPDUType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:suppliedBy` | suppliedBy source | `wattsch:RackPDUType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:primarySource` | primarySource | `wattsch:RackPDUType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:backupSource` | backupSource | `wattsch:RackPDUType` \| `wattsch:BuswayType` \| `wattsch:PDUType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:DataHall` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## FeederShape

**Shape IRI:** `wattsch:FeederShape`
**Target Class:** `wattsch:FeederType`
**Description:** Individual feeder circuit within a switchgear.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:fedBy` | fedBy source | `wattsch:SwitchgearType` |
| `wattsch:feeds` | feeds target | `wattsch:TransformerType` \| `wattsch:UPSType` \| `wattsch:PDUType` \| `wattsch:MCCType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:SwitchgearType` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## MCCShape

**Shape IRI:** `wattsch:MCCShape`
**Target Class:** `wattsch:MCCType`
**Description:** SHACL shape for motor control centers.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:feeds` | feeds target | `wattsch:MotorFeederType` |
| `wattsch:fedBy` | fedBy source | `wattsch:SwitchgearType` \| `wattsch:TransformerType` \| `wattsch:PDUType` |
| `wattsch:protects` | protects target | `wattsch:MotorFeederType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## MotorFeeder Shape

**Shape IRI:** `wattsch:MotorFeederShape`
**Target Class:** `wattsch:MotorFeederType`
**Description:** Individual motor starter/feeder within an MCC.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:fedBy` | fedBy source | `wattsch:MCCType` |
| `wattsch:protectedBy` | protectedBy source | `wattsch:MCCType` |
| `wattsch:controlledBy` | controlledBy source | `wattsch:ControllerType` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## SPDShape

**Shape IRI:** `wattsch:SPDShape`
**Target Class:** `wattsch:SPDType`
**Description:** SHACL shape for surge protection devices.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:protects` | protects target | `wattsch:SwitchgearType` \| `wattsch:TransformerType` \| `wattsch:PDUType` \| `wattsch:UPSType` \| `wattsch:BuswayType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## GroundingNetworkShape

**Shape IRI:** `wattsch:GroundingNetworkShape`
**Target Class:** `wattsch:GroundingNetworkType`
**Description:** SHACL shape for grounding and bonding network.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:protects` | protects target | `wattsch:PowerDeviceType` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## PQMeterShape

**Shape IRI:** `wattsch:PQMeterShape`
**Target Class:** `wattsch:PQMeterType`
**Description:** SHACL shape requiring power quality meters to have comprehensive monitoring.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Total Harmonic Distortion Voltage | `wattsch:THDV` | `unit:PERCENT` | 1 | PQ Meter must measure voltage THD (%) |
| Total Harmonic Distortion Current | `wattsch:THDI` | `unit:PERCENT` | 1 | PQ Meter must measure current THD (%) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:connectedTo` | connectedTo target | `wattsch:PowerDeviceType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## ControllerShape

**Shape IRI:** `wattsch:ControllerShape`
**Target Class:** `wattsch:ControllerType`
**Description:** SHACL shape requiring controllers to have monitoring, control, and connection capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:communicationProtocol` | Communication Protocol | `xsd:string` | 1 | Controller must support a communication protocol (Modbus TCP, BACnet, OPC UA, etc.) |
| `wattsch:ipAddress` | IP Address | `xsd:string` | 1 | Controller must have a network address |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:controls` | controls target | `wattsch:PowerDeviceType` |
| `wattsch:connectedTo` | connectedTo target | `wattsch:GatewayType` \| `wattsch:PowerDeviceType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## GatewayShape

**Shape IRI:** `wattsch:GatewayShape`
**Target Class:** `wattsch:GatewayType`
**Description:** SHACL shape requiring gateways to have communication and aggregation capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `wattsch:communicationProtocol` | Communication Protocol | `xsd:string` | 1 | Gateway must support communication protocols |
| `wattsch:ipAddress` | IP Address | `xsd:string` | 1 | Gateway must have a network address |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:connectedTo` | connectedTo target | `wattsch:ControllerType` \| `wattsch:PowerDeviceType` |
| `wattsch:hasLocation` | hasLocation target | `wattsch:ElectricalRoom` |
| `wattsch:hasDocument` | hasDocument target | `wattsch:Document` |

---

## ElectricalRoomShape

**Shape IRI:** `wattsch:ElectricalRoomShape`
**Target Class:** `wattsch:ElectricalRoom`
**Description:** Physical space containing electrical infrastructure.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:containsEquipment` | containsEquipment target | `wattsch:SwitchgearType` \| `wattsch:TransformerType` \| `wattsch:UPSType` \| `wattsch:PDUType` \| `wattsch:ATSType` \| `wattsch:ControllerType` \| `wattsch:GatewayType` \| `wattsch:PQMeterType` \| `wattsch:SPDType` |
| `wattsch:isLocationOf` | isLocationOf target | `wattsch:PowerDeviceType` |

---

## DataHallShape

**Shape IRI:** `wattsch:DataHallShape`
**Target Class:** `wattsch:DataHall`
**Description:** Physical space containing IT equipment and last-mile power distribution.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:containsEquipment` | containsEquipment target | `wattsch:ITRackType` \| `wattsch:RackPDUType` \| `wattsch:BuswayType` \| `wattsch:PDUType` \| `wattsch:RPPType` |
| `wattsch:isLocationOf` | isLocationOf target | `wattsch:PowerDeviceType` |

---

## BatteryRoomShape

**Shape IRI:** `wattsch:BatteryRoomShape`
**Target Class:** `wattsch:BatteryRoom`
**Description:** Physical space housing battery storage systems.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:containsEquipment` | containsEquipment target | `wattsch:BESSType` \| `wattsch:BMSType` |
| `wattsch:isLocationOf` | isLocationOf target | `wattsch:PowerDeviceType` |

---

## GeneratorYardShape

**Shape IRI:** `wattsch:GeneratorYardShape`
**Target Class:** `wattsch:GeneratorYard`
**Description:** Outdoor area hosting generator sets.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:containsEquipment` | containsEquipment target | `wattsch:GeneratorSetType` |

---

## GeneratorRoomShape

**Shape IRI:** `wattsch:GeneratorRoomShape`
**Target Class:** `wattsch:GeneratorRoom`
**Description:** Indoor room housing generator sets.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `wattsch:containsEquipment` | containsEquipment target | `wattsch:GeneratorSetType` |

---

## TelemetryPointShape

**Shape IRI:** `wattsch:TelemetryPointShape`
**Target Class:** `wattsch:TelemetryPoint`
**Description:** A single measured or setpoint value associated with a power device or telemetry stream.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Description |
|---|---|---|---|---|---|
| `wattsch:isTelemetryOf` | isTelemetryOf target | `wattsch:PowerDeviceType` \| `wattsch:TelemetryStream` | — | — | Associates the point with its owning device or stream |
| `wattsch:hasPhase` | hasPhase target | `wattsch:Phase` | — | 1 | A telemetry point is associated with at most one electrical phase |

---

## TelemetryStreamShape

**Shape IRI:** `wattsch:TelemetryStreamShape`
**Target Class:** `wattsch:TelemetryStream`
**Description:** A named collection of telemetry points belonging to exactly one power device.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Description |
|---|---|---|---|---|---|
| `wattsch:isTelemetryStreamOf` | isTelemetryStreamOf target | `wattsch:PowerDeviceType` | 1 | 1 | A telemetry stream belongs to exactly one power device |
| `wattsch:hasTelemetryPoint` | hasTelemetryPoint target | `wattsch:TelemetryPoint` | — | — | A stream contains one or more telemetry points |
