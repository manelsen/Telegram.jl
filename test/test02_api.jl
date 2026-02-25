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
    @testset "getBusinessConnection" begin
        @testset "successful getBusinessConnection" begin
            responses = Dict("getBusinessConnection" => Dict(
                "ok" => true,
                "result" => Dict(
                    "id" => "connection_id_1",
                    "user_id" => 123456,
                    "user_chat_id" => 789,
                    "date" => Int(floor(time())),
                    "can_reply" => true,
                    "can_write" => true
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getBusinessConnection(tg; business_connection_id = "connection_id_1")
            @test result["id"] == "connection_id_1"
            @test result["user_id"] == 123456
            @test result["can_reply"] == true
        end

        @testset "getBusinessConnection with invalid business_connection_id" begin
            responses = Dict("getBusinessConnection" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: connection not found"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError getBusinessConnection(tg; business_connection_id = "invalid_id")
        end
    end
end

# RF-004: API 7.3 methods
@testset "API 7.3 Methods" begin
    @testset "editMessageLiveLocation" begin
        @testset "successful editMessageLiveLocation" begin
            responses = Dict("editMessageLiveLocation" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 456,
                    "date" => Int(floor(time())),
                    "chat" => Dict(
                        "id" => 123,
                        "type" => "private"
                    ),
                    "location" => Dict(
                        "latitude" => 37.7749,
                        "longitude" => -122.4194
                    )
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageLiveLocation(tg; chat_id = 123, message_id = 456, latitude = 37.7749, longitude = -122.4194)
            @test result["message_id"] == 456
            @test result["location"]["latitude"] == 37.7749
        end

        @testset "editMessageLiveLocation with infinite live_period (0x7FFFFFFF)" begin
            responses = Dict("editMessageLiveLocation" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 456,
                    "date" => Int(floor(time())),
                    "chat" => Dict("id" => 123, "type" => "private"),
                    "location" => Dict("latitude" => 37.7749, "longitude" => -122.4194)
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageLiveLocation(tg; chat_id = 123, message_id = 456, latitude = 37.7749, longitude = -122.4194, live_period = 0x7FFFFFFF)
            @test result["message_id"] == 456
        end

        @testset "editMessageLiveLocation with invalid message_id" begin
            responses = Dict("editMessageLiveLocation" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: message not found"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError editMessageLiveLocation(tg; chat_id = 123, message_id = 999, latitude = 37.7749, longitude = -122.4194)
        end

        @testset "editMessageLiveLocation with negative coordinates" begin
            responses = Dict("editMessageLiveLocation" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: coordinates are invalid"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError editMessageLiveLocation(tg; chat_id = 123, message_id = 456, latitude = -91.0, longitude = -122.4194)
        end

        @testset "editMessageLiveLocation with heading and proximity_alert_radius" begin
            responses = Dict("editMessageLiveLocation" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 456,
                    "date" => Int(floor(time())),
                    "chat" => Dict("id" => 123, "type" => "private"),
                    "location" => Dict("latitude" => 37.7749, "longitude" => -122.4194)
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageLiveLocation(tg; chat_id = 123, message_id = 456, latitude = 37.7749, longitude = -122.4194, heading = 90, proximity_alert_radius = 100)
            @test result["message_id"] == 456
        end
    end
end

# RF-037 to RF-038: API 7.4-7.5 methods
@testset "API 7.4-7.5 Methods" begin
    @testset "refundStarPayment" begin
        @testset "successful refundStarPayment" begin
            responses = Dict("refundStarPayment" => Dict(
                "ok" => true,
                "result" => true
            ))
            tg = MockClient("test_token"; responses = responses)
            result = refundStarPayment(tg; user_id = 123456, telegram_payment_charge_id = "charge_123")
            @test result == true
        end

        @testset "refundStarPayment with invalid charge_id" begin
            responses = Dict("refundStarPayment" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: payment not found"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError refundStarPayment(tg; user_id = 123456, telegram_payment_charge_id = "invalid_charge")
        end

        @testset "refundStarPayment with non-existent user" begin
            responses = Dict("refundStarPayment" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: user not found"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError refundStarPayment(tg; user_id = 999999, telegram_payment_charge_id = "charge_123")
        end

        @testset "refundStarPayment rate limiting" begin
            responses = Dict("refundStarPayment" => Dict(
                "ok" => false,
                "error_code" => 429,
                "description" => "Too Many Requests: retry after 10 seconds"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError refundStarPayment(tg; user_id = 123456, telegram_payment_charge_id = "charge_123")
        end
    end

    @testset "getStarTransactions" begin
        @testset "successful getStarTransactions" begin
            responses = Dict("getStarTransactions" => Dict(
                "ok" => true,
                "result" => Dict(
                    "transactions" => [
                        Dict(
                            "id" => "txn_1",
                            "amount" => 100,
                            "from_user" => Dict("id" => 123, "is_bot" => false, "first_name" => "Test User"),
                            "date" => Int(floor(time()))
                        )
                    ]
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getStarTransactions(tg)
            @test length(result["transactions"]) == 1
            @test result["transactions"][1]["id"] == "txn_1"
        end

        @testset "getStarTransactions with pagination" begin
            responses = Dict("getStarTransactions" => Dict(
                "ok" => true,
                "result" => Dict(
                    "transactions" => Any[]
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getStarTransactions(tg; offset = 10, limit = 50)
            @test result["transactions"] isa Vector
        end

        @testset "getStarTransactions with limit" begin
            responses = Dict("getStarTransactions" => Dict(
                "ok" => true,
                "result" => Dict(
                    "transactions" => Vector{Dict{String, Any}}()
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getStarTransactions(tg; limit = 50)
            @test result["transactions"] isa Vector
        end

        @testset "getStarTransactions empty result" begin
            responses = Dict("getStarTransactions" => Dict(
                "ok" => true,
                "result" => Dict(
                    "transactions" => Any[]
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getStarTransactions(tg)
            @test result["transactions"] isa Vector
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

# RF-039: API 7.6-7.7 methods
@testset "API 7.6-7.7 Methods" begin
    @testset "sendPaidMedia" begin
        @testset "successful sendPaidMedia" begin
            responses = Dict("sendPaidMedia" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 456,
                    "date" => Int(floor(time())),
                    "chat" => Dict(
                        "id" => 123,
                        "type" => "private"
                    )
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPaidMedia(tg; business_connection_id = "conn_1", star_count = 100, media = [Dict("type" => "photo", "media" => "photo_data")])
            @test result["message_id"] == 456
        end

        @testset "sendPaidMedia with chat_id" begin
            responses = Dict("sendPaidMedia" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 457,
                    "date" => Int(floor(time())),
                    "chat" => Dict("id" => 456, "type" => "channel")
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPaidMedia(tg; business_connection_id = "conn_1", star_count = 200, chat_id = "@channel", media = [Dict("type" => "video", "media" => "video_file")])
            @test result["message_id"] == 457
        end

        @testset "sendPaidMedia with caption" begin
            responses = Dict("sendPaidMedia" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 458,
                    "date" => Int(floor(time())),
                    "chat" => Dict("id" => 123, "type" => "private"),
                    "caption" => "Paid media caption"
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPaidMedia(tg; business_connection_id = "conn_1", star_count = 150, media = [Dict("type" => "photo", "media" => "photo_data", "caption" => "Caption")])
            @test result["caption"] == "Paid media caption"
        end

        @testset "sendPaidMedia with insufficient stars" begin
            responses = Dict("sendPaidMedia" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: insufficient star balance"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError sendPaidMedia(tg; business_connection_id = "conn_1", star_count = 999999999, media = [Dict("type" => "photo", "media" => "photo_data")])
        end

        @testset "sendPaidMedia with multiple media" begin
            responses = Dict("sendPaidMedia" => Dict(
                "ok" => true,
                "result" => Dict(
                    "message_id" => 459,
                    "date" => Int(floor(time())),
                    "chat" => Dict("id" => 123, "type" => "private"),
                    "media_group_id" => "group_1"
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPaidMedia(tg; business_connection_id = "conn_1", star_count = 300, media = [
                Dict("type" => "photo", "media" => "photo1"),
                Dict("type" => "photo", "media" => "photo2")
            ])
            @test result["media_group_id"] == "group_1"
        end
    end

    @testset "createChatSubscriptionInviteLink" begin
        @testset "successful createChatSubscriptionInviteLink" begin
            responses = Dict("createChatSubscriptionInviteLink" => Dict(
                "ok" => true,
                "result" => Dict(
                    "invite_link" => "https://t.me/+abc123",
                    "creator" => Dict("id" => 123, "is_bot" => false, "first_name" => "User"),
                    "creates_join_request" => false,
                    "is_primary" => false,
                    "is_revoked" => false,
                    "subscription_period" => 2592000,
                    "subscription_price" => 50
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = createChatSubscriptionInviteLink(tg; chat_id = 123, subscription_period = 2592000, subscription_price = 50)
            @test result["subscription_period"] == 2592000
            @test result["subscription_price"] == 50
        end

        @testset "createChatSubscriptionInviteLink with name" begin
            responses = Dict("createChatSubscriptionInviteLink" => Dict(
                "ok" => true,
                "result" => Dict(
                    "invite_link" => "https://t.me/+xyz789",
                    "name" => "Premium Subscription",
                    "subscription_period" => 604800,
                    "subscription_price" => 100
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = createChatSubscriptionInviteLink(tg; chat_id = "@channel", subscription_period = 604800, subscription_price = 100, name = "Premium Subscription")
            @test result["name"] == "Premium Subscription"
        end
    end

    @testset "editChatSubscriptionInviteLink" begin
        @testset "successful editChatSubscriptionInviteLink" begin
            responses = Dict("editChatSubscriptionInviteLink" => Dict(
                "ok" => true,
                "result" => Dict(
                    "invite_link" => "https://t.me/+abc123",
                    "creator" => Dict("id" => 123, "is_bot" => false, "first_name" => "User"),
                    "subscription_period" => 5184000,
                    "subscription_price" => 75
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editChatSubscriptionInviteLink(tg; invite_link = "https://t.me/+abc123", subscription_period = 5184000, subscription_price = 75)
            @test result["subscription_period"] == 5184000
            @test result["subscription_price"] == 75
        end

        @testset "editChatSubscriptionInviteLink with invalid link" begin
            responses = Dict("editChatSubscriptionInviteLink" => Dict(
                "ok" => false,
                "error_code" => 400,
                "description" => "Bad Request: invite link not found"
            ))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError editChatSubscriptionInviteLink(tg; invite_link = "https://t.me/+invalid", subscription_price = 50)
        end

        @testset "editChatSubscriptionInviteLink change name only" begin
            responses = Dict("editChatSubscriptionInviteLink" => Dict(
                "ok" => true,
                "result" => Dict(
                    "invite_link" => "https://t.me/+abc123",
                    "name" => "Updated Name"
                )
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editChatSubscriptionInviteLink(tg; invite_link = "https://t.me/+abc123", name = "Updated Name")
            @test result["name"] == "Updated Name"
        end
    end
end

end # module
