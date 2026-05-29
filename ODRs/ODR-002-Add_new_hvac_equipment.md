# ODR-002: Add New HVAC Equipment Classes

## Context

WattSchema's Brick extension models the mechanical infrastructure of a data center so that equipment identified on mechanical drawings (chilled water schematics, piping diagrams, liquid cooling layouts) can be represented with consistent semantics. While reviewing recent data center mechanical drawings, two pieces of equipment that are increasingly common in modern data center cooling designs — hydronic-loop air/dirt separators and rack-level liquid cooling distribution units — had no dedicated class under `brick:HVAC_Equipment`. To support more granular modeling of equipment identified on data center mechanical drawings, additional HVAC equipment subclasses are required.

## Decisions

Two new classes are added as subclasses of `brick:HVAC_Equipment` in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:Air_Dirt_Separator` — a piece of HVAC equipment that removes entrained air and suspended particulates from chilled, hot, or condenser water in a hydronic loop.
- `wsch_brick:Coolant_Distribution_Unit` — an HVAC equipment that delivers controlled-temperature coolant from a secondary technology loop to IT rack cold plates and other direct liquid cooling components, exchanging heat with the facility's primary chilled water loop.

Both classes are placed in the `wsch_brick:` namespace because the upstream Brick Schema does not yet define equivalent concepts, and each is declared as `rdfs:subClassOf brick:HVAC_Equipment` so that Brick-based reasoners and queries can still treat them as HVAC equipment without further mapping.

## Consequences

Mechanical equipment commonly shown on data center cooling drawings now has dedicated classes, eliminating reliance on `brick:HVAC_Equipment` as a catch-all and allowing telemetry points (differential pressure, supply/return temperature, flow, valve position) to be bound to the precise device they originate from. In particular, introducing `wsch_brick:Coolant_Distribution_Unit` enables consistent modeling of liquid-cooled IT environments, where the CDU is the boundary between facility chilled water and the technology coolant loop feeding rack cold plates. As a trade-off, these classes live under the WattSchema Brick extension namespace rather than core Brick, so downstream consumers must import the extension to resolve the types; if upstream Brick later adopts equivalent classes, the extension should be revisited and aligned via `owl:equivalentClass`.
