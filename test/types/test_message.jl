# Test Suite for Message Type (TU-039 to TU-041)
# Tests for API 7.x business connection, paid media, and gift fields

using Telegram
using Test

@testset "Message Type Tests - TU-039 to TU-041" begin

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

    # Helper function to create a minimal PhotoSize for testing
    function create_minimal_photo()
        return PhotoSize(
            file_id="photo_123",
            file_unique_id="unique_123",
            width=100,
            height=100
        )
    end

    # Helper function to create a minimal Sticker for testing
    function create_minimal_sticker()
        return Sticker(
            file_id="sticker_123",
            file_unique_id="unique_sticker_123",
            width=100,
            height=100,
            is_animated=false,
            is_video=false,
            type="regular",
            sticker=create_minimal_photo(),
            thumbnail=create_minimal_photo(),
            emoji="👍",
            format="static"
        )
    end

    # Helper function to create a minimal PaidMediaPhoto for testing
    function create_minimal_paid_media_photo()
        return PaidMediaPhoto(
            type="photo",
            photo=[create_minimal_photo()],
            thumbnail=create_minimal_photo()
        )
    end

    # Helper function to create a minimal Gift for testing
    function create_minimal_gift()
        return Gift(
            id="gift_123",
            title="Test Gift",
            description="A test gift",
            thumbnail=create_minimal_photo()
        )
    end

    # Helper function to create a minimal Message for testing
    function create_minimal_message()
        return Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            photo=[create_minimal_photo()],
            text="Test message"
        )
    end

    # TU-039: Test business_connection_id field exists
    @testset "TU-039: business_connection_id field" begin
        msg = create_minimal_message()

        # Create Message with business_connection_id
        msg_with_bc = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            business_connection_id="business_123"
        )

        @test msg_with_bc.business_connection_id == "business_123"
        @test msg_with_bc.business_connection_id !== nothing
    end

    # TU-040: Test paid_media field exists
    @testset "TU-040: paid_media field" begin
        msg = create_minimal_message()
        paid_media = create_minimal_paid_media_photo()

        # Create Message with paid_media
        msg_with_paid = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            paid_media=paid_media
        )

        @test msg_with_paid.paid_media !== nothing
        @test msg_with_paid.paid_media.paid_media[1] !== nothing
    end

    # TU-041: Test gift field exists
    @testset "TU-041: gift field" begin
        msg = create_minimal_message()
        gift = create_minimal_gift()

        # Create Message with gift
        msg_with_gift = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            gift=gift
        )

        @test msg_with_gift.gift !== nothing
        @test msg_with_gift.gift.id == "gift_123"
        @test msg_with_gift.gift.title == "Test Gift"
    end

    # Test all three new fields together
    @testset "TU-039 to TU-041: All new fields combined" begin
        msg = create_minimal_message()
        bc = create_minimal_paid_media_photo()
        gift = create_minimal_gift()

        # Create Message with all new fields
        msg_combined = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            business_connection_id="business_123",
            paid_media=bc,
            gift=gift
        )

        @test msg_combined.business_connection_id == "business_123"
        @test msg_combined.paid_media !== nothing
        @test msg_combined.gift !== nothing
        @test msg_combined.gift.id == "gift_123"
    end

    # Test backward compatibility (API 6.x fields still work)
    @testset "TU-039 to TU-041: Backward compatibility" begin
        msg = create_minimal_message()

        # Create Message with only API 6.x fields
        msg_old = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            text="Old API 6.x message"
        )

        @test msg_old.business_connection_id === nothing
        @test msg_old.paid_media === nothing
        @test msg_old.gift === nothing
        @test msg_old.text == "Old API 6.x message"
    end

    # Test JSON deserialization with new fields
    @testset "TU-039 to TU-041: JSON deserialization" begin
        json_data = """
        {
            "message_id": 1,
            "date": 1234567890,
            "chat": {
                "id": 123456,
                "type": "private"
            },
            "from": {
                "id": 123456,
                "is_bot": false,
                "first_name": "Test",
                "username": "testuser"
            },
            "business_connection_id": "business_123",
            "paid_media": {
                "type": "photo",
                "photo": [
                    {
                        "file_id": "photo_123",
                        "file_unique_id": "unique_123",
                        "width": 100,
                        "height": 100
                    }
                ],
                "thumbnail": {
                    "file_id": "thumb_123",
                    "file_unique_id": "unique_thumb_123",
                    "width": 100,
                    "height": 100
                }
            },
            "gift": {
                "id": "gift_123",
                "title": "Test Gift",
                "description": "A test gift"
            },
            "text": "Message with all new fields"
        }
        """

        msg = parse_message(json_data)

        @test msg.message_id == 1
        @test msg.business_connection_id == "business_123"
        @test msg.paid_media !== nothing
        @test msg.gift !== nothing
        @test msg.gift.id == "gift_123"
        @test msg.text == "Message with all new fields"
    end

    # Test all fields are optional (default to nothing)
    @testset "TU-039 to TU-041: Fields are optional" begin
        msg = create_minimal_message()

        # Create Message without any new fields
        msg_minimal = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            text="Minimal message"
        )

        @test msg_minimal.business_connection_id === nothing
        @test msg_minimal.paid_media === nothing
        @test msg_minimal.gift === nothing
        @test msg_minimal.text == "Minimal message"
    end

    # Test PaidMediaPhoto structure
    @testset "TU-040: PaidMediaPhoto structure" begin
        pm = create_minimal_paid_media_photo()

        @test pm.type == "photo"
        @test length(pm.photo) == 1
        @test pm.photo[1].width == 100
        @test pm.photo[1].height == 100
        @test pm.thumbnail !== nothing
    end

    # Test Gift structure
    @testset "TU-041: Gift structure" begin
        gift = create_minimal_gift()

        @test gift.id == "gift_123"
        @test gift.title == "Test Gift"
        @test gift.description == "A test gift"
        @test gift.thumbnail !== nothing
    end

    # Test that business_connection_id can be empty string
    @testset "TU-039: business_connection_id can be empty string" begin
        msg = create_minimal_message()

        msg_empty = Message(
            message_id=1,
            date=Time.now(),
            chat=create_minimal_chat(),
            from=create_minimal_user(),
            business_connection_id=""
        )

        @test msg_empty.business_connection_id == ""
    end

end
