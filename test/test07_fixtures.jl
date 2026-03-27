using Telegram, Telegram.API
using Test
include("TestHelpers.jl")
using .TestHelpers

@testset "Offline Fixture Tests (Modern API 7-9)" begin
    # Initialize our Fixture-based client
    tg = FixtureClient()
    useglobally!(tg)

    @testset "Metadata & Identity" begin
        me = getMe()
        @test me.is_bot == true
        @test me.username == "anonymized_bot"
        @test me.id == 12345678
    end

    @testset "Modern Updates (Reactions & Polls)" begin
        updates = getUpdates()
        @test length(updates) > 0
        
        # Test finding specific modern events in our captured collection
        has_reaction = any(u -> haskey(u, :message_reaction), updates)
        has_poll_answer = any(u -> haskey(u, :poll_answer), updates)
        has_edit = any(u -> haskey(u, :edited_message), updates)
        
        @test has_reaction == true
        @test has_poll_answer == true
        @test has_edit == true
        
        # Verify Reaction details (API 7.0+)
        reaction_update = filter(u -> haskey(u, :message_reaction), updates)[1]
        @test reaction_update.message_reaction.user.id == 12345678
    end

    @testset "Messaging & Formatting" begin
        # Now using the standard sendMessage which maps to sendMessage.json
        msg = sendMessage(text="Test", parse_mode="MarkdownV2")
        @test haskey(msg, :text)
        @test msg.text == "Anonymized message content"
    end

    @testset "Interactive Elements" begin
        # Note: API returns a Message object containing the poll
        msg = sendPoll(question="Test", options=["A", "B"])
        @test haskey(msg, :poll)
        @test msg.poll.type == "regular"
        
        msg_loc = sendLocation(latitude=0, longitude=0)
        @test haskey(msg_loc, :location)
    end

    @testset "Stickers & Dice (API 7.x)" begin
        # Now using standard sendDice which maps to sendDice.json
        dice_msg = sendDice(emoji="🎲")
        @test dice_msg.dice.emoji == "🎲"
    end
end
