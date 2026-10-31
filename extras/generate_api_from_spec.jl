# Offline deterministic generator for the pinned Telegram Bot API specification.
# Run: julia --project=. extras/generate_api_from_spec.jl
# Verify: julia --project=. extras/generate_api_from_spec.jl --check
module APIReferenceGenerator

using JSON3

const ROOT = normpath(joinpath(@__DIR__, ".."))
const SPEC_FILE = joinpath(@__DIR__, "bot_api_10_3.min.json")
const TICK = string(Char(96))

read_spec() = JSON3.read(read(SPEC_FILE, String))
sorted_pairs(obj) = [(name, getproperty(obj, Symbol(name))) for name in sort(String.(collect(keys(obj))); by=lowercase)]

function doc_for_method(name, method)
    io = IOBuffer()
    println(io, "\t", name, "([tg::TelegramClient]; kwargs...)")
    println(io)
    println(io, join(String.(method.description), "\n\n"))
    for (title, required) in (("Required", true), ("Optional", false))
        fields = [f for f in get(method, :fields, ()) if Bool(f.required) == required]
        if !isempty(fields)
            println(io)
            println(io, "# ", title, " arguments")
            for field in fields
                println(io, "- ", TICK, field.name, TICK, ": (",
                        join(String.(field.types), " or "), ") ",
                        get(field, :description, ""))
            end
        end
    end
    println(io)
    print(io, "[Function documentation source](", method.href, ")")
    return String(take!(io))
end

function escape_julia_string(s)
    value = replace(s, "\\" => "\\\\")
    value = replace(value, "\$" => "\\\$")
    return replace(value, "\"\"\"" => "\\\"\"\"")
end

function render_api(spec)
    io = IOBuffer()
    println(io, "# This file is generated from extras/bot_api_10_3.min.json.")
    println(io, "# To regenerate: julia --project=. extras/generate_api_from_spec.jl")
    println(io, "const TELEGRAM_API = [")
    for (name, method) in sorted_pairs(spec.methods)
        println(io, "(:", name, ", \"\"\"")
        println(io, escape_julia_string(doc_for_method(name, method)))
        println(io, "\"\"\"),")
    end
    println(io, "]")
    return String(take!(io))
end

function render_reference(spec)
    io = IOBuffer()
    println(io, TICK^3, "@meta")
    println(io, "CurrentModule = Telegram.API")
    println(io, TICK^3, "\n")
    println(io, "# Bot API 10.3 Reference\n")
    println(io, "This page is generated from the pinned Bot API 10.3 specification (August 24, 2026).")
    println(io, "Use ", TICK, "using Telegram, Telegram.API", TICK, "; every method accepts an optional ", TICK, "TelegramClient", TICK)
    println(io, "and keyword parameters matching the Telegram Bot API. Responses use dynamic ", TICK, "JSON3.Object", TICK)
    println(io, "or arrays; type declarations are documented separately.\n")
    println(io, "See the [official Telegram Bot API](https://core.telegram.org/bots/api) for protocol details.\n")
    println(io, "## Methods\n")
    for (name, method) in sorted_pairs(spec.methods)
        println(io, "- [", TICK, name, TICK, "](", method.href, ")")
    end
    println(io, "\n## Julia method documentation\n")
    println(io, TICK^3, "@docs")
    for (name, _) in sorted_pairs(spec.methods)
        println(io, name)
    end
    println(io, TICK^3)
    return String(take!(io))
end

function render_types(spec)
    io = IOBuffer()
    println(io, "# Telegram Bot API 10.3 Object Schemas\n")
    println(io, "This is a reference for **400 Bot API object types**, generated from the pinned")
    println(io, "specification. Telegram.jl returns dynamic JSON3 objects and accepts nested")
    println(io, "JSON-serializable dictionaries; these entries describe API schemas, not Julia struct types.")
    println(io, "Files embedded in nested objects may require explicit Telegram ", TICK, "attach://", TICK, " handling.\n")
    println(io, "See the [official Telegram Bot API](https://core.telegram.org/bots/api).\n")
    for (name, model) in sorted_pairs(spec.types)
        println(io, "## ", TICK, name, TICK, "\n")
        println(io, "[Official object specification](", model.href, ")\n")
        fields = get(model, :fields, ())
        if !isempty(fields)
            println(io, "| Field | Type | Required |")
            println(io, "|---|---|---|")
            for field in fields
                f = replace(String(field.name), "|" => "\\|")
                ty = replace(join(String.(field.types), " or "), "|" => "\\|")
                println(io, "| ", TICK, f, TICK, " | ", ty, " | ",
                        Bool(field.required) ? "Yes" : "No", " |")
            end
            println(io)
        end
        subtypes = get(model, :subtypes, ())
        if !isempty(subtypes)
            println(io, "Implementations: ",
                    join([TICK * String(x) * TICK for x in subtypes], ", "), ".\n")
        end
    end
    return String(take!(io))
end

function run(; check=false)
    spec = read_spec()
    spec.version == "Bot API 10.3" || error("Unexpected API version")
    length(spec.methods) == 185 || error("Unexpected method count")
    length(spec.types) == 400 || error("Unexpected model count")
    outputs = (
        (joinpath(ROOT, "src", "telegram_api.jl"), render_api(spec)),
        (joinpath(ROOT, "docs", "src", "reference.md"), render_reference(spec)),
        (joinpath(ROOT, "docs", "src", "types.md"), render_types(spec)),
    )
    for (path, expected) in outputs
        if check
            isfile(path) && read(path, String) == expected ||
                error("Generated API file out of date: " * path)
        else
            write(path, expected)
        end
    end
    return nothing
end

end # module APIReferenceGenerator

if abspath(PROGRAM_FILE) == @__FILE__
    APIReferenceGenerator.run(; check = ("--check" in ARGS))
end
