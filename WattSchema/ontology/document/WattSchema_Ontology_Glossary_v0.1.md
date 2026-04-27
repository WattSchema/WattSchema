# WattSchema — Glossary v0.1

## Purpose
This glossary provides a unified terminology reference for the **Watt Schema Ontology**, which models the power infrastructure of mission-critical data centers.  
It ensures consistent semantic usage across engineering, operations, telemetry ingestion, analytics, and interoperability frameworks.

## Scope
This document summarizes all **Classes, Object Properties, Data Properties, and Enumerations** defined in the final **Watt Schema Core Ontology v1.0**.  
Additional enums used only in **simulation or PoC** contexts are categorized separately.

## Standards Alignment
WattSchema aligns with widely adopted standards:

- **Brick Schema** – building and electrical system modeling  
- **ASHRAE 223P** – semantic tagging and interoperability  
- **QUDT** – quantity kinds and units  
- **OPC UA DI & Energy Companion Specs** – device-level modeling  

---

# 1. Classes

| Class | Label | Description |
|------|--------|-------------|
| ATSType | Automatic Transfer Switch | Represents an Automatic Transfer Switch. |
| ActiveEnergyExport | Active Energy Export (kWh) | Represents exported active energy. |
| ActiveEnergyImport | Active Energy Import (kWh) | Represents imported active energy. |
| ActivePower | Active Power (kW) | Represents real power. |
| ApparentPower | Apparent Power (kVA) | Represents apparent power. |
| BESSType | Battery Energy Storage System | Includes PCS and battery system. |
| BMSType | Battery Management System | Represents a standalone BMS. |
| BatteryMetricsType | Battery Metrics Type | Represents battery-level aggregated metrics. |
| BatteryStringMetricsType | Battery String Metrics Type | Represents string-level metrics. |
| BuswayType | Busway and Bus Duct | Represents a busway/bus duct distribution system. |
| CellMetricsType | Cell Metrics Type | Represents cell-level monitoring metrics. |
| ControllerType | PLC Controls | Represents a PLC or site controller. |
| Current | Current (A) | Electrical current measurement. |
| DCCurrent | DC Current (A) | DC current measurement. |
| DCVoltage | DC Voltage (V) | DC voltage measurement. |
| DataHall | Data Hall | Represents a data hall. |
| ElectricalMeasurementsType | Electrical Measurements Type | Represents aggregated electrical measurements. |
| ElectricalRoom | Electrical Room | Represents an electrical room. |
| FeederType | Feeder | Feeder circuit inside switchgear or panelboard. |
| Frequency | Frequency (Hz) | Frequency measurement. |
| GatewayType | Gateway / SCADA | Supervisory gateway or SCADA interface. |
| GeneratorSetType | Diesel/Gas Generator | Represents a generator set. |
| GeneratorYard | Generator Yard | Physical space for generator sets. |
| GroundingNetworkType | Grounding & Bonding Network | Grounding system monitoring points. |
| HarmonicsI | Current Harmonics [1..n] | Current harmonics. |
| HarmonicsV | Voltage Harmonics [1..n] | Voltage harmonics. |
| Humidity | Humidity (%RH) | Relative humidity measurement. |
| MCCType | Motor Control Center | Represents an MCC. |
| MotorFeederType | Motor Feeder | Motor starter/feeder within an MCC. |
| PDUType | Power Distribution Unit | Floor-level or mains PDU. |
| PQMeterType | Power Quality Meter | Power quality metering device. |
| PercentZ | Impedance (%Z) | Transformer percent impedance. |
| Phase | Electrical Phase | Represents electrical phases. |
| PointName | Point Name | Identifies telemetry point names. |
| PowerDeviceType | PowerDevice | Base class for power-equipment types. |
| PowerFactor | Power Factor (ratio) | Represents power factor. |
| PriKV | Primary Voltage (kV) | Transformer primary voltage. |
| RPPType | Remote Power Panel | Row-level distribution panel. |
| Rack | Rack | IT equipment rack. |
| RackPDUType | Rack Power Distribution Unit | Rack-mounted PDU. |
| ReactivePower | Reactive Power (kVAR) | Reactive power measurement. |
| RemainingTime | Remaining Time (minutes) | Estimated backup/runtime. |
| SOP | SOP | Standard Operating Procedures. |
| SPDType | Surge Protective Device | Surge protection device. |
| STSType | Static Transfer Switch | High-speed static switch. |
| SecKV | Secondary Voltage (kV) | Transformer secondary voltage. |
| SiteType | Site | Top-level site container. |
| SoC | State of Charge (%) | Battery SOC. |
| SoH | State of Health (%) | Battery SOH. |
| SwitchgearType | Switchgear | Main switchgear of the facility. |
| THDI | Total Harmonic Distortion of Current (%) | Current THD. |
| THDV | Total Harmonic Distortion of Voltage (%) | Voltage THD. |
| TelemetryPoint | Telemetry Point | Represents a single measurement. |
| TelemetryStream | Telemetry Stream | Logical grouping of telemetry points. |
| Temperature | Temperature (°C) | Temperature measurement. |
| TransformerType | Transformer | Power transformer. |
| UPSType | Uninterruptible Power Supply | UPS system. |
| UtilityMeterType | Utility Meter | Utility energy meter. |
| Voltage | Voltage (V) | Voltage measurement. |
| VoltageLL | Line-to-Line Voltage (V) | L-L voltage. |
| VoltageLN | Line-to-Neutral Voltage (V) | L-N voltage. |

---

# 2. Object Properties

| Property | Label | Domain → Range | Description |
|----------|--------|----------------|-------------|
| connectedTo | ConnectedTo |  | Symmetric general connection (non-power). |
| containsEquipment | Contains Equipment |  | Indicates equipment containment. |
| controlledBy | ControlledBy |  | Inverse of controls. |
| controls | Controls |  | Control relationship. |
| fedBy | Fed By |  | Inverse of feeds. |
| feeds | Feeds |  | Downstream feed. |
| forDevice | For Device |  | Associates with device. |
| hasElectrical | Has Electrical |  | Associates with electrical info. |
| hasTelemetryPoint | Has Telemetry Point |  | Stream → TelemetryPoint. |
| hasTelemetryStream | Has Telemetry Stream |  | Device → Stream. |
| isTelemetryOf | Is Telemetry Of |  | Telemetry → device/stream. |
| isTelemetryStreamOf | Is Telemetry Stream Of |  | Stream → device. |
| isLocationOf | Is Location Of |  | Spatial containment. |
| protectedBy | ProtectedBy |  | Inverse of protects. |
| protects | Protects |  | Protection relationship. |
| suppliedBy | Supplied By |  | Inverse of suppliesPowerTo. |
| suppliesPowerTo | Supplies Power To |  | Indicates power flow. |
| ratedCurrent | Rated Current | PowerDeviceType → Current | Rated current. |
| ratedPower | Rated Active Power | PowerDeviceType → ActivePower | Rated real power. |
| ratedVoltage | Rated Voltage | PowerDeviceType → Voltage | Rated voltage. |
| hasSOP | Has SOP | PowerDeviceType → SOP | SOP association. |
| hasPhase | Has Phase | TelemetryPoint → Phase | Associates measurement with phase. |

---

# 3. Data Properties

| Property | Label | Range | Description |
|-----------|--------|--------|-------------|
| batteryStringCount | Battery String Count | integer | Number of battery strings. |
| batteryType | Battery Type | string | Battery chemistry/type. |
| breakerCount | Breaker Count | integer | Breaker count. |
| breakerType | Breaker Type | string | Breaker type. |
| busbarRating | Busbar Rating (A) | float | Switchgear busbar rating. |
| buswayConnection | Busway Connection | boolean | PDU busway connection. |
| circuitCount | Circuit Count | integer | Circuit count. |
| communicationProtocol | Communication Protocol | string | Supported communication protocols. |
| coolingType | Cooling Type | string | Cooling method. |
| firmwareVersion | Firmware Version | string | Firmware version. |
| fuelTankCapacity | Fuel Tank Capacity (L or gal) | float | Fuel tank capacity. |
| fuelType | Fuel Type | string | Fuel type. |
| hasValue | Has Value | float | Numeric measurement. |
| impedancePercent | Impedance (%) | float | Transformer impedance. |
| ipAddress | IP Address | string | Device IP address. |
| manufacturer | Manufacturer | string | Manufacturer name. |
| model | Model Name | string | Model identifier. |
| numberOfPoles | Number of Poles | integer | Number of ATS poles. |
| outletCount | Outlet Count | integer | Number of rack PDU outlets. |
| preferredSource | Preferred Source | SourceEnum | Preferred input source. |
| serialNumber | Serial Number | string | Serial number. |
| softwareRevision | Software Revision | string | Software revision. |
| temperatureSensor | Temperature Sensor Installed | boolean | Indicates presence of temperature sensor. |
| transferTimeMS | Transfer Time (ms) | float | Transfer switching time. |
| transferType | Transfer Type | string | ATS transfer type. |

---

# 4. Enumerations

| Name | Allowed Values | Description |
|------|----------------|-------------|
| BreakerStateEnum | Unknown, Open, Closed, Tripped, Intermediate | Breaker operational state. |
| DeviceStateEnum | Unknown, Stopped, Standby, Running, Faulted, Maintenance | Device operational condition. |
| SourceEnum | Utility, Generator, UPS, BESS, Bypass | Source selection for incoming feed. |
| UPSModeEnum | Online, OnBattery, Eco, Bypass, Standby, Fault | UPS operating mode. |
| ATSModeEnum | Auto, Manual, Test, LockedOut | ATS control mode. |
| GenModeEnum | Ready, Starting, Running, Testing, Cooldown, Stopped, Fault | Generator mode. |
| BatteryChemistryEnum | LFP, NMC, NCA, LeadAcid, Other | Battery chemistry. |
| RedundancyScheme | N, N+1, 2N, 2(N+1) | Denotes redundancy configuration used in power design. |
| ControllerStatusEnum | Running, Degraded, Failed | Status of controller or PLC. |
| ProtectionStatusEnum | Good, Degraded, Failed | Health state of surge protective device. |
| ContactorStateEnum | Open, Closed | Indicates contactor state of battery or PCS system. |
| ModeEnum (BESSMode) | Charge, Discharge, Idle, Fault | Operational mode of Battery Energy Storage System. |
| StarterStateEnum | Off, Run, Trip | State of motor feeder or MCC starter. |
| OutletStateEnum | On, Off | Represents outlet state in rack PDU. |
| ThyristorHealthEnum | Good, Fair, Poor | Health condition of thyristors in STS. |
