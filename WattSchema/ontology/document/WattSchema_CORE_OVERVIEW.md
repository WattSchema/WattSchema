# Watt Schema- Core Ontology Requirements

This document provides a comprehensive reference for all foundational classes, properties, and relationships defined in the **Watt Schema Core Ontology* v1.0**. This Core document serves as the semantic foundation for **Power Path Definition**, **Physical Infrastructure Modeling**, **Telemetry & Measurement Framework**, **Device Metadata & Control**, and **Commercial Value Stream Alignment** necessary for comprehensive site-level power management and digital twin synchronization.

**Scope of this document:** This document covers all baseline entities defined in the core ontology including:
- Spatial and facility hierarchy containers (6 types)
- 21+ power equipment device types (generators, UPS, BESS, switchgear, distribution, monitoring, control)
- 40+ measurement and telemetry point types (power, energy, voltage, current, battery metrics, harmonics)
- Device metadata and operational parameters (manufacturer, model, ratings, configuration)
- Telemetry stream and point models with phase context
- Control setpoints and performance indicators (KPI)
- Relationships between equipment and power flow (21+ relationship types)
- Documentation, SOP, MOP, and operational procedure linkages
- Value stream and grid interconnection boundary definitions
- Enumerated state, mode, and alarm types (13 enumerations)

The ontology aligns with **Brick Schema**, **ASHRAE 223**, and **OPC UA Device Integration (DI)** standards for interoperability.

---

## Contents
- [1. Site and Spatial Hierarchy](#1-site-and-spatial-hierarchy)
- [2. Power Equipment Classes](#2-power-equipment-classes)
- [3. Measurement and Telemetry Classes](#3-measurement-and-telemetry-classes)
- [4. Telemetry Infrastructure](#4-telemetry-infrastructure)
- [5. Device Metadata and Parameters](#5-device-metadata-and-parameters)
- [6. Control Systems and Setpoints](#6-control-systems-and-setpoints)
- [7. Object Properties and Relationships](#7-object-properties-and-relationships)
- [8. Point of Interconnection (POI)](#8-point-of-interconnection-poi)
- [9. Value Stream Entities](#9-value-stream-entities)
- [10. Documentation and Metadata](#10-documentation-and-metadata)
- [11. Enumerated Types](#11-enumerated-types)

---

<a id="1-site-and-spatial-hierarchy"></a>
## 1. Site and Spatial Hierarchy

Foundational containers for physical assets and environmental modeling.

### Entity Classes
- **`wattsch:SiteType`**: Top-level container for a physical site or data center (subclass of `s223:PhysicalSpace`).
  - Properties: `siteId`, `latitude`, `longitude`
- **`wattsch:ElectricalRoom`**: Zone for electrical distribution (equivalent to `brick:Electrical_Room`).
- **`wattsch:DataHall`**: Physical space dedicated to IT infrastructure.
- **`wattsch:BatteryRoom`**: Zone for energy storage systems (equivalent to `brick:Battery_Room`).
- **`wattsch:GeneratorYard`**: Exterior area for power generation units (subclass of `brick:Outdoor_Area`).
- **`wattsch:GeneratorRoom`**: Interior zone for generator equipment (subclass of `brick:Electrical_Room`).
- **`wattsch:Rack`**: Individual equipment rack within data hall or electrical room.

---

<a id="2-power-equipment-classes"></a>
## 2. Power Equipment Classes

All power equipment inherits from `wattsch:PowerDeviceType` (subclass of `di:DeviceType`), enabling OPC UA Device Integration compliance.

### 2.1. Utility Interface & Switching
- **`wattsch:SwitchgearType`**: Main site switchgear receiving utility power and distributing to loads.
- **`wattsch:FeederType`**: Individual feeder circuit within switchgear or panelboard.
- **`wattsch:UtilityMeterType`**: Revenue-grade meter tracking import/export energy (subclass of `brick:Electrical_Meter`).

### 2.2. Distribution & Power Conditioning
- **`wattsch:TransformerType`**: Power transformers for voltage conversion (subclass of `s223:ElectricEnergyTransformer`).
- **`wattsch:PDUType`**: Floor-level/mains Power Distribution Unit (base class for PDU variants).
- **`wattsch:RPPType`**: Remote Power Panel (specialized PDU, closer to load).
- **`wattsch:RackPDUType`**: Rack-mounted PDU with outlet-level monitoring and control.
- **`wattsch:BuswayType`**: Busway power distribution system.

### 2.3. Power Transformation (UPS/BESS)
- **`wattsch:UPSType`**: Uninterruptible Power Supply (subclass of `brick:Uninterruptible_Power_Supply`).
- **`wattsch:BESSType`**: Battery Energy Storage System including Power Conversion System (PCS) (subclass of `brick:Battery_Energy_Storage_System`).
- **`wattsch:BMSType`**: Standalone Battery Management System.

### 2.4. Transfer Switches
- **`wattsch:ATSType`**: Automatic Transfer Switch for source switching (subclass of `brick:Automatic_Transfer_Switch`).
- **`wattsch:STSType`**: Static Transfer Switch for zero-transfer-time switching (subclass of `brick:Static_Transfer_Switch`).

### 2.5. Generation
- **`wattsch:GeneratorSetType`**: Diesel/Gas generator set for backup power (equivalent to `brick:Generator`).

### 2.6. Motor & Load Control
- **`wattsch:MCCType`**: Motor Control Center for managing motor feeders (equivalent to `brick:Motor_Control_Center`).
- **`wattsch:MotorFeederType`**: Individual motor starter/feeder within MCC.

### 2.7. Power Quality & Protection
- **`wattsch:PQMeterType`**: Dedicated power quality monitoring device (subclass of `brick:Meter`).
- **`wattsch:SPDType`**: Surge Protective Device for transient protection.
- **`wattsch:GroundingNetworkType`**: Monitoring points of facility grounding system.

### 2.8. Control & Communication
- **`wattsch:GatewayType`**: Gateway or SCADA system (equivalent to `brick:Gateway`).
- **`wattsch:ControllerType`**: Site controller or Programmable Logic Controller (equivalent to `brick:Controller`).

### 2.9. Common Static Parameters (All PowerDeviceType)
- **`wattsch:manufacturer` / `wattsch:model`**: Device manufacturer and model name.
- **`wattsch:serialNumber`**: Unique manufacturer-assigned ID.
- **`wattsch:softwareRevision` / `wattsch:firmwareVersion`**: Software/firmware version.
- **`wattsch:ipAddress`**: Network address (IPv4/IPv6).
- **`wattsch:communicationProtocol`**: Protocol support (e.g., Modbus TCP, BACnet, SNMP).
- **`wattsch:coolingType`**: Cooling method (air, liquid, etc.).
- **`wattsch:temperatureSensorInstalled`**: Boolean indicating temperature sensor presence.
- **Rated Parameters**: `ratedPower`, `ratedVoltage`, `ratedCurrent`, `ratedStorageCapacity`

---

<a id="3-measurement-and-telemetry-classes"></a>
## 3. Measurement and Telemetry Classes

Detailed classification of measured data points using QUDT units and quantity kinds.

### 3.1. Electrical Power & Energy
- **`wattsch:ActivePower`**: Real power in kW or MW.
- **`wattsch:ActiveEnergy`**: Total active energy; sub-types include `ImportActiveEnergy` and `ExportActiveEnergy` (kWh).
- **`wattsch:ImportActivePower` / `wattsch:ExportActivePower`**: POI or meter-facing active power import/export.
- **`wattsch:ImportActivePowerL1/L2/L3` / `wattsch:ExportActivePowerL1/L2/L3`**: Per-phase import/export active power.
- **`wattsch:BypassActivePower`**: Active power flowing through bypass path (typically UPS bypass for load switching).
- **`wattsch:ApparentPower`**: Total apparent power in kVA.
- **`wattsch:InputApparentPower` / `wattsch:OutputApparentPower`**: Device-terminal apparent power.
- **`wattsch:InputApparentPowerL1/L2/L3` / `wattsch:OutputApparentPowerL1/L2/L3`**: Per-phase apparent power.
- **`wattsch:ReactivePower`**: Imaginary power in kVAR.
- **`wattsch:PowerFactor`**: Ratio of active to apparent power (dimensionless).

### 3.2. Voltage, Current & Frequency
- **`wattsch:Voltage`**: AC line voltage; sub-types: `VoltageLL` (Line-to-Line) and `VoltageLN` (Line-to-Neutral) in Volts.
- **`wattsch:InputVoltageL1L2/L2L3/L3L1`**: Line-to-line input voltages.
- **`wattsch:OutputVoltageL1L2/L2L3/L3L1`**: Line-to-line output voltages.
- **`wattsch:InputVoltageL1N/L2N/L3N`**: Line-to-neutral input voltages.
- **`wattsch:OutputVoltageL1N/L2N/L3N`**: Line-to-neutral output voltages.
- **`wattsch:PrimaryKV` / `wattsch:SecondaryKV`**: Primary/Secondary transformer voltage in kV.
- **`wattsch:Current`**: AC electric current in Amperes.
- **`wattsch:InputCurrent` / `wattsch:OutputCurrent`**: Device-terminal current direction.
- **`wattsch:InputCurrentL1/L2/L3` / `wattsch:OutputCurrentL1/L2/L3`**: Per-phase input/output current.
- **`wattsch:DCCurrent`**: DC electric current in Amperes.
- **`wattsch:DCVoltage`**: DC voltage in Volts.
- **`wattsch:Frequency`**: System frequency in Hz.
- **`wattsch:PercentZ`**: Transformer impedance expressed as percentage.

### 3.3. Power Quality & Harmonics
- **`wattsch:THDI`**: Total Harmonic Distortion of Current (%).
- **`wattsch:THDV`**: Total Harmonic Distortion of Voltage (%).
- **`wattsch:HarmonicsI`** / **`wattsch:HarmonicsV`**: Individual harmonic components [1..n].

### 3.4. Battery & Energy Storage
- **`wattsch:SoC`**: State of Charge (%).
- **`wattsch:SoH`**: State of Health (%).
- **`wattsch:MinSOC` / `wattsch:MaxSOC`**: Minimum/maximum allowable SOC thresholds (%).
- **`wattsch:EnergyAvailable`**: Currently dischargeable energy in kWh.
- **`wattsch:ChargeEfficiency` / `wattsch:DischargeEfficiency`**: Operational efficiency ratios (dimensionless).

### 3.5. Temperature & Environmental
- **`wattsch:Temperature`**: Ambient temperature in °C.
- **`wattsch:CellTemperature`**: Battery cell temperature in °C.
- **`wattsch:EngineCoolantTemperature`**: Generator engine coolant temperature in °C.
- **`wattsch:Humidity`**: Relative humidity in %RH.

### 3.6. Control Setpoints
- **`wattsch:ActivePowerSetpoint`**: Target active power value (kW/MW).
- **`wattsch:ChargePowerSetpoint`**: Commanded battery charge rate (kW).
- **`wattsch:DischargePowerSetpoint`**: Commanded battery discharge rate (kW).

### 3.7. Generator-Specific Metrics
- **`wattsch:EngineRPM`**: Engine rotational speed (rev/min).
- **`wattsch:EngineOilPressure`**: Engine lubrication oil pressure (PSI).
- **`wattsch:FuelLevel`**: Fuel tank level (%).
- **`wattsch:LoadingPercentage`**: Current load as % of rated capacity.

### 3.8. Equipment-Specific Metrics
- **`wattsch:RemainingTime`**: Battery or UPS runtime remaining (minutes).
- **`wattsch:ATSTransferCount`**: Number of transfer events recorded.

---

<a id="4-telemetry-infrastructure"></a>
## 4. Telemetry Infrastructure

Structural framework for organizing measurement points and the data they produce.

### Entity Classes
- **`wattsch:TelemetryPoint`**: Represents a single measured data point (e.g., voltage, current, frequency).
  - Property: `wattsch:pointName` — hierarchical identifier following naming convention
  - Relationship: `wattsch:hasPhase` — links to electrical phase context (L1, L2, L3, LN, LL)
  
- **`wattsch:TelemetryStream`**: Logical grouping of related telemetry points for a device.
  - Examples: Input stream (utility power), Output stream (delivered to loads), Battery stream (energy storage)
  - Relationship: `wattsch:isTelemetryStreamOf` — links to parent PowerDeviceType
  - Relationship: `wattsch:hasTelemetryPoint` — contains measurement points

### Phase Context Classes
- **`wattsch:Phase`**: Base class representing electrical phase context
- **`wattsch:Phase_L1` / `wattsch:Phase_L2` / `wattsch:Phase_L3`**: Three-phase AC contexts
- **`wattsch:Phase_LN`**: Line-to-Neutral phase
- **`wattsch:Phase_LL`**: Line-to-Line phase

### Metric Type Container Classes
- **`wattsch:ElectricalMeasurementsType`**: Container for electrical telemetry
- **`wattsch:BatteryMetricsType`**: Container for battery-level metrics
- **`wattsch:BatteryStringMetricsType`**: Container for individual battery string metrics
- **`wattsch:CellMetricsType`**: Container for individual cell-level metrics

---

<a id="5-device-metadata-and-parameters"></a>
## 5. Device Metadata and Parameters

Static properties and identifiers for all power devices.

### Device Identification
- **`wattsch:assetId`**: Unique asset identifier (per facility standards).
- **`wattsch:serialNumber`** (OPC UA equivalent: `di:SerialNumber`)
- **`wattsch:manufacturer`** (OPC UA equivalent: `di:Manufacturer`)
- **`wattsch:model`** (OPC UA equivalent: `di:Model`)

### Firmware & Software
- **`wattsch:softwareRevision`** (OPC UA equivalent: `di:SoftwareRevision`)
- **`wattsch:firmwareVersion`** (specialization of software revision)

### Network & Communication
- **`wattsch:ipAddress`** (subproperty of `di:NetworkAddress`)
- **`wattsch:communicationProtocol`**: Supported protocol(s) (Modbus, BACnet, SNMP, OPC UA, etc.)

### Equipment Configuration
- **`wattsch:batteryType`**: Battery chemistry (VRLA, Li-ion, NiCd, LiFePO4, etc.)
- **`wattsch:batteryStringCount`**: Number of battery strings in system
- **`wattsch:numberOfPoles`** (for ATS/STS): Switch pole configuration
- **`wattsch:transferType`** (for ATS): Open Transition vs. Closed Transition
- **`wattsch:busbarRating`** (for Switchgear): Current rating in Amperes
- **`wattsch:breakerType`**: Circuit breaker model/series
- **`wattsch:breakerCount`**: Number of breakers installed
- **`wattsch:impedancePercent`** (for Transformer): Impedance %
- **`wattsch:coolingType`**: Cooling method (air, liquid, forced air, etc.)
- **`wattsch:temperatureSensorInstalled`**: Boolean flag
- **`wattsch:circuitCount`** (for PDU): Circuit count
- **`wattsch:buswayConnection`** (for PDU): Boolean busway attachment
- **`wattsch:outletCount`** (for Rack PDU): Number of outlets
- **`wattsch:fuelType`** (for Generator): Diesel, Natural Gas, Propane, etc.
- **`wattsch:fuelTankCapacity`** (for Generator): Capacity in liters or gallons

### Transfer Switch Parameters
- **`wattsch:transferTimeMS`** (for ATS/STS): Transfer time in milliseconds
- **`wattsch:preferredSource`**: Preferred input source (Utility, Generator, UPS) per `wattsch:SourceEnum`

### Location & Hierarchy
- **`wattsch:locationId`**: Unique identifier for physical location (room, zone, etc.)

### Measurements & Derived Values
- **`wattsch:hasValue`**: Numeric value associated with measurement
- **`wattsch:formula`**: Calculation formula for derived measurements
- **`wattsch:calculationRate`**: Frequency/rate of calculation

---

<a id="6-control-systems-and-setpoints"></a>
## 6. Control Systems and Setpoints

Controllable parameters and performance indicators.

### Control Setpoints
Setpoints are target values for equipment control, referenced via `wattsch:ActivePowerSetpoint` and battery-specific variants:
- **`wattsch:ChargePowerSetpoint`**: Target charge rate for BESS
- **`wattsch:DischargePowerSetpoint`**: Target discharge rate for BESS
- **`wattsch:ActivePowerSetpoint`**: General power target for switchable/controllable devices

### Key Performance Indicators (KPI)
- **`wattsch:KPI`**: Class for monitoring device or system performance.
  - Examples: Uptime %, Energy efficiency, Demand response performance, Cost savings

---

<a id="7-object-properties-and-relationships"></a>
## 7. Object Properties and Relationships

Relationships defining power flows, control hierarchies, and data linkages.

### Power Flow Relationships
- **`wattsch:feeds`**: PowerDevice → PowerDevice (downstream power flow)
- **`wattsch:fedBy`**: PowerDevice → PowerDevice (upstream power supply relationship)
- **`wattsch:suppliesPowerTo`**: Source (POI/BESS/Generator) → Equipment (direct supply)
- **`wattsch:suppliedBy`**: Equipment → Source (inverse of suppliesPowerTo)

### Physical Placement
- **`wattsch:hasLocation`**: Equipment → PhysicalSpace (placement within site hierarchy)
- **`wattsch:isLocationOf`**: Inverse of hasLocation
- **`wattsch:containsEquipment`**: PhysicalSpace → Equipment (spatial containment)

### Telemetry & Measurement
- **`wattsch:hasTelemetryStream`**: PowerDevice → TelemetryStream
- **`wattsch:isTelemetryStreamOf`**: TelemetryStream → PowerDevice (inverse)
- **`wattsch:hasTelemetryPoint`**: PowerDevice/TelemetryStream → TelemetryPoint
- **`wattsch:isTelemetryOf`**: TelemetryPoint → PowerDevice (inverse)
- **`wattsch:hasPhase`**: TelemetryPoint → Phase (phase context)

### Control & Protection
- **`wattsch:controls`**: ControllerType → PowerDevice (control relationship)
- **`wattsch:controlledBy`**: PowerDevice → ControllerType (inverse)
- **`wattsch:protects`**: SPD/Breaker → Equipment (protection relationship)
- **`wattsch:protectedBy`**: Equipment → SPD/Breaker (inverse)

### Electrical Connections
- **`wattsch:connectedTo`**: Device → Device (bidirectional connection)
- **`wattsch:connectedFrom`**: Device → Device (directional incoming connection)

### Documentation & Operations
- **`wattsch:hasSOP`**: Equipment → SOP (links Standard Operating Procedures)
- **`wattsch:hasDocument`**: Equipment → Document (links manuals, diagrams, specs)

### Value Stream & Grid Integration
- **`wattsch:hasPointOfInterconnection`**: Site → PointOfInterconnection
- **`wattsch:hasValueStream`**: Site/Equipment/POI → ValueStream
- **`wattsch:hasElectrical`**: Unspecified electrical measurement association

---

<a id="8-point-of-interconnection-poi"></a>
## 8. Point of Interconnection (POI)

### Entity Class
- **`wattsch:PointOfInterconnection`**: The electrical boundary between utility grid and site.
  - **Comment**: Defines meter points for settlement, demand tracking, program eligibility, or optimization measurement boundaries.

### POI Properties
- **`wattsch:POIId`**: Unique identifier for the grid connection point.
- **`wattsch:importLimitMax`**: Maximum power import allowed by contract (kW/MW).
- **`wattsch:exportLimitMax`**: Maximum power export allowed to the grid (kW/MW).

---

<a id="9-value-stream-entities"></a>
## 9. Value Stream Entities

### Entity Class
- **`wattsch:ValueStream`**: Revenue or cost optimization pathway.
  - **Comment**: Represents programs such as energy arbitrage, demand response, tariff-based optimization, or subsidy programs. May be associated with POI, Site, or specific Equipment depending on measurement boundary.

### Properties
- **`wattsch:ValueStreamId`**: Unique identifier for the value stream.
- **`wattsch:ValueStreamProgram`**: Enumerated program type per `wattsch:ValueStreamProgramEnum`:
  - `Tariff Based Energy Arbitrage`
  - `Tariff Based Demand Charge Management`
  - `MA Clean Peak`
  - `SGIP` (Self-Generation Incentive Program)
  - `ITC` (Investment Tax Credit)
  - Other utility or regulatory programs
- **`wattsch:tariffReference`**: Link to applicable utility rate schedule or contract.

---

<a id="10-documentation-and-metadata"></a>
## 10. Documentation and Metadata

Supporting classes for device documentation, maintenance, and operational reference.

### Documentation Types
- **`wattsch:Document`**: Base class for any associated documentation
- **`wattsch:UserManual`**: End-user operational guide
- **`wattsch:InstallationGuide`**: Installation and commissioning procedures
- **`wattsch:TechnicalSpecifications`**: Detailed equipment specifications
- **`wattsch:WiringDiagram`**: Electrical schematic and wiring layouts
- **`wattsch:CommunicationProtocolDoc`**: Protocol documentation
  - **`wattsch:ModbusMap`**: Modbus register map
  - **`wattsch:BACnetObjects`**: BACnet object definitions
  - **`wattsch:OPCUAModel`**: OPC UA address space model
- **`wattsch:MaintenanceSchedule`**: Planned maintenance intervals
- **`wattsch:MaintenanceHistory`**: Historical maintenance records
- **`wattsch:FirmwarePackage`**: Firmware update releases and patches

### Operational Procedures
- **`wattsch:SOP`**: Standard Operating Procedures for critical equipment operations
- **`wattsch:MOP`**: Method of Procedure for maintenance and troubleshooting tasks

### Document Properties
- **`wattsch:documentUrl`**: URL or URI to document location
- **`wattsch:documentFileName`**: File name or identifier
- **`wattsch:documentVersion`**: Version number or release date

---

<a id="11-enumerated-types"></a>
## 11. Enumerated Types

Predefined value sets for device states, modes, and configuration options.

### Device & Component States
- **`wattsch:BreakerStateEnum`**: Unknown | Open | Closed | Tripped | Intermediate
- **`wattsch:DeviceStateEnum`**: Unknown | Stopped | Standby | Running | Faulted | Maintenance
- **`wattsch:MotorFeederStarterStateEnum`**: Off | Run | Trip
- **`wattsch:BreakerTripCauseEnum`**: None | Overload | ShortCircuit | GroundFault | Undervoltage | Overvoltage | Manual | Other

### Operating Modes
- **`wattsch:UPSModeEnum`**: Online | OnBattery | Eco | Bypass | Standby | Fault
- **`wattsch:ATSModeEnum`**: Auto | Manual | Test | LockedOut
- **`wattsch:GenModeEnum`**: Ready | Starting | Running | Testing | Cooldown | Stopped | Fault
- **`wattsch:SourceEnum`**: Utility | Generator | UPS | BESS | Bypass

### Equipment Properties
- **`wattsch:BatteryChemistryEnum`**: LFP (LiFePO4) | NMC | NCA | LeadAcid | Other
- **`wattsch:ThyristorHealthEnum`**: Good | Fair | Poor (for STS/electronic switches)

### Alarm & Health Status
- **`wattsch:UPSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical
- **`wattsch:GenAlarmStatusEnum`**: Normal | Warning | Alarm | Critical | Shutdown
- **`wattsch:BESSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical | Fault
- **`wattsch:ATSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical

### Value Stream Programs
- **`wattsch:ValueStreamProgramTypeEnum`**: Tariff Based Energy Arbitrage | Tariff Based Demand Charge Management | MA Clean Peak | SGIP | ITC

---

## Comprehensive Entity Counts & Quick Reference

| Category | Count | Key Classes |
| :--- | ---: | :--- |
| **Spatial/Facility** | 7 | SiteType, ElectricalRoom, DataHall, BatteryRoom, GeneratorYard, GeneratorRoom, Rack |
| **Power Equipment Types** | 21+ | Switchgear, Transformer, UPS, BESS, ATS, STS, Generator, PDU, Rack PDU, MCC, PQMeter, SPD, Gateway, Controller, etc. |
| **Measurement/Telemetry** | 40+ | ActivePower, ActiveEnergy, Voltage, Current, Frequency, Temperature, SoC, SoH, Harmonics, PowerFactor, etc. |
| **Telemetry Infrastructure** | 4 | TelemetryPoint, TelemetryStream, Phase (5 variants), Metric containers |
| **Structural Classes** | 9 | PointOfInterconnection, ValueStream, SOP, MOP, Document, KPI, various metric types |
| **Object Relationships** | 21+ | feeds, fedBy, suppliesPowerTo, suppliedBy, hasLocation, isLocationOf, hasTelemetryPoint, controls, protects, hasDocument, hasValueStream, etc. |
| **Enumerated Types** | 16 | BreakerStateEnum, DeviceStateEnum, UPSModeEnum, GenModeEnum, ATSModeEnum, SourceEnum, BatteryChemistryEnum, ThyristorHealthEnum, MotorFeederStarterStateEnum, UPSAlarmStatusEnum, GenAlarmStatusEnum, BESSAlarmStatusEnum, ATSAlarmStatusEnum, ATSSourceSelectedEnum, BreakerTripCauseEnum, ValueStreamProgramTypeEnum |
| **Document Types** | 11 | UserManual, InstallationGuide, TechnicalSpecifications, WiringDiagram, ModbusMap, BACnetObjects, MaintenanceSchedule, FirmwarePackage, etc. |

---

## Core Power Flow & Hierarchy Example

```
Site (SiteType)
├── Electrical Room (ElectricalRoom)
│   ├── Switchgear (SwitchgearType)
│   │   └── Feeds → Transformer
│   ├── Transformer (TransformerType)
│   │   └── Feeds → ATS
│   ├── ATS (ATSType) ← preferred source = Utility
│   │   ├── Supply Source 1: Utility via Switchgear
│   │   └── Supply Source 2: Generator via GeneratorRoom
│   └── UtilityMeter (UtilityMeterType) ← tracks import/export at POI
│
├── Data Hall (DataHall)
│   ├── Rack (Rack) [Contains]
│   │   └── RackPDU (RackPDUType)
│   │       └── Feeds → IT Equipment
│   └── PDU (PDUType)
│       └── Feeds → RackPDU
│
├── Battery Room (BatteryRoom)
│   └── BESS (BESSType)
│       ├── Controlled by: Controller → setpoints
│       ├── Telemetry Streams:
│       │   ├── Battery Metrics (SoC, SoH, Efficiency)
│       │   ├── Cell Metrics (Temp, Voltage)
│       │   └── Electrical (Current, Voltage)
│       └── Protects: Downstream (via ATS)
│
└── Generator Yard (GeneratorYard) / Generator Room
    └── GeneratorSet (GeneratorSetType)
        ├── Telemetry: RPM, Fuel Level, Oil Pressure, Load %
        └── Feeds → ATS (alternate source)

POI (PointOfInterconnection) [Site boundary]
├── Import Limit: 1000 kW
├── Export Limit: 500 kW (if grid-connected)
└── Associated ValueStream: Tariff-based Energy Arbitrage
```

---

## Core Relationships Summary Table

| Property | Subject | Object | Direction | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Power Flow**,   (**FIXME - feed vs. supply need review**) | | | | |
| `wattsch:feeds` | PowerDevice | PowerDevice | → | Downstream power delivery |
| `wattsch:fedBy` | PowerDevice | PowerDevice | ← | Upstream power source |
| `wattsch:suppliesPowerTo` | Source (POI/BESS/Gen) | Equipment | → | Direct supply relationship |
| `wattsch:suppliedBy` | Equipment | Source | ← | Supplied by relationship |
| **Physical Hierarchy** | | | | |
| `wattsch:hasLocation` | Equipment | PhysicalSpace | → | Equipment placement |
| `wattsch:isLocationOf` | PhysicalSpace | Equipment | ← | Located in space |
| `wattsch:containsEquipment` | PhysicalSpace | Equipment | → | Space contains device |
| **Telemetry & Measurement** | | | | |
| `wattsch:hasTelemetryStream` | PowerDevice | TelemetryStream | → | Device has measurement stream |
| `wattsch:isTelemetryStreamOf` | TelemetryStream | PowerDevice | ← | Stream belongs to device |
| `wattsch:hasTelemetryPoint` | Device/Stream | TelemetryPoint | → | Stream/device has point |
| `wattsch:isTelemetryOf` | TelemetryPoint | PowerDevice | ← | Point measures device |
| `wattsch:hasPhase` | TelemetryPoint | Phase | → | Point measured on phase |
| `wattsch:hasElectrical` | — | — | — | (Unspecified electrical link) |
| **Control & Protection** | | | | |
| `wattsch:controls` | ControllerType | PowerDevice | → | Device controls equipment |
| `wattsch:controlledBy` | PowerDevice | ControllerType | ← | Equipment is controlled by |
| `wattsch:protects` | SPD/Breaker | Equipment | → | Device protects downstream |
| `wattsch:protectedBy` | Equipment | SPD/Breaker | ← | Equipment protected by |
| **Electrical Connections** | | | | |
| `wattsch:connectedTo` | PowerDevice | PowerDevice | ↔ | Bidirectional connection |
| `wattsch:connectedFrom` | PowerDevice | PowerDevice | ← | Connected from upstream |
| **Documentation & Operations** | | | | |
| `wattsch:hasSOP` | Equipment | SOP | → | Links Standard Operating Procedures |
| `wattsch:hasDocument` | Equipment | Document | → | Links manual, schematic, spec |
| **Commercial & Grid Integration** | | | | |
| `wattsch:hasPointOfInterconnection` | Site | PointOfInterconnection | → | Site has utility connection boundary |
| `wattsch:hasValueStream` | Site/Equipment/POI | ValueStream | → | Entity participates in value stream |

---

## Integration with External Standards

- **Brick Schema**: Equipment classes align with Brick taxonomy (e.g., `brick:Electrical_Room`, `brick:Generator`)
- **ASHRAE 223**: Spatial and thermal object modeling (e.g., `s223:PhysicalSpace`, `s223:ElectricEnergyTransformer`)
- **OPC UA Device Integration (DI)**: Device metadata and network properties (`di:Manufacturer`, `di:Model`, `di:SerialNumber`, `di:NetworkAddress`)
- **QUDT**: Unit and quantity kind assignments for all measurements (e.g., `qudt:quantityKind`, `qudt:hasUnit`)

---

## Implementation Notes

1. **Device Metadata**: All PowerDeviceType instances should include at least manufacturer, model, and serialNumber for asset tracking.
2. **Telemetry Organization**: Group related measurements into TelemetryStreams (e.g., Input, Output, Battery, Fault) for cleaner data models.
3. **Control Linkage**: Gateway/Controllers should reference controlled equipment via `wattsch:controls` and setpoints via object properties.
4. **Documentation**: Use `wattsch:hasDocument` to reference SOPs, MOPs, wiring diagrams, and protocol maps for operational guidance.
5. **POI & Value Streams**: Define grid boundaries and optimization programs clearly at the Site/POI level to enable demand response and energy arbitrage.
6. **Alarms & States**: Leverage enumerated types for consistent state representation across the facility ontology.
