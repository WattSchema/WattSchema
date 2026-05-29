# ODR-001: Add New Power Device Classes

## Context

WattSchema's core ontology models the power distribution chain of a data center so that physical assets identified in electrical drawings (single-line diagrams, panel schedules, switchgear elevations) can be represented with consistent semantics. During recent reviews of data center electrical drawings, several common devices were found to have no dedicated class under `wattsch:PowerDeviceType`, forcing engineers to either reuse a generic parent class such as `brick:Electrical_Equipment` or omit the asset entirely. To support more granular modeling of equipment identified on data center electrical drawings, additional `wattsch:PowerDeviceType` subclasses are required.

## Decisions

Five new classes are added as subclasses of `wattsch:PowerDeviceType` in `WattSchema_CORE.ttl`:

- `wattsch:MeterType` — generic meter device that measures usage or consumption. Declared as `rdfs:subClassOf brick:Meter`, and acts as a generalization of the existing `wattsch:UtilityMeterType`.
- `wattsch:CircuitBreakerType` — individual circuit breaker modeled as a first-class asset, independent of its enclosure (switchgear, panelboard, switchboard). Declared as `owl:equivalentClass brick:Circuit_Breaker`.
- `wattsch:RelayType` — protection or control relay used to switch circuits or initiate protective actions when abnormal conditions are detected. Declared as `owl:equivalentClass brick:Relay`.
- `wattsch:PanelboardType` — distribution panel housing branch circuit breakers that distribute electrical power from an upstream feeder to multiple downstream branch circuits.
- `wattsch:SwitchboardType` — main electrical distribution assembly that receives power from an upstream source and feeds downstream loads. Kept distinct from `wattsch:SwitchgearType`, which carries higher fault-current and arc-flash ratings under different standards (UL 891 vs. UL 1558).

Where Brick defines an equivalent concept, the new class is aligned via `owl:equivalentClass` or `rdfs:subClassOf` so that Brick-based tooling can interoperate without re-mapping.

## Consequences

Every protective and distribution device shown on a data center electrical drawing now has a dedicated class, eliminating reliance on `brick:Electrical_Equipment` as a catch-all and allowing telemetry points (current, voltage, status, trip events) to be bound to the precise device they originate from. The new `wattsch:MeterType` and `wattsch:RelayType` classes also provide extension points for future sub-meter and protection-relay modeling within a consistent ontology. As a trade-off, existing instance data typed against generic parent classes will need to be re-typed to the more specific class, and authors must consult equipment nameplates or specifications to choose correctly between `wattsch:SwitchboardType` and `wattsch:SwitchgearType` since the boundary is defined by ratings and standards rather than topology.
