using Telegram, Telegram.API
using Test
using JSON3
isdefined(@__MODULE__, :TestHelpers) || include("TestHelpers.jl")

@testset "Modern SDK Integration & DX Tests" begin
    
    @testset "Macro: @api_method (v9.4 Verification)" begin
        # We'll use getMe from v70 which uses the macro-like generation
        # and verify it works with FixtureClient
        tg = TestHelpers.FixtureClient()
        useglobally!(tg)
        
        me = getMe()
        @test me.id == 12345678
        @test me.username == "anonymized_bot"
    end

    @testset "Macro: @bot_command (not yet merged)" begin
        # Implemented on feat/macros, but not available in this branch.
        # A broken test records the missing API without invoking an undefined macro.
        @test_broken isdefined(Telegram, Symbol("@bot_command"))
    end

    @testset "Friendly Error Handling (Elm-style)" begin
        # Mock a 401 Unauthorized error
        responses = Dict("getMe" => Dict("ok" => false, "error_code" => 401, "description" => "Unauthorized"))
        tg_fail = TestHelpers.MockClient(responses=responses)
        
        err = try
            getMe(tg_fail)
            nothing
        catch e
            e
        end
        @test err isa Telegram.TelegramError
        if err isa Telegram.TelegramError
            @test err.msg["error_code"] == 401
            # Extended .code/.advice API is not in the released core.
            @test_broken hasproperty(err, :code)
            @test_broken hasproperty(err, :advice)
        end
    end

    @testset "CLI Tools: onboard (not yet merged)" begin
        @test_broken isdefined(Telegram, :onboard)
    end

    @testset "CLI Tools: doctor (not yet merged)" begin
        @test_broken isdefined(Telegram, :doctor)
    end

    @testset "Global API Export Verification" begin
        # Verify that V94 methods are available in Telegram.API
        @test :getUserProfileAudios in names(Telegram.API, all=true)
        # A global re-export was proposed separately, but is not in the core.
        @test_broken :getUserProfileAudios in names(Telegram, all=true)
    end
end
