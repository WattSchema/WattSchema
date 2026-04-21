-- ============================================================
-- ENTITY TABLES
-- ============================================================

CREATE TABLE ats_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    number_of_poles         BIGINT,
    transfer_type           STRING,
    transfer_time_ms        FLOAT,
    preferred_source        STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE bess_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE bms_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE busway_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE controller_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE feeder_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE gateway_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE generator_set_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    fuel_type               STRING,
    fuel_tank_capacity      FLOAT,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE grounding_network_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE location (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    location_type           STRING        NOT NULL,
    location_id             STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE mcc_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE measurement (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    measurement_type        STRING        NOT NULL,
    has_value               DECIMAL(18,6),
    formula                 STRING,
    calculation_rate        STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE motor_feeder_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE pdu_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    circuit_count           BIGINT,
    busway_connection       BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE phase (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE pq_meter_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE rack_pdu_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    outlet_count            BIGINT,
    circuit_count           BIGINT,
    busway_connection       BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE rpp_type (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    circuit_count           BIGINT,
    busway_connection       BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE sop (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    document_url            STRING,
    document_file_name      STRING,
    document_version        STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE spd_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE sts_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    number_of_poles         BIGINT,
    transfer_type           STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    transfer_time_ms        FLOAT,
    preferred_source        STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE switchgear_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    busbar_rating           DECIMAL(18,2),
    breaker_type            STRING,
    breaker_count           BIGINT,
    preferred_source        STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE technical_document (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    document_type           STRING        NOT NULL,
    document_url            STRING,
    document_file_name      STRING,
    document_version        STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE telemetry_point (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE telemetry_stream (
    entity_key              STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE transformer_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    impedance_percent       FLOAT,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE ups_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    asset_id                STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE utility_meter_type (
    entity_key              STRING,
    event_id                STRING,
    curie                   STRING,
    iri                     STRING,
    site_id                 STRING,
    manufacturer            STRING,
    model                   STRING,
    serial_number           STRING,
    software_revision       STRING,
    firmware_version        STRING,
    ip_address              STRING,
    communication_protocol  STRING,
    battery_type            STRING,
    battery_string_count    BIGINT,
    cooling_type            STRING,
    temperature_sensor_installed BOOLEAN,
    asset_id                STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);


-- ============================================================
-- RELATIONSHIP TABLES
-- ============================================================

CREATE TABLE connected_from (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE connected_to (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE contains_equipment (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE controlled_by (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE controls (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE fed_by (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE feeds (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE for_device (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_document (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_electrical (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_location (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_phase (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_sop (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_telemetry_point (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE has_telemetry_stream (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE is_telemetry_of (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE is_telemetry_stream_of (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE located_in (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE protected_by (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE protects (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE supplied_by (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);

-- ------------------------------------------------------------

CREATE TABLE supplies_power_to (
    relationship_id         STRING        NOT NULL,
    event_id                STRING        NOT NULL,
    source_entity_key       STRING        NOT NULL,
    source_curie            STRING,
    target_entity_key       STRING        NOT NULL,
    target_curie            STRING,
    source_entity_type      STRING,
    target_entity_type      STRING,
    site_id                 STRING,
    properties              STRING,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP,
    is_deleted              BOOLEAN
);
