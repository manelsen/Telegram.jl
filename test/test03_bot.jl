module TestBot

using Telegram
using Telegram.API
using Test

# Deterministic polling tests. No network access or real bot credentials.
@testset "run_bot polling" begin
    @testset "dispatches updates and advances offset monotonically" begin
        offsets = Any[]
        received = Int[]
        calls = Ref(0)

        query_func = (client, method, params) -> begin
            @test method == "getUpdates"
            push!(offsets, get(params, :offset, nothing))
            calls[] += 1
            if calls[] == 1
                return [Dict(:update_id => 10)]
            elseif calls[] == 2
                return [Dict(:update_id => 11)]
            else
                throw(InterruptException())
            end
        end
        client = TelegramClient("synthetic"; query_func, use_globally = false,
                                enable_traceability = false)
        run_bot(update -> push!(received, update[:update_id]), client; timeout = 0)
        @test received == [10, 11]
        @test offsets == [nothing, 11, 12]
    end

    @testset "explicit offset is passed to polling" begin
        offsets = Int[]
        query_func = (client, method, params) -> begin
            push!(offsets, params[:offset])
            throw(InterruptException())
        end
        client = TelegramClient("synthetic"; query_func, use_globally = false,
                                enable_traceability = false)
        run_bot(_ -> nothing, client; timeout = 0, offset = 100)
        @test offsets == [100]
    end

    @testset "callback errors on initial polling do not replay updates" begin
        offsets = Any[]
        query_func = (client, method, params) -> begin
            push!(offsets, get(params, :offset, nothing))
            length(offsets) == 1 && return [Dict(:update_id => 42)]
            throw(InterruptException())
        end
        client = TelegramClient("synthetic"; query_func, use_globally = false,
                                enable_traceability = false)
        received = Int[]
        run_bot(update -> begin
            push!(received, update[:update_id])
            error("synthetic handler failure")
        end, client; timeout = 0)
        @test received == [42]
        @test offsets == [nothing, 43]
    end
end

end # module TestBot
