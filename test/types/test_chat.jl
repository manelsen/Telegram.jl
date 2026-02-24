# Test Suite for Chat Type (TU-042 to TU-043)
# Tests for API 7.x business intro and location fields

using Telegram
using Test

@testset "Chat Type Tests - TU-042 to TU-043" begin

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
            sticker=PhotoSize(
                file_id="photo_123",
                file_unique_id="unique_123",
                width=100,
                height=100
            ),
            thumbnail=PhotoSize(
                file_id="thumb_123",
                file_unique_id="unique_thumb_123",
                width=100,
                height=100
            ),
            emoji="👍",
            format="static"
        )
    end

    # Helper function to create a minimal Location for testing
    function create_minimal_location()
        return Location(
            longitude=10.0,
            latitude=20.0,
            horizontal_accuracy=0.1
        )
    end

    # Helper function to create a minimal BusinessIntro for testing
    function create_minimal_business_intro()
        return BusinessIntro(
            title="Welcome to Our Business",
            message="We're open 24/7!",
            sticker=create_minimal_sticker()
        )
    end

    # Helper function to create a minimal BusinessLocation for testing
    function create_minimal_business_location()
        return BusinessLocation(
            address="123 Business Street, City",
            location=create_minimal_location()
        )
    end

    # Helper function to create a minimal Chat for testing
    function create_minimal_chat_with_photo()
        return Chat(
            id=123456,
            type="group",
            title="Test Group",
            photo=[
                PhotoSize(
                    file_id="photo_123",
                    file_unique_id="unique_123",
                    width=100,
                    height:100
                )
            ]
        )
    end

    # TU-042: Test business_intro field exists
    @testset "TU-042: business_intro field" begin
        chat = create_minimal_chat()
        intro = create_minimal_business_intro()

        # Create Chat with business_intro
        chat_with_intro = Chat(
            id=123456,
            type="group",
            business_intro=intro
        )

        @test chat_with_intro.business_intro !== nothing
        @test chat_with_intro.business_intro.title == "Welcome to Our Business"
        @test chat_with_intro.business_intro.message == "We're open 24/7!"
    end

    # TU-043: Test business_location field exists
    @testset "TU-043: business_location field" begin
        chat = create_minimal_chat()
        location = create_minimal_business_location()

        # Create Chat with business_location
        chat_with_location = Chat(
            id=123456,
            type="group",
            business_location=location
        )

        @test chat_with_location.business_location !== nothing
        @test chat_with_location.business_location.address == "123 Business Street, City"
        @test chat_with_location.business_location.location.longitude == 10.0
    end

    # Test all two new fields together
    @testset "TU-042 to TU-043: All new fields combined" begin
        chat = create_minimal_chat()
        intro = create_minimal_business_intro()
        location = create_minimal_business_location()

        # Create Chat with all new fields
        chat_combined = Chat(
            id=123456,
            type="group",
            business_intro=intro,
            business_location=location
        )

        @test chat_combined.business_intro !== nothing
        @test chat_combined.business_location !== nothing
        @test chat_combined.business_intro.title == "Welcome to Our Business"
        @test chat_combined.business_location.address == "123 Business Street, City"
    end

    # Test backward compatibility (API 6.x fields still work)
    @testset "TU-042 to TU-043: Backward compatibility" begin
        chat = create_minimal_chat_with_photo()

        # Create Chat with only API 6.x fields
        chat_old = Chat(
            id=123456,
            type="group",
            title="Test Group",
            photo=[
                PhotoSize(
                    file_id="photo_123",
                    file_unique_id="unique_123",
                    width=100,
                    height=100
                )
            ]
        )

        @test chat_old.business_intro === nothing
        @test chat_old.business_location === nothing
        @test chat_old.title == "Test Group"
        @test length(chat_old.photo) == 1
    end

    # Test JSON deserialization with new fields
    @testset "TU-042 to TU-043: JSON deserialization" begin
        json_data = """
        {
            "id": 123456,
            "type": "group",
            "title": "Business Chat",
            "business_intro": {
                "title": "Welcome!",
                "message": "Our business is open!",
                "sticker": {
                    "file_id": "sticker_123",
                    "file_unique_id": "unique_sticker_123",
                    "width": 100,
                    "height": 100,
                    "type": "regular",
                    "emoji": "👍"
                }
            },
            "business_location": {
                "address": "123 Business Rd, Tokyo",
                "location": {
                    "longitude": 139.6917,
                    "latitude": 35.6895,
                    "horizontal_accuracy": 0.1
                }
            }
        }
        """

        chat = parse_chat(json_data)

        @test chat.id == 123456
        @test chat.type == "group"
        @test chat.title == "Business Chat"
        @test chat.business_intro !== nothing
        @test chat.business_intro.title == "Welcome!"
        @test chat.business_location !== nothing
        @test chat.business_location.address == "123 Business Rd, Tokyo"
    end

    # Test all fields are optional (default to nothing)
    @testset "TU-042 to TU-043: Fields are optional" begin
        chat = create_minimal_chat()

        # Create Chat without any business fields
        chat_minimal = Chat(
            id=123456,
            type="private"
        )

        @test chat_minimal.business_intro === nothing
        @test chat_minimal.business_location === nothing
        @test chat_minimal.type == "private"
    end

    # Test BusinessIntro structure
    @testset "TU-042: BusinessIntro structure" begin
        intro = create_minimal_business_intro()

        @test intro.title == "Welcome to Our Business"
        @test intro.message == "We're open 24/7!"
        @test intro.sticker !== nothing
        @test intro.sticker.emoji == "👍"
    end

    # Test BusinessLocation structure
    @testset "TU-043: BusinessLocation structure" begin
        location = create_minimal_business_location()

        @test location.address == "123 Business Street, City"
        @test location.location !== nothing
        @test location.location.longitude == 10.0
        @test location.location.latitude == 20.0
    end

    # Test Chat with various types
    @testset "TU-042 to TU-043: Chat with different types" begin
        # Private chat
        private_chat = Chat(
            id=123456,
            type="private"
        )

        @test private_chat.business_intro === nothing
        @test private_chat.business_location === nothing

        # Group chat
        group_chat = Chat(
            id=123456,
            type="group",
            title="Test Group"
        )

        @test group_chat.business_intro === nothing
        @test group_chat.business_location === nothing

        # Supergroup chat
        supergroup_chat = Chat(
            id=123456,
            type="supergroup",
            title="Test Supergroup"
        )

        @test supergroup_chat.business_intro === nothing
        @test supergroup_chat.business_location === nothing
    end

    # Test that required fields are present
    @testset "TU-042 to TU-043: Required fields" begin
        # Chat must have id and type
        @test_throws MethodError Chat(; type="private")
        @test_throws MethodError Chat(; id=123456)

        # BusinessIntro must have title and message
        @test_throws MethodError BusinessIntro(; message="Message only")
        @test_throws MethodError BusinessIntro(; title="Title only")

        # BusinessLocation must have address
        @test_throws MethodError BusinessLocation(; location=Location(10.0, 20.0))
    end

end
