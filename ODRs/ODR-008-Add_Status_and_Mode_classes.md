# ODR-008: Add Status and Operation Mode Classes

## Context

WattSchema's core ontology has so far been focused almost entirely on telemetry points that represent continuous measurements (voltage, current, power, temperature, etc.). There was no dedicated class for representing the discrete operating state of an equipment — such as its current alarm/fault condition or the operating mode it is running in — leaving no consistent way to model status and mode reports alongside numeric telemetry.

## Decisions

Three new classes are added in `WattSchema_CORE.ttl`:

- `wattsch:Status` — representing the current operating mode, state, position, or condition of an item. It acts as the parent class for more specific status/mode subclasses.
- `wattsch:AlarmStatus` — a subclass of `wattsch:Status` indicating whether an item is currently in an alarm, fault, or normal condition.
- `wattsch:OperationMode` — a subclass of `wattsch:Status` indicating the current operating mode an item is running in (e.g., auto, manual, standby).

Both `wattsch:AlarmStatus` and `wattsch:OperationMode` are placed under the new "Status / Mode Classes" section of `WattSchema_CORE.ttl`.

## Consequences

Equipment status and operating mode reports can now be modeled with dedicated, discoverable classes instead of being omitted or shoehorned into generic telemetry points. This establishes a place to add further status/mode subclasses (e.g. connectivity status, breaker position, charge/discharge mode) as those needs arise.
