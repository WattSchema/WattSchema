# ODR-003: Active Power Setpoint Limit Parameters

## Context

For the optimal charge/discharge operation of a BESS (Battery Energy Storage System), parameters are required to capture optimization results or operational constraints when generating control setpoints. These parameters need to serve as reference values (limits/thresholds) so that operating policies derived by site operators or optimization engines can be consistently applied to BESS control setpoints.

## Decisions

Depending on the BESS system, active power setpoints are controlled in two different ways:

1. **Single setpoint approach**: Charging and discharging are controlled through a single ActivePower Setpoint. Typically, a positive (+) value represents discharging and a negative (−) value represents charging.
2. **Separated setpoint approach**: Charge Setpoint and Discharge Setpoint are defined separately, and charging and discharging are controlled independently.

To support both cases, min/max limit parameter classes are introduced for each control variant:

- `wattsch:MaxActivePowerSetpointLimit` / `wattsch:MinActivePowerSetpointLimit` — for the single setpoint approach
- `wattsch:MaxChargePowerSetpointLimit` / `wattsch:MinChargePowerSetpointLimit` — for the charge side of the separated setpoint approach
- `wattsch:MaxDischargePowerSetpointLimit` / `wattsch:MinDischargePowerSetpointLimit` — for the discharge side of the separated setpoint approach

Each class is defined as a subclass of either `brick:Max_Limit` or `brick:Min_Limit`, with `quantityKind:ActivePower` and applicable units of W, kW, and MW.

## Consequences

Data center or site operators can apply or update optimal operation policy constraint values on these parameter classes, allowing the Knowledge Graph (KG) to carry those values. This enables the parameters to act as safety guardrails or threshold values for charge/discharge setpoint configuration during system operation. In addition, by selecting the appropriate parameter classes according to the BESS control scheme (single setpoint vs. separated setpoint), diverse BESS control architectures can be represented within a consistent ontology.
