# Test Suite for Update Type (TU-036 to TU-038)
# Tests for API 7.x business connection fields

using Telegram
using Test

@testset "Update Type Tests - TU-036 to TU-038" begin

    # Helper function to create a minimal User for testing
    function create_minimal_user()
        return User(
            id=123456,
            is_bot=false,
            first_name="Test",
            last_name="User",
            username="testuser"
        )
    end

    # Helper function to create a minimal Chat for testing
    function create_minimal_chat()
        return Chat(
            id=123456,
            type="private"
        )
    end

    # Helper function to create a minimal Message for testing
    function create_minimal_message()
        return Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user()
        )
    end

    # Helper function to create a minimal BusinessConnection for testing
    function create_minimal_business_connection()
        return BusinessConnection(
            id="business_123",
            user_chat_id=123456,
            date=Time.now(),
            can_write=true,
            user=create_minimal_user()
        )
    end

    # TU-036: Test business_connection field exists
    @testset "TU-036: business_connection field" begin
        bc = create_minimal_business_connection()
        msg = create_minimal_message()

        # Create Update with business_connection
        update = Update(
            update_id=1,
            business_connection=bc,
            message=msg
        )

        @test update.business_connection !== nothing
        @test update.business_connection.id == "business_123"
        @test update.business_connection.user_chat_id == 123456
        @test update.business_connection.can_write == true
    end

    # TU-037: Test business_message field exists
    @testset "TU-037: business_message field" begin
        msg = create_minimal_message()

        # Create Update with business_message
        update = Update(
            update_id=1,
            business_message=msg
        )

        @test update.business_message !== nothing
        @test update.business_message.message_id == 1
        @test update.business_message.chat.id == 123456
    end

    # TU-038: Test edited_business_message field exists
    @testset "TU-038: edited_business_message field" begin
        msg = create_minimal_message()

        # Create Update with edited_business_message
        update = Update(
            update_id=1,
            edited_business_message=msg
        )

        @test update.edited_business_message !== nothing
        @test update.edited_business_message.message_id == 1
        @test update.edited_business_message.chat.id == 123456
    end

    # Test all three new fields together
    @testset "TU-036 to TU-038: All new fields combined" begin
        bc = create_minimal_business_connection()
        msg1 = create_minimal_message()
        msg2 = create_minimal_message()

        # Create Update with all business fields
        update = Update(
            update_id=1,
            business_connection=bc,
            business_message=msg1,
            edited_business_message=msg2
        )

        @test update.business_connection !== nothing
        @test update.business_message !== nothing
        @test update.edited_business_message !== nothing

        @test update.business_connection.id == "business_123"
        @test update.business_message.message_id == 1
        @test update.edited_business_message.message_id == 1
    end

    # Test backward compatibility (API 6.x fields still work)
    @testset "TU-036 to TU-038: Backward compatibility" begin
        msg = create_minimal_message()

        # Create Update with only API 6.x fields
        update = Update(
            update_id=1,
            message=msg
        )

        @test update.message !== nothing
        @test update.message.message_id == 1
        @test update.business_connection === nothing
        @test update.business_message === nothing
        @test update.edited_business_message === nothing
    end

    # Test JSON deserialization
    @testset "TU-036 to TU-038: JSON deserialization" begin
        json_data = """
        {
            "update_id": 1,
            "business_connection": {
                "id": "business_123",
                "user_chat_id": 123456,
                "date": 1234567890,
                "can_write": true,
                "user": {
                    "id": 123456,
                    "is_bot": false,
                    "first_name": "Test",
                    "last_name": "User",
                    "username": "testuser"
                }
            },
            "message": {
                "message_id": 1,
                "date": 1234567890,
                "chat": {
                    "id": 123456,
                    "type": "private"
                }
            }
        }
        """

        update = parse_update(json_data)

        @test update.update_id == 1
        @test update.business_connection !== nothing
        @test update.business_connection.id == "business_123"
        @test update.message !== nothing
        @test update.message.message_id == 1
    end

    # Test all fields are optional (default to nothing)
    @testset "TU-036 to TU-038: Fields are optional" begin
        # Create Update without any business fields
        update = Update(
            update_id=1,
            message=create_minimal_message()
        )

        @test update.business_connection === nothing
        @test update.business_message === nothing
        @test update.edited_business_message === nothing
    end

    # Test that update_id is always required
    @testset "TU-036 to TU-038: update_id is required" begin
        # Try to create Update without update_id (should fail or handle gracefully)
        @test_throws MethodError Update(; chat=create_minimal_chat())
    end

end
