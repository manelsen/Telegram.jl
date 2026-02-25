module DecisionSupport

using UUIDs
using Dates
using SHA
using JSON3

export generate_request_id, generate_operation_id, generate_timestamp_utc
export add_notification_metadata, datetime_to_iso8601, validate_https_enforced
export calculate_checksum, validate_checksum
export get_schema_version, validate_schema_version

# ============================================================================
# DS-001: Traceability (Rastreabilidade)
# ============================================================================

"""
    generate_request_id() -> String

Generate a unique request ID for traceability.

Returns a UUID v4 as a String.
"""
function generate_request_id()
    return string(UUIDs.uuid4())
end

"""
    generate_operation_id(prefix::String = "") -> String

Generate a unique operation ID with optional prefix.

# Arguments
- `prefix::String`: Optional prefix for the operation ID

# Returns
- `String`: Unique operation ID with prefix
"""
function generate_operation_id(prefix::String = "")
    uuid_part = string(UUIDs.uuid4())
    return isempty(prefix) ? uuid_part : "$prefix-$uuid_part"
end

"""
    add_notification_metadata(data::Dict; request_id::String = "", timestamp::Union{DateTime, Nothing} = nothing) -> Dict

Add traceability metadata to a notification.

# Arguments
- `data::Dict`: Original notification data
- `request_id::String`: Optional request ID to include
- `timestamp::Union{DateTime, Nothing}`: Optional timestamp to include

# Returns
- `Dict`: Notification data with metadata added
"""
function add_notification_metadata(data::Dict; request_id::String = "", timestamp::Union{DateTime, Nothing} = nothing)
    result = copy(data)

    # Add request ID if provided
    if !isempty(request_id)
        result["_request_id"] = request_id
    end

    # Add timestamp if provided
    if timestamp !== nothing
        result["_timestamp"] = datetime_to_iso8601(timestamp)
    end

    return result
end

# ============================================================================
# DS-002: Reproducibility (Reprodutibilidade)
# ============================================================================

# Reproducibility is handled by:
# 1. Using JSON3.write which produces deterministic output
# 2. Versioned schema (DS-005)
# 3. Consistent parameter serialization (handled in client.jl)

# ============================================================================
# DS-003: Integrity (Integridade)
# ============================================================================

"""
    validate_https_enforced(url::String) -> Bool

Validate that HTTPS is enforced for the given URL.

# Arguments
- `url::String`: URL to validate

# Returns
- `Bool`: True if HTTPS is enforced, false otherwise
"""
function validate_https_enforced(url::String)
    # Check if URL starts with https://
    return startswith(lowercase(url), "https://")
end

"""
    calculate_checksum(data::Any) -> String

Calculate SHA256 checksum for data integrity.

# Arguments
- `data::Any`: Data to calculate checksum for (will be serialized to JSON)

# Returns
- `String`: Hexadecimal SHA256 checksum
"""
function calculate_checksum(data::Any)
    json_str = JSON3.write(data)
    return bytes2hex(SHA.sha256(json_str))
end

"""
    validate_checksum(data::Any, expected_checksum::String) -> Bool

Validate data integrity using checksum.

# Arguments
- `data::Any`: Data to validate
- `expected_checksum::String`: Expected checksum

# Returns
- `Bool`: True if checksum matches, false otherwise
"""
function validate_checksum(data::Any, expected_checksum::String)
    actual_checksum = calculate_checksum(data)
    return actual_checksum == expected_checksum
end

# ============================================================================
# DS-004: Temporal Order (Ordem Temporal)
# ============================================================================

"""
    generate_timestamp_utc() -> DateTime

Generate current timestamp in UTC.

# Returns
- `DateTime`: Current timestamp in UTC
"""
function generate_timestamp_utc()
    return now(UTC)
end

"""
    datetime_to_iso8601(dt::DateTime) -> String

Convert DateTime to ISO 8601 string format.

# Arguments
- `dt::DateTime`: DateTime to convert

# Returns
- `String`: ISO 8601 formatted string
"""
function datetime_to_iso8601(dt::DateTime)
    return Dates.format(dt, "yyyy-mm-ddTHH:MM:SS.sssZ")
end

# ============================================================================
# DS-005: Contracts (Contratos)
# ============================================================================

const SCHEMA_VERSION = "1.0.0"

"""
    get_schema_version() -> String

Get the current schema version.

# Returns
- `String`: Current schema version
"""
function get_schema_version()
    return SCHEMA_VERSION
end

"""
    validate_schema_version(version::String; allow_minor::Bool = true) -> Bool

Validate schema version compatibility.

# Arguments
- `version::String`: Version to validate
- `allow_minor::Bool`: Whether to allow minor version differences

# Returns
- `Bool`: True if version is compatible, false otherwise
"""
function validate_schema_version(version::String; allow_minor::Bool = true)
    try
        # Parse versions
        major_parts = parse_version(SCHEMA_VERSION)
        minor_parts = parse_version(version)

        # Check version has exactly 3 components (major.minor.patch)
        if length(minor_parts) != 3
            return false
        end

        if allow_minor
            # Allow same major version
            return major_parts[1] == minor_parts[1]
        else
            # Require exact match
            return SCHEMA_VERSION == version
        end
    catch
        return false
    end
end

"""
    parse_version(version::String) -> Vector{Int}

Parse semantic version string into components.

# Arguments
- `version::String`: Version string (e.g., "1.0.0")

# Returns
- `Vector{Int}`: Version components [major, minor, patch]
"""
function parse_version(version::String)
    parts = split(version, ".")
    return [parse(Int, p) for p in parts]
end

end # module
