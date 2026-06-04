# ODR-004: Add Evaporator Class for Chiller

## Context

WattSchema's Brick extension models data center cooling equipment so that the components of a chiller — identified on chilled water schematics and refrigeration cycle diagrams — can be represented with consistent semantics and used for part-level (assembly) modeling. A chiller is built from a small set of well-understood refrigeration-cycle parts: the compressor, the condenser, the expansion device, and the evaporator. To model a chiller explicitly as an assembly of its parts, each part needs a dedicated class.

The upstream Brick Schema already provides classes for two of these parts: `brick:Compressor` for the compressor and `brick:Condensing_Unit` for the condenser side. However, Brick does not define an explicit class for the evaporator — the heat exchanger where the chilled (process) water rejects its heat to the refrigerant and the refrigerant evaporates. Without a dedicated class, the evaporator either has to be omitted from the part-level model or represented with a generic parent class, which breaks the consistency of the chiller part decomposition.

## Decisions

One new class is added as a subclass of `brick:Heat_Exchanger` in `WattSchema_Brick_Ext.ttl`:

- `wsch_brick:Evaporator` — a heat exchanger in which the refrigerant absorbs heat from the medium being cooled (e.g., chilled water or air) and evaporates; in a chiller, it cools the chilled water loop supplied to the cooling load.

The class is placed in the `wsch_brick:` namespace because the upstream Brick Schema does not yet define an equivalent concept. It is declared as `rdfs:subClassOf brick:Heat_Exchanger` rather than the more generic `brick:HVAC_Equipment`, because an evaporator is, by definition, a heat exchanger (refrigerant ↔ chilled water or air), and this matches the Brick definition of `brick:Heat_Exchanger` ("equipment built for efficient heat transfer from one medium to another"). Since `brick:Heat_Exchanger` is itself a subclass of `brick:HVAC_Equipment`, the evaporator remains transitively an HVAC equipment for Brick-based reasoners and queries, while being typed more precisely. The definition is kept general (refrigeration-cycle heat exchanger) rather than chiller-specific so that the class can be reused for DX air handlers, heat pumps, and other refrigeration systems, with the chiller given as the primary application in the data center context.

The sibling class `brick:Evaporative_Heat_Exchanger` was explicitly rejected as the parent. Despite the similar name, its `tag:Evaporative` modifier denotes *evaporative cooling* — rejecting heat by evaporating water into an air stream, as in cooling towers and evaporative condensers — not the refrigerant evaporation that occurs in a chiller's evaporator. Subclassing it would have asserted an incorrect heat-transfer mechanism and caused tag-based queries to group the evaporator with evaporative-cooling devices.

## Consequences

A chiller can now be modeled explicitly as an assembly of its constituent parts, with the evaporator represented by a first-class type alongside the compressor (`brick:Compressor`) and the condenser (`brick:Condensing_Unit`). This eliminates the gap in the chiller part decomposition and allows telemetry points (e.g., chilled water supply/return temperature, refrigerant saturation temperature/pressure, approach temperature) to be bound to the precise component they originate from, supporting more accurate performance and fault analysis at the evaporator. Because the class is typed under `brick:Heat_Exchanger`, evaporators are also reachable by queries over heat-exchange equipment, and the general (non-chiller-specific) definition lets the same class serve DX air handlers, heat pumps, and other refrigeration systems. As a trade-off, the class lives under the WattSchema Brick extension namespace rather than core Brick, so downstream consumers must import the extension to resolve the type; if upstream Brick later adopts an equivalent evaporator class, the extension should be revisited and aligned via `owl:equivalentClass`.
