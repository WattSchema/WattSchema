# ODR-006: Add ratedHead Property for Pumps

## Context

Pump staging and flow balancing in a chilled-water loop need each pump's rated/design total dynamic head, but Brick has no head-related property. Spec sheets report this value (e.g. 170 ft H2O total dynamic head), so it must be captured somewhere in the model.

## Decisions

One new datatype property is added in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:ratedHead` — the rated/design total dynamic head a pump (or other hydraulic equipment) is sized for, expressed as head of water.

It is placed in the `wsch_brick:` namespace because upstream Brick has no equivalent, and kept as a generic datatype property (no fixed `rdfs:domain`) so it can later apply to other CHW-loop equipment such as chillers and coils. The definition explicitly excludes NPSH, which is a separate spec-sheet value we do not model.

## Consequences

Pumps can now carry a design-head value usable for staging and flow-balancing calculations alongside the existing flow-capacity properties. Unit convention (head of water in `unit:FT_H2O` vs. a pressure unit such as `unit:KiloPA`) and any SHACL value/domain constraints are deferred to follow-up work.
