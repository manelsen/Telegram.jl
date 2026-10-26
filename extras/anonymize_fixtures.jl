using JSON3

const FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")

# Mapeamento de chaves sensíveis para valores fake
const ANONYM_MAP = Dict(
    :id => 12345678,
    :chat_id => 12345678,
    :user_id => 12345678,
    :message_id => 12345678,
    :update_id => 12345678,
    :chat_instance => "ANONYMIZED_IDENTIFIER",
    :inline_message_id => "ANONYMIZED_IDENTIFIER",
    :business_connection_id => "ANONYMIZED_IDENTIFIER",
    :first_name => "AnonymizedUser",
    :last_name => "Name",
    :username => "anonymized_bot",
    :phone_number => "+5511999999999",
    :email => "anonymous@example.com",
    :text => "Anonymized message content",
    :caption => "Anonymized caption",
    :question => "Anonymized question",
    :explanation => "Anonymized explanation",
    :bio => "Anonymized biography",
    :description => "Anonymized description",
    :short_description => "Anonymized description",
    :data => "Anonymized callback data",
    :latitude => 0.0,
    :longitude => 0.0,
    :file_id => "FILE_ID_ANONYMIZED_REDACTED",
    :file_unique_id => "FILE_UNIQUE_ID_REDACTED",
    :address => "Anonymized Address",
    :vcard => "Anonymized VCard Data",
    :title => "Anonymized Chat Title",
    :file_path => "Anonymized file path",
    :invite_link => "https://example.com/anonymized"
)

function anonymize_recursive!(obj)
    if obj isa JSON3.Object || obj isa Dict
        # Precisamos criar um novo dicionário se for um JSON3.Object (que é imutável)
        # Mas para simplificar, vamos converter tudo para Dict durante o processo
        new_obj = Dict{Symbol, Any}()
        for (k, v) in obj
            key = Symbol(k)
            if haskey(ANONYM_MAP, key)
                new_obj[key] = ANONYM_MAP[key]
            else
                new_obj[key] = anonymize_recursive!(v)
            end
        end
        return new_obj
    elseif obj isa JSON3.Array || obj isa AbstractVector
        return [anonymize_recursive!(item) for item in obj]
    else
        return obj
    end
end

"""Anonymize fixtures in the selected directory; explicitly invoked by the CLI."""
function anonymize_fixtures(fixtures_dir::String = FIXTURES_DIR)
    println("Iniciando anonimização das fixtures em: $fixtures_dir")

    for file in readdir(fixtures_dir)
        if endswith(file, ".json")
            path = joinpath(fixtures_dir, file)
            try
                data = JSON3.read(read(path, String))
                anonymized_data = anonymize_recursive!(data)

                open(path, "w") do io
                    JSON3.write(io, anonymized_data)
                end
                println("✓ $file anonimizado com sucesso.")
            catch e
                @error "Falha ao processar $file" exception=e
            end
        end
    end

    println("Processo concluído. Revise os campos antes de publicar fixtures.")
end

if abspath(PROGRAM_FILE) == abspath(@__FILE__)
    anonymize_fixtures()
end
