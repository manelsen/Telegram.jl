using Telegram, JSON3, HTTP, Test
spec=JSON3.read(read(joinpath(@__DIR__,"bot_api_10_3.min.json"),String))
observed=Ref{Any}(nothing)
server=HTTP.serve!("127.0.0.1",0;listenany=true,verbose=false) do req
    if occursin("multipart/form-data",HTTP.header(req,"Content-Type"))
        observed[]=(String(req.target),Dict(p.name=>read(p.data,String) for p in HTTP.parse_multipart_form(req)))
    else
        observed[]=(String(req.target),JSON3.read(String(req.body)))
    end
    HTTP.Response(200,["Content-Type"=>"application/json"],"{\"ok\":true,\"result\":true}")
end
function sample(field)
    t=first(field.types)
    t=="Integer" && return 103
    t=="Float" && return 1.25
    t=="Boolean" && return true
    startswith(t,"Array") && return [Dict("synthetic"=>true,"unicode"=>"ação")]
    t in ("String","InputFile") && return "synthetic"
    return Dict("synthetic"=>true,"nested"=>[Dict("value"=>103)])
end
try
    c=TelegramClient("SYNTHETIC";ep="http://127.0.0.1:$(HTTP.port(server))/bot",allow_insecure_http=true,use_globally=false,enable_traceability=false,chat_id="",parse_mode="")
    @testset "185 methods / 932 fields through HTTP transport" begin
        for (method,definition) in pairs(spec.methods)
            params=Dict(Symbol(f.name)=>sample(f) for f in get(definition,:fields,[]))
            @test getfield(Telegram.API,method)(c;params...)===true
            @test observed[][1]=="/botSYNTHETIC/$(method)"
            actual=observed[][2]
            @test Set(string.(keys(actual)))==Set(string.(keys(params)))
            multipart=!isempty(intersect(keys(params),Telegram.DEFAULT_OPTS.upload_kw))
            for (name,value) in params
                key=string(name)
                if multipart
                    expected=value isa AbstractString ? value : JSON3.write(value)
                    @test actual[key]==expected
                else
                    @test JSON3.write(actual[key])==JSON3.write(value)
                end
            end
        end
    end
    @testset "10.3 nested ephemeral upload transport" begin
        @test Telegram.editEphemeralMessageMedia(c;user_id=103,ephemeral_message_id="synthetic",media=Dict("type"=>"photo","media"=>"attach://photo"),photo="tiny.png"=>IOBuffer("synthetic-bytes"))===true
        @test observed[][2]["photo"]=="synthetic-bytes"
        @test JSON3.read(observed[][2]["media"]).media=="attach://photo"
        @test Telegram.sendMessage(c;chat_id=103,text="synthetic",ephemeral_message_parameters=Dict("receiver_user_id"=>103,"callback_query_id"=>"synthetic","replace_callback_query_message"=>true))===true
        @test observed[][2].ephemeral_message_parameters.replace_callback_query_message===true
    end
finally
    close(server)
end
