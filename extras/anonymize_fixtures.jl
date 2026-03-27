using JSON3

const FIXTURES_DIR = joinpath(@__DIR__, "..", "test", "fixtures")

# Mapeamento de chaves sensíveis para valores fake
const ANONYM_MAP = Dict(
    :id => 12345678,
    :chat_id => 12345678,
    :user_id => 12345678,
    :first_name => "AnonymizedUser",
    :last_name => "Name",
    :username => "anonymized_bot",
    :phone_number => "+5511999999999",
    :text => "Anonymized message content",
    :caption => "Anonymized caption",
    :latitude => 0.0,
    :longitude => 0.0,
    :file_id => "FILE_ID_ANONYMIZED_REDACTED",
    :file_unique_id => "FILE_UNIQUE_ID_REDACTED",
    :address => "Anonymized Address",
    :vcard => "Anonymized VCard Data",
    :title => "Anonymized Chat Title"
)

function anonymize_recursive!(obj)
    if obj isa JSON3.Object || obj isa Dict
        # Precisamos criar um novo dicionário se for um JSON3.Object (que é imutável)
        # Mas para simplificar, vamos converter tudo para Dict durante o processo
        new_obj = Dict{Symbol, Any}()
        for (k, v) in obj
            if haskey(ANONYM_MAP, k)
                new_obj[k] = ANONYM_MAP[k]
            else
                new_obj[k] = anonymize_recursive!(v)
            end
        end
        return new_obj
    elseif obj isa JSON3.Array || obj isa AbstractVector
        return [anonymize_recursive!(item) for item in obj]
    else
        return obj
    end
end

println("Iniciando anonimização das fixtures em: $FIXTURES_DIR")

for file in readdir(FIXTURES_DIR)
    if endswith(file, ".json")
        path = joinpath(FIXTURES_DIR, file)
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

println("
Processo concluído! Todos os dados sensíveis foram removidos.")
