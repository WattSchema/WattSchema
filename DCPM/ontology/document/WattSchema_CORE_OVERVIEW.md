# Data Center Power Management (DCPM) - Core Ontology Requirements

This document provides a comprehensive reference for all foundational classes, properties, and relationships defined in the **DCPM Core Ontology v1.0**. This Core document serves as the semantic foundation for **Power Path Definition**, **Physical Infrastructure Modeling**, **Telemetry & Measurement Framework**, **Device Metadata & Control**, and **Commercial Value Stream Alignment** necessary for comprehensive site-level power management and digital twin synchronization.

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
- **`dcpm:SiteType`**: Top-level container for a physical site or data center (subclass of `s223:PhysicalSpace`).
  - Properties: `siteId`, `latitude`, `longitude`
- **`dcpm:ElectricalRoom`**: Zone for electrical distribution (equivalent to `brick:Electrical_Room`).
- **`dcpm:DataHall`**: Physical space dedicated to IT infrastructure.
- **`dcpm:BatteryRoom`**: Zone for energy storage systems (equivalent to `brick:Battery_Room`).
- **`dcpm:GeneratorYard`**: Exterior area for power generation units (subclass of `brick:Outdoor_Area`).
- **`dcpm:GeneratorRoom`**: Interior zone for generator equipment (subclass of `brick:Electrical_Room`).
- **`dcpm:Rack`**: Individual equipment rack within data hall or electrical room.

---

<a id="2-power-equipment-classes"></a>
## 2. Power Equipment Classes

All power equipment inherits from `dcpm:PowerDeviceType` (subclass of `di:DeviceType`), enabling OPC UA Device Integration compliance.

### 2.1. Utility Interface & Switching
- **`dcpm:SwitchgearType`**: Main site switchgear receiving utility power and distributing to loads.
- **`dcpm:FeederType`**: Individual feeder circuit within switchgear or panelboard.
- **`dcpm:UtilityMeterType`**: Revenue-grade meter tracking import/export energy (subclass of `brick:Electrical_Meter`).

### 2.2. Distribution & Power Conditioning
- **`dcpm:TransformerType`**: Power transformers for voltage conversion (subclass of `s223:ElectricEnergyTransformer`).
- **`dcpm:PDUType`**: Floor-level/mains Power Distribution Unit (base class for PDU variants).
- **`dcpm:RPPType`**: Remote Power Panel (specialized PDU, closer to load).
- **`dcpm:RackPDUType`**: Rack-mounted PDU with outlet-level monitoring and control.
- **`dcpm:BuswayType`**: Busway power distribution system.

### 2.3. Power Transformation (UPS/BESS)
- **`dcpm:UPSType`**: Uninterruptible Power Supply (subclass of `brick:Uninterruptible_Power_Supply`).
- **`dcpm:BESSType`**: Battery Energy Storage System including Power Conversion System (PCS) (subclass of `brick:Battery_Energy_Storage_System`).
- **`dcpm:BMSType`**: Standalone Battery Management System.

### 2.4. Transfer Switches
- **`dcpm:ATSType`**: Automatic Transfer Switch for source switching (subclass of `brick:Automatic_Transfer_Switch`).
- **`dcpm:STSType`**: Static Transfer Switch for zero-transfer-time switching (subclass of `brick:Static_Transfer_Switch`).

### 2.5. Generation
- **`dcpm:GeneratorSetType`**: Diesel/Gas generator set for backup power (equivalent to `brick:Generator`).

### 2.6. Motor & Load Control
- **`dcpm:MCCType`**: Motor Control Center for managing motor feeders (equivalent to `brick:Motor_Control_Center`).
- **`dcpm:MotorFeederType`**: Individual motor starter/feeder within MCC.

### 2.7. Power Quality & Protection
- **`dcpm:PQMeterType`**: Dedicated power quality monitoring device (subclass of `brick:Meter`).
- **`dcpm:SPDType`**: Surge Protective Device for transient protection.
- **`dcpm:GroundingNetworkType`**: Monitoring points of facility grounding system.

### 2.8. Control & Communication
- **`dcpm:GatewayType`**: Gateway or SCADA system (equivalent to `brick:Gateway`).
- **`dcpm:ControllerType`**: Site controller or Programmable Logic Controller (equivalent to `brick:Controller`).

### 2.9. Common Static Parameters (All PowerDeviceType)
- **`dcpm:manufacturer` / `dcpm:model`**: Device manufacturer and model name.
- **`dcpm:serialNumber`**: Unique manufacturer-assigned ID.
- **`dcpm:softwareRevision` / `dcpm:firmwareVersion`**: Software/firmware version.
- **`dcpm:ipAddress`**: Network address (IPv4/IPv6).
- **`dcpm:communicationProtocol`**: Protocol support (e.g., Modbus TCP, BACnet, SNMP).
- **`dcpm:coolingType`**: Cooling method (air, liquid, etc.).
- **`dcpm:temperatureSensorInstalled`**: Boolean indicating temperature sensor presence.
- **Rated Parameters**: `ratedPower`, `ratedVoltage`, `ratedCurrent`, `ratedStorageCapacity`

---

<a id="3-measurement-and-telemetry-classes"></a>
## 3. Measurement and Telemetry Classes

Detailed classification of measured data points using QUDT units and quantity kinds.

### 3.1. Electrical Power & Energy
- **`dcpm:ActivePower`**: Real power in kW or MW.
- **`dcpm:ActiveEnergy`**: Total active energy; sub-types include `ImportActiveEnergy` and `ExportActiveEnergy` (kWh).
- **`dcpm:ImportActivePower` / `dcpm:ExportActivePower`**: POI or meter-facing active power import/export.
- **`dcpm:ImportActivePowerL1/L2/L3` / `dcpm:ExportActivePowerL1/L2/L3`**: Per-phase import/export active power.
- **`dcpm:BypassActivePower`**: Active power flowing through bypass path (typically UPS bypass for load switching).
- **`dcpm:ApparentPower`**: Total apparent power in kVA.
- **`dcpm:InputApparentPower` / `dcpm:OutputApparentPower`**: Device-terminal apparent power.
- **`dcpm:InputApparentPowerL1/L2/L3` / `dcpm:OutputApparentPowerL1/L2/L3`**: Per-phase apparent power.
- **`dcpm:ReactivePower`**: Imaginary power in kVAR.
- **`dcpm:PowerFactor`**: Ratio of active to apparent power (dimensionless).

### 3.2. Voltage, Current & Frequency
- **`dcpm:Voltage`**: AC line voltage; sub-types: `VoltageLL` (Line-to-Line) and `VoltageLN` (Line-to-Neutral) in Volts.
- **`dcpm:InputVoltageL1L2/L2L3/L3L1`**: Line-to-line input voltages.
- **`dcpm:OutputVoltageL1L2/L2L3/L3L1`**: Line-to-line output voltages.
- **`dcpm:InputVoltageL1N/L2N/L3N`**: Line-to-neutral input voltages.
- **`dcpm:OutputVoltageL1N/L2N/L3N`**: Line-to-neutral output voltages.
- **`dcpm:PrimaryKV` / `dcpm:SecondaryKV`**: Primary/Secondary transformer voltage in kV.
- **`dcpm:Current`**: AC electric current in Amperes.
- **`dcpm:InputCurrent` / `dcpm:OutputCurrent`**: Device-terminal current direction.
- **`dcpm:InputCurrentL1/L2/L3` / `dcpm:OutputCurrentL1/L2/L3`**: Per-phase input/output current.
- **`dcpm:DCCurrent`**: DC electric current in Amperes.
- **`dcpm:DCVoltage`**: DC voltage in Volts.
- **`dcpm:Frequency`**: System frequency in Hz.
- **`dcpm:PercentZ`**: Transformer impedance expressed as percentage.

### 3.3. Power Quality & Harmonics
- **`dcpm:THDI`**: Total Harmonic Distortion of Current (%).
- **`dcpm:THDV`**: Total Harmonic Distortion of Voltage (%).
- **`dcpm:HarmonicsI`** / **`dcpm:HarmonicsV`**: Individual harmonic components [1..n].

### 3.4. Battery & Energy Storage
- **`dcpm:SoC`**: State of Charge (%).
- **`dcpm:SoH`**: State of Health (%).
- **`dcpm:MinSOC` / `dcpm:MaxSOC`**: Minimum/maximum allowable SOC thresholds (%).
- **`dcpm:EnergyAvailable`**: Currently dischargeable energy in kWh.
- **`dcpm:ChargeEfficiency` / `dcpm:DischargeEfficiency`**: Operational efficiency ratios (dimensionless).

### 3.5. Temperature & Environmental
- **`dcpm:Temperature`**: Ambient temperature in °C.
- **`dcpm:CellTemperature`**: Battery cell temperature in °C.
- **`dcpm:EngineCoolantTemperature`**: Generator engine coolant temperature in °C.
- **`dcpm:Humidity`**: Relative humidity in %RH.

### 3.6. Control Setpoints
- **`dcpm:ActivePowerSetpoint`**: Target active power value (kW/MW).
- **`dcpm:ChargePowerSetpoint`**: Commanded battery charge rate (kW).
- **`dcpm:DischargePowerSetpoint`**: Commanded battery discharge rate (kW).

### 3.7. Generator-Specific Metrics
- **`dcpm:EngineRPM`**: Engine rotational speed (rev/min).
- **`dcpm:EngineOilPressure`**: Engine lubrication oil pressure (PSI).
- **`dcpm:FuelLevel`**: Fuel tank level (%).
- **`dcpm:LoadingPercentage`**: Current load as % of rated capacity.

### 3.8. Equipment-Specific Metrics
- **`dcpm:RemainingTime`**: Battery or UPS runtime remaining (minutes).
- **`dcpm:ATSTransferCount`**: Number of transfer events recorded.

---

<a id="4-telemetry-infrastructure"></a>
## 4. Telemetry Infrastructure

Structural framework for organizing measurement points and the data they produce.

### Entity Classes
- **`dcpm:TelemetryPoint`**: Represents a single measured data point (e.g., voltage, current, frequency).
  - Property: `dcpm:pointName` — hierarchical identifier following naming convention
  - Relationship: `dcpm:hasPhase` — links to electrical phase context (L1, L2, L3, LN, LL)
  
- **`dcpm:TelemetryStream`**: Logical grouping of related telemetry points for a device.
  - Examples: Input stream (utility power), Output stream (delivered to loads), Battery stream (energy storage)
  - Relationship: `dcpm:isTelemetryStreamOf` — links to parent PowerDeviceType
  - Relationship: `dcpm:hasTelemetryPoint` — contains measurement points

### Phase Context Classes
- **`dcpm:Phase`**: Base class representing electrical phase context
- **`dcpm:Phase_L1` / `dcpm:Phase_L2` / `dcpm:Phase_L3`**: Three-phase AC contexts
- **`dcpm:Phase_LN`**: Line-to-Neutral phase
- **`dcpm:Phase_LL`**: Line-to-Line phase

### Metric Type Container Classes
- **`dcpm:ElectricalMeasurementsType`**: Container for electrical telemetry
- **`dcpm:BatteryMetricsType`**: Container for battery-level metrics
- **`dcpm:BatteryStringMetricsType`**: Container for individual battery string metrics
- **`dcpm:CellMetricsType`**: Container for individual cell-level metrics

---

<a id="5-device-metadata-and-parameters"></a>
## 5. Device Metadata and Parameters

Static properties and identifiers for all power devices.

### Device Identification
- **`dcpm:assetId`**: Unique asset identifier (per facility standards).
- **`dcpm:serialNumber`** (OPC UA equivalent: `di:SerialNumber`)
- **`dcpm:manufacturer`** (OPC UA equivalent: `di:Manufacturer`)
- **`dcpm:model`** (OPC UA equivalent: `di:Model`)

### Firmware & Software
- **`dcpm:softwareRevision`** (OPC UA equivalent: `di:SoftwareRevision`)
- **`dcpm:firmwareVersion`** (specialization of software revision)

### Network & Communication
- **`dcpm:ipAddress`** (subproperty of `di:NetworkAddress`)
- **`dcpm:communicationProtocol`**: Supported protocol(s) (Modbus, BACnet, SNMP, OPC UA, etc.)

### Equipment Configuration
- **`dcpm:batteryType`**: Battery chemistry (VRLA, Li-ion, NiCd, LiFePO4, etc.)
- **`dcpm:batteryStringCount`**: Number of battery strings in system
- **`dcpm:numberOfPoles`** (for ATS/STS): Switch pole configuration
- **`dcpm:transferType`** (for ATS): Open Transition vs. Closed Transition
- **`dcpm:busbarRating`** (for Switchgear): Current rating in Amperes
- **`dcpm:breakerType`**: Circuit breaker model/series
- **`dcpm:breakerCount`**: Number of breakers installed
- **`dcpm:impedancePercent`** (for Transformer): Impedance %
- **`dcpm:coolingType`**: Cooling method (air, liquid, forced air, etc.)
- **`dcpm:temperatureSensorInstalled`**: Boolean flag
- **`dcpm:circuitCount`** (for PDU): Circuit count
- **`dcpm:buswayConnection`** (for PDU): Boolean busway attachment
- **`dcpm:outletCount`** (for Rack PDU): Number of outlets
- **`dcpm:fuelType`** (for Generator): Diesel, Natural Gas, Propane, etc.
- **`dcpm:fuelTankCapacity`** (for Generator): Capacity in liters or gallons

### Transfer Switch Parameters
- **`dcpm:transferTimeMS`** (for ATS/STS): Transfer time in milliseconds
- **`dcpm:preferredSource`**: Preferred input source (Utility, Generator, UPS) per `dcpm:SourceEnum`

### Location & Hierarchy
- **`dcpm:locationId`**: Unique identifier for physical location (room, zone, etc.)

### Measurements & Derived Values
- **`dcpm:hasValue`**: Numeric value associated with measurement
- **`dcpm:formula`**: Calculation formula for derived measurements
- **`dcpm:calculationRate`**: Frequency/rate of calculation

---

<a id="6-control-systems-and-setpoints"></a>
## 6. Control Systems and Setpoints

Controllable parameters and performance indicators.

### Control Setpoints
Setpoints are target values for equipment control, referenced via `dcpm:ActivePowerSetpoint` and battery-specific variants:
- **`dcpm:ChargePowerSetpoint`**: Target charge rate for BESS
- **`dcpm:DischargePowerSetpoint`**: Target discharge rate for BESS
- **`dcpm:ActivePowerSetpoint`**: General power target for switchable/controllable devices

### Key Performance Indicators (KPI)
- **`dcpm:KPI`**: Class for monitoring device or system performance.
  - Examples: Uptime %, Energy efficiency, Demand response performance, Cost savings

---

<a id="7-object-properties-and-relationships"></a>
## 7. Object Properties and Relationships

Relationships defining power flows, control hierarchies, and data linkages.

### Power Flow Relationships
- **`dcpm:feeds`**: PowerDevice → PowerDevice (downstream power flow)
- **`dcpm:fedBy`**: PowerDevice → PowerDevice (upstream power supply relationship)
- **`dcpm:suppliesPowerTo`**: Source (POI/BESS/Generator) → Equipment (direct supply)
- **`dcpm:suppliedBy`**: Equipment → Source (inverse of suppliesPowerTo)

### Physical Placement
- **`dcpm:hasLocation`**: Equipment → PhysicalSpace (placement within site hierarchy)
- **`dcpm:isLocationOf`**: Inverse of hasLocation
- **`dcpm:containsEquipment`**: PhysicalSpace → Equipment (spatial containment)

### Telemetry & Measurement
- **`dcpm:hasTelemetryStream`**: PowerDevice → TelemetryStream
- **`dcpm:isTelemetryStreamOf`**: TelemetryStream → PowerDevice (inverse)
- **`dcpm:hasTelemetryPoint`**: PowerDevice/TelemetryStream → TelemetryPoint
- **`dcpm:isTelemetryOf`**: TelemetryPoint → PowerDevice (inverse)
- **`dcpm:hasPhase`**: TelemetryPoint → Phase (phase context)

### Control & Protection
- **`dcpm:controls`**: ControllerType → PowerDevice (control relationship)
- **`dcpm:controlledBy`**: PowerDevice → ControllerType (inverse)
- **`dcpm:protects`**: SPD/Breaker → Equipment (protection relationship)
- **`dcpm:protectedBy`**: Equipment → SPD/Breaker (inverse)

### Electrical Connections
- **`dcpm:connectedTo`**: Device → Device (bidirectional connection)
- **`dcpm:connectedFrom`**: Device → Device (directional incoming connection)

### Documentation & Operations
- **`dcpm:hasSOP`**: Equipment → SOP (links Standard Operating Procedures)
- **`dcpm:hasDocument`**: Equipment → Document (links manuals, diagrams, specs)

### Value Stream & Grid Integration
- **`dcpm:hasPointOfInterconnection`**: Site → PointOfInterconnection
- **`dcpm:hasValueStream`**: Site/Equipment/POI → ValueStream
- **`dcpm:hasElectrical`**: Unspecified electrical measurement association

---

<a id="8-point-of-interconnection-poi"></a>
## 8. Point of Interconnection (POI)

### Entity Class
- **`dcpm:PointOfInterconnection`**: The electrical boundary between utility grid and site.
  - **Comment**: Defines meter points for settlement, demand tracking, program eligibility, or optimization measurement boundaries.

### POI Properties
- **`dcpm:POIId`**: Unique identifier for the grid connection point.
- **`dcpm:importLimitMax`**: Maximum power import allowed by contract (kW/MW).
- **`dcpm:exportLimitMax`**: Maximum power export allowed to the grid (kW/MW).

---

<a id="9-value-stream-entities"></a>
## 9. Value Stream Entities

### Entity Class
- **`dcpm:ValueStream`**: Revenue or cost optimization pathway.
  - **Comment**: Represents programs such as energy arbitrage, demand response, tariff-based optimization, or subsidy programs. May be associated with POI, Site, or specific Equipment depending on measurement boundary.

### Properties
- **`dcpm:ValueStreamId`**: Unique identifier for the value stream.
- **`dcpm:ValueStreamProgram`**: Enumerated program type per `dcpm:ValueStreamProgramEnum`:
  - `Tariff Based Energy Arbitrage`
  - `Tariff Based Demand Charge Management`
  - `MA Clean Peak`
  - `SGIP` (Self-Generation Incentive Program)
  - `ITC` (Investment Tax Credit)
  - Other utility or regulatory programs
- **`dcpm:tariffReference`**: Link to applicable utility rate schedule or contract.

---

<a id="10-documentation-and-metadata"></a>
## 10. Documentation and Metadata

Supporting classes for device documentation, maintenance, and operational reference.

### Documentation Types
- **`dcpm:Document`**: Base class for any associated documentation
- **`dcpm:UserManual`**: End-user operational guide
- **`dcpm:InstallationGuide`**: Installation and commissioning procedures
- **`dcpm:TechnicalSpecifications`**: Detailed equipment specifications
- **`dcpm:WiringDiagram`**: Electrical schematic and wiring layouts
- **`dcpm:CommunicationProtocolDoc`**: Protocol documentation
  - **`dcpm:ModbusMap`**: Modbus register map
  - **`dcpm:BACnetObjects`**: BACnet object definitions
  - **`dcpm:OPCUAModel`**: OPC UA address space model
- **`dcpm:MaintenanceSchedule`**: Planned maintenance intervals
- **`dcpm:MaintenanceHistory`**: Historical maintenance records
- **`dcpm:FirmwarePackage`**: Firmware update releases and patches

### Operational Procedures
- **`dcpm:SOP`**: Standard Operating Procedures for critical equipment operations
- **`dcpm:MOP`**: Method of Procedure for maintenance and troubleshooting tasks

### Document Properties
- **`dcpm:documentUrl`**: URL or URI to document location
- **`dcpm:documentFileName`**: File name or identifier
- **`dcpm:documentVersion`**: Version number or release date

---

<a id="11-enumerated-types"></a>
## 11. Enumerated Types

Predefined value sets for device states, modes, and configuration options.

### Device & Component States
- **`dcpm:BreakerStateEnum`**: Unknown | Open | Closed | Tripped | Intermediate
- **`dcpm:DeviceStateEnum`**: Unknown | Stopped | Standby | Running | Faulted | Maintenance
- **`dcpm:MotorFeederStarterStateEnum`**: Off | Run | Trip
- **`dcpm:BreakerTripCauseEnum`**: None | Overload | ShortCircuit | GroundFault | Undervoltage | Overvoltage | Manual | Other

### Operating Modes
- **`dcpm:UPSModeEnum`**: Online | OnBattery | Eco | Bypass | Standby | Fault
- **`dcpm:ATSModeEnum`**: Auto | Manual | Test | LockedOut
- **`dcpm:GenModeEnum`**: Ready | Starting | Running | Testing | Cooldown | Stopped | Fault
- **`dcpm:SourceEnum`**: Utility | Generator | UPS | BESS | Bypass

### Equipment Properties
- **`dcpm:BatteryChemistryEnum`**: LFP (LiFePO4) | NMC | NCA | LeadAcid | Other
- **`dcpm:ThyristorHealthEnum`**: Good | Fair | Poor (for STS/electronic switches)

### Alarm & Health Status
- **`dcpm:UPSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical
- **`dcpm:GenAlarmStatusEnum`**: Normal | Warning | Alarm | Critical | Shutdown
- **`dcpm:BESSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical | Fault
- **`dcpm:ATSAlarmStatusEnum`**: Normal | Warning | Alarm | Critical

### Value Stream Programs
- **`dcpm:ValueStreamProgramTypeEnum`**: Tariff Based Energy Arbitrage | Tariff Based Demand Charge Management | MA Clean Peak | SGIP | ITC

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
| `dcpm:feeds` | PowerDevice | PowerDevice | → | Downstream power delivery |
| `dcpm:fedBy` | PowerDevice | PowerDevice | ← | Upstream power source |
| `dcpm:suppliesPowerTo` | Source (POI/BESS/Gen) | Equipment | → | Direct supply relationship |
| `dcpm:suppliedBy` | Equipment | Source | ← | Supplied by relationship |
| **Physical Hierarchy** | | | | |
| `dcpm:hasLocation` | Equipment | PhysicalSpace | → | Equipment placement |
| `dcpm:isLocationOf` | PhysicalSpace | Equipment | ← | Located in space |
| `dcpm:containsEquipment` | PhysicalSpace | Equipment | → | Space contains device |
| **Telemetry & Measurement** | | | | |
| `dcpm:hasTelemetryStream` | PowerDevice | TelemetryStream | → | Device has measurement stream |
| `dcpm:isTelemetryStreamOf` | TelemetryStream | PowerDevice | ← | Stream belongs to device |
| `dcpm:hasTelemetryPoint` | Device/Stream | TelemetryPoint | → | Stream/device has point |
| `dcpm:isTelemetryOf` | TelemetryPoint | PowerDevice | ← | Point measures device |
| `dcpm:hasPhase` | TelemetryPoint | Phase | → | Point measured on phase |
| `dcpm:hasElectrical` | — | — | — | (Unspecified electrical link) |
| **Control & Protection** | | | | |
| `dcpm:controls` | ControllerType | PowerDevice | → | Device controls equipment |
| `dcpm:controlledBy` | PowerDevice | ControllerType | ← | Equipment is controlled by |
| `dcpm:protects` | SPD/Breaker | Equipment | → | Device protects downstream |
| `dcpm:protectedBy` | Equipment | SPD/Breaker | ← | Equipment protected by |
| **Electrical Connections** | | | | |
| `dcpm:connectedTo` | PowerDevice | PowerDevice | ↔ | Bidirectional connection |
| `dcpm:connectedFrom` | PowerDevice | PowerDevice | ← | Connected from upstream |
| **Documentation & Operations** | | | | |
| `dcpm:hasSOP` | Equipment | SOP | → | Links Standard Operating Procedures |
| `dcpm:hasDocument` | Equipment | Document | → | Links manual, schematic, spec |
| **Commercial & Grid Integration** | | | | |
| `dcpm:hasPointOfInterconnection` | Site | PointOfInterconnection | → | Site has utility connection boundary |
| `dcpm:hasValueStream` | Site/Equipment/POI | ValueStream | → | Entity participates in value stream |

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
3. **Control Linkage**: Gateway/Controllers should reference controlled equipment via `dcpm:controls` and setpoints via object properties.
4. **Documentation**: Use `dcpm:hasDocument` to reference SOPs, MOPs, wiring diagrams, and protocol maps for operational guidance.
5. **POI & Value Streams**: Define grid boundaries and optimization programs clearly at the Site/POI level to enable demand response and energy arbitrage.
6. **Alarms & States**: Leverage enumerated types for consistent state representation across the facility ontology.
