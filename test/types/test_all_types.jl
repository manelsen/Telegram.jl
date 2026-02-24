# Test Suite for All Telegram Types (Milestone 2)
# Run this file to test all type definitions and their new fields

using Telegram
using Test

@testset "Telegram Types - Milestone 2" begin

    println("\n" * "="^60)
    println("Running Telegram Types Tests (Milestone 2)")
    println("="^60 * "\n")

    # Run Update tests
    println("Running Update type tests (TU-036 to TU-038)...")
    include("test_update.jl")

    # Run Message tests
    println("\nRunning Message type tests (TU-039 to TU-041)...")
    include("test_message.jl")

    # Run Chat tests
    println("\nRunning Chat type tests (TU-042 to TU-043)...")
    include("test_chat.jl")

    # Summary tests
    @testset "Summary Tests" begin
        println("\n" * "="^60)
        println("Summary of Tests")
        println("="^60 * "\n")

        # Check that all types are defined
        @test Telegram.Update !== nothing
        @test Telegram.Message !== nothing
        @test Telegram.Chat !== nothing
        @test Telegram.BusinessConnection !== nothing
        @test Telegram.BusinessIntro !== nothing
        @test Telegram.BusinessLocation !== nothing
        @test Telegram.PaidMedia !== nothing
        @test Telegram.PaidMediaPhoto !== nothing
        @test Telegram.PaidMediaVideo !== nothing
        @test Telegram.Gift !== nothing

        # Check that all new fields exist
        update_fields = fieldnames(Telegram.Update)
        @test :business_connection in update_fields
        @test :business_message in update_fields
        @test :edited_business_message in update_fields

        message_fields = fieldnames(Telegram.Message)
        @test :business_connection_id in message_fields
        @test :paid_media in message_fields
        @test :gift in message_fields

        chat_fields = fieldnames(Telegram.Chat)
        @test :business_intro in chat_fields
        @test :business_location in chat_fields

        println("✅ All types are defined")
        println("✅ All new fields are present")
        println("\n" * "="^60)
        println("All Type Tests Passed!")
        println("="^60 * "\n")
    end

end
