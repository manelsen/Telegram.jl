using Telegram, Telegram.API
using Test
using JSON3
include("TestHelpers.jl")
using .TestHelpers

@testset "Modern SDK Integration & DX Tests" begin
    
    @testset "Macro: @api_method (v9.4 Verification)" begin
        # We'll use getMe from v70 which uses the macro-like generation
        # and verify it works with FixtureClient
        tg = FixtureClient()
        useglobally!(tg)
        
        me = getMe()
        @test me.id == 12345678
        @test me.username == "anonymized_bot"
    end

    @testset "Macro: @bot_command" begin
        # Simulate a message object
        msg = (message = (text = "/start", chat = (id = 999,)),)
        
        command_triggered = false
        # The macro should match "/start"
        @bot_command "/start" msg begin
            command_triggered = true
        end
        @test command_triggered == true

        # Should NOT match different command
        wrong_command = false
        @bot_command "/help" msg begin
            wrong_command = true
        end
        @test wrong_command == false
    end

    @testset "Friendly Error Handling (Elm-style)" begin
        # Mock a 401 Unauthorized error
        responses = Dict("getMe" => Dict("ok" => false, "error_code" => 401, "description" => "Unauthorized"))
        tg_fail = MockClient(responses=responses)
        
        try
            getMe(tg_fail)
        catch e
            @test e isa Telegram.TelegramError
            @test e.code == 401
            @test occursin("Your BOT_TOKEN seems invalid", e.advice)
            
            # Test string representation (show)
            io = IOBuffer()
            show(io, e)
            @test occursin("💡 Advice:", String(take!(io)))
        end
    end

    @testset "CLI Tools: onboard" begin
        # Run onboarding in a temp directory
        mktempdir() do tmp_dir
            cd(tmp_dir) do
                # We need to reach back to the Telegram module
                # In a real scenario, the user would have done 'using Telegram'
                onboard()
                
                @test isfile(".env")
                @test isfile("main.jl")
                
                content = read("main.jl", String)
                @test occursin("run_bot() do msg", content)
                @test occursin("@bot_command", content)
            end
        end
    end

    @testset "CLI Tools: doctor" begin
        # Mocking doctor is hard because it uses run(), 
        # but we can at least check if it runs without crashing
        # in a controlled environment.
        mktempdir() do tmp_dir
            cd(tmp_dir) do
                # Should report FAILs because there is no .env here
                # but it should not crash.
                @test_nowarn doctor()
            end
        end
    end

    @testset "Global API Export Verification" begin
        # Verify that V94 methods are available in Telegram.API
        @test :getUserProfileAudios in names(Telegram.API, all=true)
        # Verify they are exported in the main Telegram module
        @test :getUserProfileAudios in names(Telegram, all=true)
    end
end
