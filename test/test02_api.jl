module TestAPI
using Telegram
using Telegram.API
using Test
using JSON3
using ..TestHelpers

# Import TelegramError
using .Telegram: TelegramError

# SURF-API-001: getMe
@testset "SURF-API-001: getMe" begin
    @testset "successful getMe" begin
        responses = Dict("getMe" => get_me_response())
        tg = MockClient("test_token"; responses = responses)

        result = getMe(tg)
        @test result["is_bot"] == true
        @test result["username"] == "test_bot"
    end

    @testset "getMe with invalid token" begin
        responses = Dict("getMe" => error_response(401, "Unauthorized"))
        tg = MockClient("invalid_token"; responses = responses)

        @test_throws TelegramError getMe(tg)
    end
end

# SURF-API-002: getUpdates
@testset "SURF-API-002: getUpdates" begin
    @testset "successful getUpdates" begin
        updates = [
            Dict(
                "update_id" => 1,
                "message" => Dict(
                    "message_id" => 1,
                    "from" => Dict(
                        "id" => 123456,
                        "is_bot" => false,
                        "first_name" => "Test User"
                    ),
                    "chat" => Dict(
                        "id" => 123456,
                        "type" => "private"
                    ),
                    "date" => Int(floor(time())),
                    "text" => "Hello"
                )
            )
        ]
        responses = Dict("getUpdates" => get_updates_response(updates))
        tg = MockClient("test_token"; responses = responses)

        result = getUpdates(tg, timeout = 10)
        @test isa(result, Vector)
        @test length(result) == 1
    end

    @testset "getUpdates with large timeout" begin
        responses = Dict("getUpdates" => get_updates_response([]))
        tg = MockClient("test_token"; responses = responses)

        result = getUpdates(tg, timeout = 100)
        @test isa(result, Vector)
    end
end

# SURF-API-003: sendMessage
@testset "SURF-API-003: sendMessage" begin
    @testset "successful sendMessage" begin
        responses = Dict("sendMessage" => send_message_response(1, 123, "Hello"))
        tg = MockClient("test_token", chat_id = "123"; responses = responses)

        result = sendMessage(tg, text = "Hello")
        @test result["message_id"] == 1
    end

    @testset "sendMessage without text" begin
        responses = Dict("sendMessage" => error_response(400, "Bad Request: text is required"))
        tg = MockClient("test_token", chat_id = "123"; responses = responses)

        @test_throws TelegramError sendMessage(tg)
    end

    @testset "sendMessage with long text" begin
        responses = Dict("sendMessage" => send_message_response(1, 123, "a" ^ 4000))
        tg = MockClient("test_token", chat_id = "123"; responses = responses)

        long_text = "a" ^ 4000
        result = sendMessage(tg, text = long_text)
        @test result["message_id"] == 1
    end
end

# INV-004: Response Always Validated
@testset "INV-004: Response Validation" begin
    @testset "API returns error" begin
        responses = Dict("getMe" => error_response(500, "Internal Server Error"))
        tg = MockClient("test_token"; responses = responses)

        @test_throws TelegramError getMe(tg)
    end
end

# RF-001: API 7.0 methods
@testset "API 7.0 Methods" begin
    methods_7_0 = [
        :getMe, :getUpdates, :sendMessage, :forwardMessage,
        :sendPhoto, :sendAudio, :sendDocument, :sendVideo,
        :sendAnimation, :sendVoice, :sendVideoNote
    ]

    for method in methods_7_0
        @testset "$method exists" begin
            @test isdefined(API, method)
        end
    end
end

# RF-019 to RF-021: API 9.0-9.4 methods
@testset "API 9.x Methods" begin
    future_methods = [:getMyName, :setMyName, :getMyDescription, :setMyDescription]

    for method in future_methods
        @testset "$method exists" begin
            # These methods should exist in API 9.x
            @test isdefined(API, method)
        end
    end
end

# RF-036: API 7.2 methods
@testset "API 7.2 Methods" begin
    methods_7_2 = [
        :getBusinessConnection
    ]

    for method in methods_7_2
        @testset "$method exists" begin
            @test isdefined(API, method)
        end
    end
end

# RF-037 to RF-041: API 7.4-8.0 methods
@testset "API 7.4-8.0 Methods" begin
    methods_7_4 = [
        :refundStarPayment, :getStarTransactions,
        :sendPaidMedia,
        :createChatSubscriptionInviteLink, :editChatSubscriptionInviteLink,
        :setUserEmojiStatus,
        :verifyUser, :verifyChat, :removeUserVerification, :removeChatVerification,
        :editUserStarSubscription,
        :savePreparedInlineMessage,
        :getAvailableGifts, :sendGift, :giftPremiumSubscription
    ]

    for method in methods_7_4
        @testset "$method exists" begin
            @test isdefined(API, method)
        end
    end
end

@testset "API 9.4 Methods" begin
    @testset "getUserProfileAudios" begin
        @testset "successful getUserProfileAudios" begin
            responses = Dict("getUserProfileAudios" => Dict("total_count" => 2, "audios" => [Dict("file_id" => "audio_file_1", "file_unique_id" => "unique_1"), Dict("file_id" => "audio_file_2", "file_unique_id" => "unique_2")]))
            tg = MockClient("test_token"; responses = responses)
            result = getUserProfileAudios(tg; user_id = 123456)
            @test result["total_count"] == 2
        end
    end

    @testset "setMyProfilePhoto" begin
        @testset "successful setMyProfilePhoto" begin
            responses = Dict("setMyProfilePhoto" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyProfilePhoto(tg; photo = Dict("type" => "static", "photo" => "photo_data"))
            @test result == true
        end
    end

    @testset "removeMyProfilePhoto" begin
        @testset "successful removeMyProfilePhoto" begin
            responses = Dict("removeMyProfilePhoto" => true)
            tg = MockClient("test_token"; responses = responses)
            result = removeMyProfilePhoto(tg)
            @test result == true
        end
    end

    @testset "approveSuggestedPost" begin
        @testset "successful approveSuggestedPost" begin
            responses = Dict("approveSuggestedPost" => true)
            tg = MockClient("test_token"; responses = responses)
            result = approveSuggestedPost(tg; chat_id = 123, message_id = 456)
            @test result == true
        end
    end

    @testset "declineSuggestedPost" begin
        @testset "successful declineSuggestedPost" begin
            responses = Dict("declineSuggestedPost" => true)
            tg = MockClient("test_token"; responses = responses)
            result = declineSuggestedPost(tg; chat_id = 123, message_id = 456)
            @test result == true
        end
    end

    @testset "getUserGifts" begin
        @testset "successful getUserGifts" begin
            responses = Dict("getUserGifts" => Dict("total_count" => 3, "gifts" => []))
            tg = MockClient("test_token"; responses = responses)
            result = getUserGifts(tg; user_id = 123456)
            @test result["total_count"] == 3
        end
    end

    @testset "getChatGifts" begin
        @testset "successful getChatGifts" begin
            responses = Dict("getChatGifts" => Dict("total_count" => 2, "gifts" => []))
            tg = MockClient("test_token"; responses = responses)
            result = getChatGifts(tg; chat_id = 123)
            @test result["total_count"] == 2
        end
    end

    @testset "getBusinessAccountGifts" begin
        @testset "successful getBusinessAccountGifts" begin
            responses = Dict("getBusinessAccountGifts" => Dict("total_count" => 1, "gifts" => []))
            tg = MockClient("test_token"; responses = responses)
            result = getBusinessAccountGifts(tg; business_connection_id = "conn_123")
            @test result["total_count"] == 1
        end
    end

    @testset "sendMessageDraft" begin
        @testset "successful sendMessageDraft" begin
            responses = Dict("sendMessageDraft" => true)
            tg = MockClient("test_token"; responses = responses)
            result = sendMessageDraft(tg; chat_id = 123456, message_thread_id = 1, draft_id = 1, text = "Draft message")
            @test result == true
        end
    end

    @testset "repostStory" begin
        @testset "successful repostStory" begin
            responses = Dict("repostStory" => Dict())
            tg = MockClient("test_token"; responses = responses)
            result = repostStory(tg; business_connection_id = "conn_123", from_chat_id = 123, from_story_id = 456, active_period = 86400)
            @test result isa Dict
        end
    end
end

end # module
