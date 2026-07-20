# ODR-007: Add Operational Parameters for Optimizer

## Context

The optimizer needs several equipment- and setpoint-level parameters as inputs to its operation logic (pump/chiller staging, part-load control, and chilled-water setpoint bounding), and Brick has no equivalent terms for them:

- A pump's or hydraulic equipment's rated pressure drop across a component (e.g. a coil, filter, strainer, or heat exchanger) at rated flow.
- A chiller's maximum part load ratio, complementing the existing `wsch_brick:minimumPartLoadRatio`.
- A pump's shutoff head factor, used to approximate its pump curve when a full curve is not available.
- Lower/upper bounds on a chiller's leaving chilled water temperature setpoint, following the existing min/max setpoint-limit pattern already used for water flow.

## Decisions

Four new terms (plus one supporting SHACL shape) are added in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:ratedPressureDrop` — a generic datatype property (no fixed `rdfs:domain`, matching the `ratedHead` precedent) for a component's rated/design pressure drop at rated flow. Its value is expressed as a `brick:value`/`brick:hasUnit` pair, constrained by the new `wsch_brick:Pressure_Drop_CapacityQuantityShape` to `unit:PA`, `unit:KiloPA`, `unit:PSI`, `unit:FT_H2O`, or `unit:M_H2O` — the same `*_CapacityQuantityShape` pattern used by `Water_Flow_CapacityQuantityShape` and `Air_Flow_CapacityQuantityShape`.
- `wsch_brick:maximumPartLoadRatio` — a dimensionless `xsd:decimal` datatype property (0-1), mirroring `minimumPartLoadRatio`.
- `wsch_brick:shutoffHeadFactor` — a dimensionless `xsd:decimal` datatype property: the ratio of a pump's shutoff head (head at zero flow) to its rated head.
- `wsch_brick:Min_Leaving_Chilled_Water_Temperature_Setpoint_Limit` / `wsch_brick:Max_Leaving_Chilled_Water_Temperature_Setpoint_Limit` — classes bounding a `Leaving_Chilled_Water_Temperature_Setpoint`, each subclassing `brick:Limit` plus `brick:Min_Limit`/`brick:Max_Limit`, following the existing `Min_Water_Flow_Setpoint_Limit`/`Max_Water_Flow_Setpoint_Limit` pattern. As with the other `Limit` classes in this extension (e.g. `Min_Water_Approach_Temperature_Limit`), the unit (`unit:DEG_C`, `unit:DEG_F`, or `unit:K`) is carried directly on the instance's `brick:hasUnit` rather than enforced by a dedicated SHACL shape, so no new shape was added for these two classes.

## Consequences

Pumps, chillers, and other hydraulic equipment can now carry pressure-drop, part-load-ratio, and pump-curve-approximation parameters, and chillers can have explicit bounds on their leaving chilled water temperature setpoint — all consumable by the optimizer alongside the existing rated-capacity and flow/temperature-limit parameters. The pressure-drop unit set is enforced via SHACL; enforcing the temperature-limit unit set (and reconciling the two different unit-constraint styles used across `Limit` classes vs. `rated*` capacity properties in this extension) is deferred to follow-up work.
