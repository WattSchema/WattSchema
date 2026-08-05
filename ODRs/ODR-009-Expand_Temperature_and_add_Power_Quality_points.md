# ODR-009: Expand Temperature Points and Add Power Quality Points

## Context

WattSchema's existing `wattsch:Temperature` subclasses did not cover several temperature measurement points commonly reported by generator and fuel systems, and there was no dedicated telemetry category for power quality metrics such as voltage/current unbalance. These gaps limited the schema's ability to represent detailed equipment monitoring and power quality analysis use cases.

## Decisions

Four new classes are added in `WattSchema_CORE.ttl`:

- `wattsch:EngineOilTemperature` — a subclass of `wattsch:Temperature` representing the temperature of generator engine oil.
- `wattsch:FuelTemperature` — a subclass of `wattsch:Temperature` representing the temperature of fuel in the system.
- `wattsch:VoltageUnbalance` — a subclass of `wattsch:TelemetryPoint` representing voltage unbalance as a percentage, placed alongside the existing `wattsch:THDV` power quality point.
- `wattsch:CurrentUnbalance` — a subclass of `wattsch:TelemetryPoint` representing current unbalance as a percentage, placed alongside `wattsch:VoltageUnbalance`.

`EngineOilTemperature` and `FuelTemperature` follow the existing temperature-subclass pattern (e.g. `EngineCoolantTemperature`), carrying `qudt:quantityKind quantityKind:Temperature` and the standard `DEG_C`/`DEG_F`/`K` unit set. `VoltageUnbalance` and `CurrentUnbalance` follow the existing percentage-based power quality pattern (e.g. `THDV`), carrying `qudt:applicableUnit unit:PERCENT`.

## Consequences

Generator/fuel system temperature reporting and power quality monitoring can now be modeled with dedicated classes instead of being omitted from the schema. This closes part of the gap identified for detailed power quality analysis (issue #14) and gives future power quality additions (e.g. THD current, flicker, sag/swell) a clear existing pattern to follow.
