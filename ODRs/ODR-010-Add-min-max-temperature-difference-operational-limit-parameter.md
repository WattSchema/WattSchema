# ODR-010: Add Min/Max Differential Temperature Operational Limit Parameter Classes

## Context

Chiller-plant and cooling-load points frequently need an operational guard on ΔT (e.g., entering-minus-leaving chilled/condenser water temperature), protecting against low-ΔT flow/energy inefficiency and high-ΔT evaporator freeze risk. This is distinct from bounding a single absolute temperature reading. Brick already treats differential temperature as its own quantity (`brick:Differential_Temperature`, `qudt:isDeltaQuantity true`) and already distinguishes `brick:Chilled_Water_Differential_Temperature_Sensor` from a plain `Chilled_Water_Temperature_Sensor`. Reusing the existing `wsch_brick:Min_Temperature_Operational_Limit`/`wsch_brick:Max_Temperature_Operational_Limit` classes on a ΔT point would misrepresent the quantity as an absolute temperature, so a dedicated pair of limit classes is needed (see [issue #17](https://github.com/WattSchema/WattSchema/issues/17)).

## Decisions

Two new classes are added in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:Min_Differential_Temperature_Operational_Limit` — subclasses `brick:Min_Limit`; places a lower bound on the range of permitted values of an observed temperature difference (e.g., entering minus leaving water temperature).
- `wsch_brick:Max_Differential_Temperature_Operational_Limit` — subclasses `brick:Max_Limit`; places an upper bound on the range of permitted values of an observed temperature difference.

These mirror the existing `wsch_brick:Min_Temperature_Operational_Limit`/`wsch_brick:Max_Temperature_Operational_Limit` pattern, but subclass only `brick:Min_Limit`/`brick:Max_Limit` (not `brick:Temperature_Parameter`), since the bounded quantity is a differential temperature rather than an absolute one.

## Consequences

ΔT-based points (e.g., chilled/condenser water differential temperature sensors) can now have explicit min/max operational limits that correctly represent the differential-temperature quantity, without being conflated with absolute-temperature limits. As with the existing `Min`/`Max_Temperature_Operational_Limit` classes, no dedicated SHACL shape is added; unit enforcement for these limit classes is deferred to follow-up work.
