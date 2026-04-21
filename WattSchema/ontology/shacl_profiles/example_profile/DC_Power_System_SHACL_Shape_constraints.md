# DCPM Power System SHACL Shapes

> **Namespace:** `dcpm: <https://qcells.com/schema/dcpm/#>`
> **Ontologies referenced:** Brick (`brick:`), ASHRAE 223 (`s223:`), QUDT Units (`unit:`), QUDT Schema (`qudt:`)

This document describes the SHACL node shapes defined for the Data Center Power Management (DCPM) ontology. Each shape enforces structural and telemetry constraints on power system equipment.

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

**Shape IRI:** `dcpm:SiteShape`
**Target Class:** `dcpm:SiteType`
**Description:** SHACL shape requiring each site to have proper power system components.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Datatype | Description |
|---|---|---|---|---|---|---|
| `dcpm:latitude` | Site Latitude | — | 1 | — | `xsd:float` | Site must include latitude in decimal degrees |
| `dcpm:longitude` | Site Longitude | — | 1 | — | `xsd:float` | Site must include longitude in decimal degrees |
| `dcpm:siteId` | Site Identifier | — | 1 | — | `xsd:string` | Site must have a unique identifier |
| `dcpm:hasPointOfInterconnection` | Point of Interconnection | `dcpm:PointOfInterconnection` | — | — | — | Site's grid connection point(s) |
| `dcpm:hasValueStream` | Value Stream | `dcpm:ValueStream` | — | — | — | Revenue or cost optimization pathway associated with the site |
| `dcpm:containsEquipment` | Contains Equipment | `dcpm:PowerDeviceType` | — | — | — | Power devices physically contained within the site |
| `dcpm:isLocationOf` | Is Location Of | `dcpm:PowerDeviceType` | — | — | — | Power devices located at this site |
| `rec:ownedBy` | Owned By | `rec:Organization` | 1 | 1 | — | Site must be owned by exactly one Organization |

---

## POIShape

**Shape IRI:** `dcpm:POIShape`
**Target Class:** `dcpm:PointOfInterconnection`
**Description:** SHACL shape for grid interconnection points.

| Property Path | Name | Allowed Class(es) | Description |
|---|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:UtilityMeterType` | POI feeds utility meter |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:UtilityMeterType` | POI supplies power to utility meter |
| `dcpm:hasValueStream` | Value Stream | `dcpm:ValueStream` | Value stream program associated with this POI |

---

## UtilityMeterShape

**Shape IRI:** `dcpm:UtilityMeterShape`
**Target Class:** `dcpm:UtilityMeterType`
**Description:** SHACL shape defining required telemetry points and relationships for utility meters.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Import Active Power Point | `dcpm:ImportActivePower` or `dcpm:ActivePower` | `unit:KiloW` | 1 | Utility meter must track imported active power (kW) |
| Import Active Energy Point | `dcpm:ImportActiveEnergy` or `dcpm:ActiveEnergy` | `unit:KiloW-HR` | 1 | Utility meter must track imported active energy (kWh) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:TransformerType` \| `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:ATSType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:TransformerType` \| `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:ATSType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SPDType` \| `dcpm:SwitchgearType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:PQMeterType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` \| `dcpm:SiteType` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |
| `dcpm:hasValueStream` | hasValueStream target | `dcpm:ValueStream` |

---

## TransformerShape

**Shape IRI:** `dcpm:TransformerShape`
**Target Class:** `dcpm:TransformerType`
**Description:** SHACL shape requiring transformer to have monitoring, connectivity, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Primary Side Voltage Point | `dcpm:PrimaryKV` | `unit:KiloV` | 1 | Transformer must monitor primary side voltage (kV) |
| Secondary Side Voltage Point | `dcpm:SecondaryKV` | `unit:KiloV` | 1 | Transformer must monitor secondary side voltage (kV) |
| Active Power Point | `dcpm:ActivePower` | `unit:KiloW` | 1 | Transformer must monitor active power throughput (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:ATSType` \| `dcpm:SwitchgearType` \| `dcpm:UPSType` |
| `dcpm:fedBy` | fedBy source | `dcpm:UtilityMeterType` \| `dcpm:GeneratorSetType` \| `dcpm:SwitchgearType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:ATSType` \| `dcpm:SwitchgearType` \| `dcpm:UPSType` |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:UtilityMeterType` \| `dcpm:GeneratorSetType` \| `dcpm:SwitchgearType` |
| `dcpm:primarySource` | primarySource | `dcpm:UtilityMeterType` \| `dcpm:GeneratorSetType` |
| `dcpm:backupSource` | backupSource | `dcpm:GeneratorSetType` \| `dcpm:UtilityMeterType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:SPDType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:PQMeterType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` \| `dcpm:SiteType` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |

---

## SwitchgearShape

**Shape IRI:** `dcpm:SwitchgearShape`
**Target Class:** `dcpm:SwitchgearType`
**Description:** SHACL shape requiring switchgear to have rated specifications, telemetry, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:ratedVoltage` | Rated Voltage | — | 1 | Switchgear must have a rated voltage specification |
| `dcpm:busbarRating` | Busbar Current Rating | `xsd:float` | 1 | Switchgear must specify busbar current rating in amperes |
| `dcpm:breakerCount` | Breaker Count | `xsd:integer` | — | Number of circuit breakers installed in switchgear |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Bus Active Power Point | `dcpm:ActivePower` | `unit:KiloW` | 1 | Switchgear must monitor bus active power (kW) |
| Bus Voltage Point | `dcpm:Voltage` | `unit:V` | 1 | Switchgear must monitor bus voltage (V) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:UPSType` \| `dcpm:BESSType` \| `dcpm:PDUType` \| `dcpm:TransformerType` \| `dcpm:BuswayType` \| `dcpm:MCCType` | 1 |
| `dcpm:fedBy` | fedBy source | `dcpm:ATSType` \| `dcpm:TransformerType` \| `dcpm:UtilityMeterType` \| `dcpm:BESSType` | — |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:UPSType` \| `dcpm:BESSType` \| `dcpm:PDUType` \| `dcpm:TransformerType` \| `dcpm:BuswayType` \| `dcpm:MCCType` | — |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:ATSType` \| `dcpm:TransformerType` \| `dcpm:UtilityMeterType` \| `dcpm:BESSType` | — |
| `dcpm:primarySource` | primarySource | `dcpm:ATSType` \| `dcpm:TransformerType` \| `dcpm:UtilityMeterType` | — |
| `dcpm:backupSource` | backupSource | `dcpm:GeneratorSetType` \| `dcpm:BESSType` \| `dcpm:ATSType` | — |
| `dcpm:protects` | protects target | `dcpm:UPSType` \| `dcpm:TransformerType` \| `dcpm:PDUType` \| `dcpm:BESSType` \| `dcpm:FeederType` | — |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SPDType` \| `dcpm:SwitchgearType` | — |
| `dcpm:connectedTo` | connectedTo target | `dcpm:PQMeterType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` | — |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` | — |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` | — |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` | — |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` | — |
| `dcpm:hasValueStream` | hasValueStream target | `dcpm:ValueStream` | — |

---

## GeneratorShape

**Shape IRI:** `dcpm:GeneratorShape`
**Target Class:** `dcpm:GeneratorSetType`
**Description:** SHACL shape requiring generator to have fuel monitoring, operating status, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:fuelType` | Fuel Type Metadata | `xsd:string` | 1 | Generator must specify fuel type (Diesel, Natural Gas, Propane, etc.) |
| `dcpm:ratedPower` | Rated Power | — | 1 | Generator must have rated power capacity |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Fuel Level Point | `dcpm:FuelLevel` | `unit:PERCENT` | 1 | Generator must monitor fuel level (%) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:ATSType` \| `dcpm:SwitchgearType` \| `dcpm:TransformerType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:ATSType` \| `dcpm:SwitchgearType` \| `dcpm:TransformerType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:SPDType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:GeneratorYard` \| `dcpm:GeneratorRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |

---

## ATSShape

**Shape IRI:** `dcpm:ATSShape`
**Target Class:** `dcpm:ATSType`
**Description:** SHACL shape requiring ATS to have source selection, monitoring, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:transferTimeMS` | Transfer Time (ms) | `xsd:float` | — | ATS transfer time during source changeover in milliseconds |
| `dcpm:numberOfPoles` | Number of Poles | `xsd:integer` | 1 | ATS must specify number of poles (1P, 2P, 3P, 4P) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:SwitchgearType` \| `dcpm:UPSType` \| `dcpm:TransformerType` | 1 |
| `dcpm:fedBy` | fedBy source | `dcpm:TransformerType` \| `dcpm:UtilityMeterType` \| `dcpm:GeneratorSetType` | — |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:SwitchgearType` \| `dcpm:UPSType` \| `dcpm:TransformerType` | — |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:TransformerType` \| `dcpm:UtilityMeterType` \| `dcpm:GeneratorSetType` | — |
| `dcpm:primarySource` | primarySource | `dcpm:TransformerType` \| `dcpm:UtilityMeterType` | — |
| `dcpm:backupSource` | backupSource | `dcpm:GeneratorSetType` \| `dcpm:TransformerType` | — |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:SPDType` | — |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` | — |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` | — |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` | — |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` | — |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` | — |

---

## STSShape

**Shape IRI:** `dcpm:STSShape`
**Target Class:** `dcpm:STSType`
**Description:** SHACL shape requiring STS to have advanced monitoring and control capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:transferTimeMS` | Transfer Time (ms) | `xsd:float` | 1 | STS must specify ultra-fast transfer time in milliseconds |
| `dcpm:numberOfPoles` | Number of Poles | `xsd:integer` | 1 | STS must specify number of poles |

---

## UPSShape

**Shape IRI:** `dcpm:UPSShape`
**Target Class:** `dcpm:UPSType`
**Description:** SHACL shape requiring UPS to have battery health, runtime monitoring, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| State of Charge Point | `dcpm:SoC` | `unit:PERCENT` | 1 | UPS must monitor battery state of charge (%) |
| State of Health Point | `dcpm:SoH` | `unit:PERCENT` | 1 | UPS must monitor battery state of health (%) |
| Remaining Backup Time Point | `dcpm:RemainingTime` | `unit:MIN` | 1 | UPS must provide remaining runtime estimation (min) |
| Input Active Power Point | `dcpm:ImportActivePower` | `unit:KiloW` | 1 | UPS must monitor input active power (kW) |
| Output Active Power Point | `dcpm:ExportActivePower` | `unit:KiloW` | 1 | UPS must monitor output active power (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) | Min Count |
|---|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:PDUType` \| `dcpm:BuswayType` \| `dcpm:STSType` | 1 |
| `dcpm:fedBy` | fedBy source | `dcpm:SwitchgearType` \| `dcpm:ATSType` \| `dcpm:TransformerType` | — |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:PDUType` \| `dcpm:BuswayType` \| `dcpm:STSType` | — |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:SwitchgearType` \| `dcpm:ATSType` \| `dcpm:TransformerType` | — |
| `dcpm:primarySource` | primarySource | `dcpm:SwitchgearType` \| `dcpm:ATSType` | — |
| `dcpm:backupSource` | backupSource | `dcpm:SwitchgearType` \| `dcpm:ATSType` | — |
| `dcpm:protects` | protects target | `dcpm:PDUType` \| `dcpm:BuswayType` | — |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:SPDType` | — |
| `dcpm:connectedTo` | connectedTo target | `dcpm:BMSType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` | — |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` | — |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` | — |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` | — |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` | — |

---

## BESSShape

**Shape IRI:** `dcpm:BESSShape`
**Target Class:** `dcpm:BESSType`
**Description:** SHACL shape requiring BESS to have monitoring capabilities and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:ratedStorageCapacity` | Rated Storage Capacity | — | 1 | BESS must specify rated energy storage capacity (kWh) |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| State of Charge | `dcpm:SoC` | `unit:PERCENT` | 1 | BESS must monitor state of charge (%) |
| State of Health | `dcpm:SoH` | `unit:PERCENT` | 1 | BESS should monitor state of health (%) |
| Minimum State of Charge | `dcpm:MinSOC` | `unit:PERCENT` | 1 | BESS minimum SoC limit |
| Maximum State of Charge | `dcpm:MaxSOC` | `unit:PERCENT` | 1 | BESS maximum SoC limit |
| Charge Power Setpoint | `dcpm:ChargePowerSetpoint` | `unit:KiloW` | 1 | BESS charge power setpoint (kW) |
| Discharge Power Setpoint | `dcpm:DischargePowerSetpoint` | `unit:KiloW` | 1 | BESS discharge power setpoint (kW) |
| Charge Efficiency | `dcpm:ChargeEfficiency` | `unit:UNITLESS` | 1 | BESS charge efficiency (unitless ratio, 0–1) |
| Discharge Efficiency | `dcpm:DischargeEfficiency` | `unit:UNITLESS` | 1 | BESS discharge efficiency (unitless ratio, 0–1) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds (discharge) target | `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:fedBy` | fedBy (charge) source | `dcpm:SwitchgearType` \| `dcpm:BuswayType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo (discharge) target | `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:suppliedBy` | suppliedBy (charge) source | `dcpm:SwitchgearType` \| `dcpm:BuswayType` |
| `dcpm:primarySource` | primarySource (charging source) | `dcpm:SwitchgearType` \| `dcpm:BuswayType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:SPDType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:BMSType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` \| `dcpm:BatteryRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |
| `dcpm:hasValueStream` | hasValueStream target | `dcpm:ValueStream` |

---

## BMSShape

**Shape IRI:** `dcpm:BMSShape`
**Target Class:** `dcpm:BMSType`
**Description:** SHACL shape for BMS monitoring and connection.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:connectedTo` | connectedTo target | `dcpm:BESSType` \| `dcpm:UPSType` \| `dcpm:GatewayType` \| `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:BatteryRoom` \| `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## PDUShape

**Shape IRI:** `dcpm:PDUShape`
**Target Class:** `dcpm:PDUType`
**Description:** SHACL shape requiring PDU to have power monitoring, distribution, and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:circuitCount` | Circuit Count | `xsd:integer` | 1 | PDU must specify number of electrical circuits |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Input Active Power | `dcpm:ImportActivePower` or `dcpm:ActivePower` | `unit:KiloW` | 1 | PDU must monitor input active power (kW) |
| Voltage Monitoring | `dcpm:Voltage` or `dcpm:InputVoltageLN` | `unit:V` | 1 | PDU must monitor input voltage |
| Input Current Point | `dcpm:Current` | `unit:A` | 1 | PDU must monitor input current (A) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:BuswayType` \| `dcpm:RackPDUType` \| `dcpm:ITRackType` |
| `dcpm:fedBy` | fedBy source | `dcpm:UPSType` \| `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:STSType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:BuswayType` \| `dcpm:RackPDUType` \| `dcpm:ITRackType` |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:UPSType` \| `dcpm:SwitchgearType` \| `dcpm:BuswayType` \| `dcpm:STSType` |
| `dcpm:primarySource` | primarySource | `dcpm:UPSType` \| `dcpm:SwitchgearType` |
| `dcpm:backupSource` | backupSource | `dcpm:UPSType` \| `dcpm:SwitchgearType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:UPSType` \| `dcpm:SwitchgearType` \| `dcpm:SPDType` |
| `dcpm:protects` | protects target | `dcpm:RackPDUType` \| `dcpm:ITRackType` \| `dcpm:BuswayType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` \| `dcpm:DataHall` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |

---

## RackPDUShape

**Shape IRI:** `dcpm:RackPDUShape`
**Target Class:** `dcpm:RackPDUType`
**Description:** SHACL shape requiring rack PDUs to have outlet-level power monitoring and relationships.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:outletCount` | Outlet Count | `xsd:integer` | 1 | Rack PDU must specify number of power outlets |
| `dcpm:circuitCount` | Circuit Count | `xsd:integer` | 1 | Rack PDU must specify number of circuits |

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Input Voltage Point | `dcpm:InputVoltageLN` | `unit:V` | 1 | Rack PDU must monitor input line-to-neutral voltage (V) |
| Output Power Point | `dcpm:ExportActivePower` | `unit:KiloW` | 1 | Rack PDU must monitor output active power (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:ITRackType` |
| `dcpm:fedBy` | fedBy source | `dcpm:PDUType` \| `dcpm:BuswayType` \| `dcpm:UPSType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:ITRackType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:DataHall` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## BuswayShape

**Shape IRI:** `dcpm:BuswayShape`
**Target Class:** `dcpm:BuswayType`
**Description:** SHACL shape requiring busway to have monitoring, connections, and relationships.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Power Monitoring | `dcpm:InputActivePower` | `unit:KiloW` | 1 | Busway must have power monitoring capabilities (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:PDUType` \| `dcpm:RackPDUType` \| `dcpm:RPPType` \| `dcpm:ITRackType` \| `dcpm:BESSType` |
| `dcpm:fedBy` | fedBy source | `dcpm:UPSType` \| `dcpm:PDUType` \| `dcpm:SwitchgearType` \| `dcpm:BESSType` |
| `dcpm:suppliesPowerTo` | suppliesPowerTo target | `dcpm:PDUType` \| `dcpm:RackPDUType` \| `dcpm:RPPType` \| `dcpm:ITRackType` \| `dcpm:BESSType` |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:UtilityMeterType` \| `dcpm:UPSType` \| `dcpm:SwitchgearType` \| `dcpm:BESSType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` \| `dcpm:UPSType` \| `dcpm:SPDType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:ControllerType` \| `dcpm:PQMeterType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:DataHall` \| `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |
| `dcpm:hasSOP` | hasSOP target | `dcpm:SOP` |

---

## ITRackShape

**Shape IRI:** `dcpm:ITRackShape`
**Target Class:** `dcpm:ITRackType`
**Description:** Terminal load — consumes power only.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Active Power | `dcpm:ActivePower` | `unit:KiloW` | 1 | IT Rack power consumption (kW) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:fedBy` | fedBy source | `dcpm:RackPDUType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:suppliedBy` | suppliedBy source | `dcpm:RackPDUType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:primarySource` | primarySource | `dcpm:RackPDUType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:backupSource` | backupSource | `dcpm:RackPDUType` \| `dcpm:BuswayType` \| `dcpm:PDUType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:DataHall` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## FeederShape

**Shape IRI:** `dcpm:FeederShape`
**Target Class:** `dcpm:FeederType`
**Description:** Individual feeder circuit within a switchgear.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:fedBy` | fedBy source | `dcpm:SwitchgearType` |
| `dcpm:feeds` | feeds target | `dcpm:TransformerType` \| `dcpm:UPSType` \| `dcpm:PDUType` \| `dcpm:MCCType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:SwitchgearType` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## MCCShape

**Shape IRI:** `dcpm:MCCShape`
**Target Class:** `dcpm:MCCType`
**Description:** SHACL shape for motor control centers.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:feeds` | feeds target | `dcpm:MotorFeederType` |
| `dcpm:fedBy` | fedBy source | `dcpm:SwitchgearType` \| `dcpm:TransformerType` \| `dcpm:PDUType` |
| `dcpm:protects` | protects target | `dcpm:MotorFeederType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## MotorFeeder Shape

**Shape IRI:** `dcpm:MotorFeederShape`
**Target Class:** `dcpm:MotorFeederType`
**Description:** Individual motor starter/feeder within an MCC.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:fedBy` | fedBy source | `dcpm:MCCType` |
| `dcpm:protectedBy` | protectedBy source | `dcpm:MCCType` |
| `dcpm:controlledBy` | controlledBy source | `dcpm:ControllerType` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## SPDShape

**Shape IRI:** `dcpm:SPDShape`
**Target Class:** `dcpm:SPDType`
**Description:** SHACL shape for surge protection devices.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:protects` | protects target | `dcpm:SwitchgearType` \| `dcpm:TransformerType` \| `dcpm:PDUType` \| `dcpm:UPSType` \| `dcpm:BuswayType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## GroundingNetworkShape

**Shape IRI:** `dcpm:GroundingNetworkShape`
**Target Class:** `dcpm:GroundingNetworkType`
**Description:** SHACL shape for grounding and bonding network.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:protects` | protects target | `dcpm:PowerDeviceType` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## PQMeterShape

**Shape IRI:** `dcpm:PQMeterShape`
**Target Class:** `dcpm:PQMeterType`
**Description:** SHACL shape requiring power quality meters to have comprehensive monitoring.

### Telemetry Constraints

| Name | Point Class | Unit | Min Count | Description |
|---|---|---|---|---|
| Total Harmonic Distortion Voltage | `dcpm:THDV` | `unit:PERCENT` | 1 | PQ Meter must measure voltage THD (%) |
| Total Harmonic Distortion Current | `dcpm:THDI` | `unit:PERCENT` | 1 | PQ Meter must measure current THD (%) |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:connectedTo` | connectedTo target | `dcpm:PowerDeviceType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## ControllerShape

**Shape IRI:** `dcpm:ControllerShape`
**Target Class:** `dcpm:ControllerType`
**Description:** SHACL shape requiring controllers to have monitoring, control, and connection capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:communicationProtocol` | Communication Protocol | `xsd:string` | 1 | Controller must support a communication protocol (Modbus TCP, BACnet, OPC UA, etc.) |
| `dcpm:ipAddress` | IP Address | `xsd:string` | 1 | Controller must have a network address |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:controls` | controls target | `dcpm:PowerDeviceType` |
| `dcpm:connectedTo` | connectedTo target | `dcpm:GatewayType` \| `dcpm:PowerDeviceType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## GatewayShape

**Shape IRI:** `dcpm:GatewayShape`
**Target Class:** `dcpm:GatewayType`
**Description:** SHACL shape requiring gateways to have communication and aggregation capabilities.

### Data Property Constraints

| Property Path | Name | Datatype | Min Count | Description |
|---|---|---|---|---|
| `dcpm:communicationProtocol` | Communication Protocol | `xsd:string` | 1 | Gateway must support communication protocols |
| `dcpm:ipAddress` | IP Address | `xsd:string` | 1 | Gateway must have a network address |

### Relationship Constraints

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:connectedTo` | connectedTo target | `dcpm:ControllerType` \| `dcpm:PowerDeviceType` |
| `dcpm:hasLocation` | hasLocation target | `dcpm:ElectricalRoom` |
| `dcpm:hasDocument` | hasDocument target | `dcpm:Document` |

---

## ElectricalRoomShape

**Shape IRI:** `dcpm:ElectricalRoomShape`
**Target Class:** `dcpm:ElectricalRoom`
**Description:** Physical space containing electrical infrastructure.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:containsEquipment` | containsEquipment target | `dcpm:SwitchgearType` \| `dcpm:TransformerType` \| `dcpm:UPSType` \| `dcpm:PDUType` \| `dcpm:ATSType` \| `dcpm:ControllerType` \| `dcpm:GatewayType` \| `dcpm:PQMeterType` \| `dcpm:SPDType` |
| `dcpm:isLocationOf` | isLocationOf target | `dcpm:PowerDeviceType` |

---

## DataHallShape

**Shape IRI:** `dcpm:DataHallShape`
**Target Class:** `dcpm:DataHall`
**Description:** Physical space containing IT equipment and last-mile power distribution.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:containsEquipment` | containsEquipment target | `dcpm:ITRackType` \| `dcpm:RackPDUType` \| `dcpm:BuswayType` \| `dcpm:PDUType` \| `dcpm:RPPType` |
| `dcpm:isLocationOf` | isLocationOf target | `dcpm:PowerDeviceType` |

---

## BatteryRoomShape

**Shape IRI:** `dcpm:BatteryRoomShape`
**Target Class:** `dcpm:BatteryRoom`
**Description:** Physical space housing battery storage systems.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:containsEquipment` | containsEquipment target | `dcpm:BESSType` \| `dcpm:BMSType` |
| `dcpm:isLocationOf` | isLocationOf target | `dcpm:PowerDeviceType` |

---

## GeneratorYardShape

**Shape IRI:** `dcpm:GeneratorYardShape`
**Target Class:** `dcpm:GeneratorYard`
**Description:** Outdoor area hosting generator sets.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:containsEquipment` | containsEquipment target | `dcpm:GeneratorSetType` |

---

## GeneratorRoomShape

**Shape IRI:** `dcpm:GeneratorRoomShape`
**Target Class:** `dcpm:GeneratorRoom`
**Description:** Indoor room housing generator sets.

| Property Path | Name | Allowed Class(es) |
|---|---|---|
| `dcpm:containsEquipment` | containsEquipment target | `dcpm:GeneratorSetType` |

---

## TelemetryPointShape

**Shape IRI:** `dcpm:TelemetryPointShape`
**Target Class:** `dcpm:TelemetryPoint`
**Description:** A single measured or setpoint value associated with a power device or telemetry stream.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Description |
|---|---|---|---|---|---|
| `dcpm:isTelemetryOf` | isTelemetryOf target | `dcpm:PowerDeviceType` \| `dcpm:TelemetryStream` | — | — | Associates the point with its owning device or stream |
| `dcpm:hasPhase` | hasPhase target | `dcpm:Phase` | — | 1 | A telemetry point is associated with at most one electrical phase |

---

## TelemetryStreamShape

**Shape IRI:** `dcpm:TelemetryStreamShape`
**Target Class:** `dcpm:TelemetryStream`
**Description:** A named collection of telemetry points belonging to exactly one power device.

| Property Path | Name | Allowed Class(es) | Min Count | Max Count | Description |
|---|---|---|---|---|---|
| `dcpm:isTelemetryStreamOf` | isTelemetryStreamOf target | `dcpm:PowerDeviceType` | 1 | 1 | A telemetry stream belongs to exactly one power device |
| `dcpm:hasTelemetryPoint` | hasTelemetryPoint target | `dcpm:TelemetryPoint` | — | — | A stream contains one or more telemetry points |
