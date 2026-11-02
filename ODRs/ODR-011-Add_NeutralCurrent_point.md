# ODR-011: Add NeutralCurrent Telemetry Point

## Context

WattSchema's current-related classes only covered phase currents: `wattsch:InputCurrent`, `wattsch:OutputCurrent` and their L1/L2/L3 variants. `wattsch:InputCurrent` is defined as "Measured current flowing into the site or device", so a reading taken on the neutral conductor had no correct class to map to. Without a dedicated type, a neutral current could be mapped to `wattsch:InputCurrent`, which misrepresents the quantity: a consumer that labels or aggregates readings by type would present the neutral current as the device's input current, alongside input phase currents it contradicts.

Neutral current is a distinct quantity: it is the current on the neutral conductor of a 3-phase 4-wire system, driven by phase imbalance and harmonics, and it is not the current flowing into the device. Metering and protection equipment commonly reports it separately from the phase currents (e.g. the neutral input I4 on power meters, 4-pole breaker trip units, and RPP branch monitoring), so a dedicated type is needed (see [issue #20](https://github.com/WattSchema/WattSchema/issues/20)).

## Decisions

One new class is added in `WattSchema_CORE.ttl`:

- `wattsch:NeutralCurrent` — a subclass of `wattsch:Current` representing the measured current flowing on the neutral conductor of the site or device.

It follows the existing current-class pattern (e.g. `wattsch:InputCurrent`), carrying `qudt:quantityKind quantityKind:ElectricCurrent` and the standard `unit:A`/`unit:KiloA`/`unit:MegaA` unit set. It is placed directly under `wattsch:Current` rather than `wattsch:InputCurrent`, so that queries for input current do not return neutral readings. No per-phase variants (L1/L2/L3) are added, since there is a single neutral conductor. `WattSchema_CORE_OVERVIEW.md` is updated to list the new class.

## Consequences

Neutral current can now be modeled with its own class instead of being mapped to `wattsch:InputCurrent`, keeping input/output current queries and labels accurate. Not every device reports a neutral current, so the class is optional on any given device. No dedicated SHACL shape is added.
