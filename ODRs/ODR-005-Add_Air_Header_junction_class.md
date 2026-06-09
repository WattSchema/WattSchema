# ODR-005: Add Air_Header Junction Class

## Context

On the air side, air-handling equipment such as AHUs and CRAHs is currently connected directly to Cold Aisles and Hot Aisles via `brick:feeds` / `brick:isFedBy`. This is physically inaccurate: an air-handling unit's fans are not dedicated to a single aisle. In reality, N pieces of equipment and M aisles share a common air path (plenum, raised floor, or shared room volume) — an N:M relationship. A direct equipment↔aisle edge falsely implies a dedicated path and causes the edge count to grow as N×M. The chilled-water side already solves the analogous problem with `wsch_brick:Chiller_Plant_Header` (a `s223:Junction`), but the air side has no equivalent junction class.

## Decisions

One new class is added in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:Air_Header` — a header (junction) that mediates air distribution between air-handling equipment (e.g., AHU, CRAH) and conditioned spaces (e.g., Cold Aisle, Hot Aisle), decoupling the otherwise direct N:M `feeds`/`isFedBy` relationships into N:1 + 1:M through the junction.

It is declared as `rdfs:subClassOf s223:Junction`, mirroring `wsch_brick:Chiller_Plant_Header` so the air side and chilled-water side follow the same header pattern, and placed in the `wsch_brick:` namespace because upstream Brick has no equivalent. A single generic class is used rather than splitting supply and return into separate classes; direction is distinguished by instance topology (`feeds` / `isFedBy`) and naming, not by the type, keeping the hierarchy minimal and symmetric with `Chiller_Plant_Header`.

## Consequences

The air distribution path can now be modeled with a first-class junction, eliminating the misleading direct N:M edges, reflecting that fans are not dedicated to individual aisles, and reducing the edge count from N×M to N+M while mirroring the chilled-water side's pattern. Migrating existing direct ahu↔aisle connections, defining a SHACL NodeShape to enforce junction usage, and validating the return-path directionality against the Brick/REC `feeds` constraint are deferred to follow-up work.
