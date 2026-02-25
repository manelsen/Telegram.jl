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

# RF-040: API 8.2 methods
@testset "API 8.2 Methods" begin
    @testset "verifyUser" begin
        @testset "successful verifyUser" begin
            responses = Dict("verifyUser" => true)
            tg = MockClient("test_token"; responses = responses)
            result = verifyUser(tg; user_id = 123456)
            @test result == true
        end

        @testset "verifyUser with organization" begin
            responses = Dict("verifyUser" => true)
            tg = MockClient("test_token"; responses = responses)
            result = verifyUser(tg; user_id = 123456, organization_id = "org_123")
            @test result == true
        end

        @testset "verifyUser with invalid user" begin
            responses = Dict("verifyUser" => error_response(400, "Bad Request: user not found"))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError verifyUser(tg; user_id = 999999)
        end
    end

    @testset "verifyChat" begin
        @testset "successful verifyChat" begin
            responses = Dict("verifyChat" => true)
            tg = MockClient("test_token"; responses = responses)
            result = verifyChat(tg; chat_id = 123)
            @test result == true
        end

        @testset "verifyChat with organization" begin
            responses = Dict("verifyChat" => true)
            tg = MockClient("test_token"; responses = responses)
            result = verifyChat(tg; chat_id = 123, organization_id = "org_123")
            @test result == true
        end

        @testset "verifyChat with invalid chat" begin
            responses = Dict("verifyChat" => error_response(400, "Bad Request: chat not found"))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError verifyChat(tg; chat_id = 999999)
        end
    end

    @testset "removeUserVerification" begin
        @testset "successful removeUserVerification" begin
            responses = Dict("removeUserVerification" => true)
            tg = MockClient("test_token"; responses = responses)
            result = removeUserVerification(tg; user_id = 123456)
            @test result == true
        end

        @testset "removeUserVerification with invalid user" begin
            responses = Dict("removeUserVerification" => error_response(400, "Bad Request: user not verified"))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError removeUserVerification(tg; user_id = 123456)
        end
    end

    @testset "removeChatVerification" begin
        @testset "successful removeChatVerification" begin
            responses = Dict("removeChatVerification" => true)
            tg = MockClient("test_token"; responses = responses)
            result = removeChatVerification(tg; chat_id = 123)
            @test result == true
        end

        @testset "removeChatVerification with invalid chat" begin
            responses = Dict("removeChatVerification" => error_response(400, "Bad Request: chat not verified"))
            tg = MockClient("test_token"; responses = responses)
            @test_throws TelegramError removeChatVerification(tg; chat_id = 123)
        end
    end
end

# RF-041: API 9.x-Additional methods
@testset "API 9.x Additional Methods" begin
    @testset "getMyName" begin
        @testset "successful getMyName" begin
            responses = Dict("getMyName" => Dict("first_name" => "Test Bot", "last_name" => "Bot"))
            tg = MockClient("test_token"; responses = responses)
            result = getMyName(tg)
            @test result["first_name"] == "Test Bot"
            @test result["last_name"] == "Bot"
        end
    end

    @testset "setMyName" begin
        @testset "successful setMyName" begin
            responses = Dict("setMyName" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyName(tg; first_name = "Updated", last_name = "Bot")
            @test result == true
        end

        @testset "setMyName with only first_name" begin
            responses = Dict("setMyName" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyName(tg; first_name = "Updated")
            @test result == true
        end
    end

    @testset "getMyDescription" begin
        @testset "successful getMyDescription" begin
            responses = Dict("getMyDescription" => Dict("description" => "Test bot description"))
            tg = MockClient("test_token"; responses = responses)
            result = getMyDescription(tg)
            @test result["description"] == "Test bot description"
        end
    end

    @testset "setMyDescription" begin
        @testset "successful setMyDescription" begin
            responses = Dict("setMyDescription" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyDescription(tg; description = "Updated description")
            @test result == true
        end

        @testset "setMyDescription with empty string" begin
            responses = Dict("setMyDescription" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyDescription(tg; description = "")
            @test result == true
        end
    end
end

# RF-042: Additional basic methods
@testset "Additional Basic Methods" begin
    @testset "setWebhook" begin
        @testset "successful setWebhook" begin
            responses = Dict("setWebhook" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setWebhook(tg; url = "https://example.com/webhook")
            @test result == true
        end

        @testset "setWebhook with certificate" begin
            responses = Dict("setWebhook" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setWebhook(tg; url = "https://example.com/webhook", certificate = "cert_data")
            @test result == true
        end
    end

    @testset "deleteWebhook" begin
        @testset "successful deleteWebhook" begin
            responses = Dict("deleteWebhook" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteWebhook(tg)
            @test result == true
        end
    end

    @testset "getWebhookInfo" begin
        @testset "successful getWebhookInfo" begin
            responses = Dict("getWebhookInfo" => Dict(
                "url" => "https://example.com/webhook",
                "has_custom_certificate" => false,
                "pending_update_count" => 0
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getWebhookInfo(tg)
            @test result["url"] == "https://example.com/webhook"
            @test result["pending_update_count"] == 0
        end
    end

    @testset "logOut" begin
        @testset "successful logOut" begin
            responses = Dict("logOut" => true)
            tg = MockClient("test_token"; responses = responses)
            result = logOut(tg)
            @test result == true
        end
    end

    @testset "closeBot" begin
        @testset "successful closeBot" begin
            responses = Dict("close" => true)
            tg = MockClient("test_token"; responses = responses)
            result = API.close(tg)
            @test result == true
        end
    end

    @testset "forwardMessage" begin
        @testset "successful forwardMessage" begin
            responses = Dict("forwardMessage" => Dict(
                "message_id" => 123,
                "from" => Dict("id" => 456, "is_bot" => false, "first_name" => "User"),
                "chat" => Dict("id" => 789, "type" => "private"),
                "date" => Int(floor(time()))
            ))
            tg = MockClient("test_token"; responses = responses)
            result = forwardMessage(tg; chat_id = 789, from_chat_id = 456, message_id = 123)
            @test result["message_id"] == 123
        end

        @testset "forwardMessage with disable_notification" begin
            responses = Dict("forwardMessage" => Dict("message_id" => 124))
            tg = MockClient("test_token"; responses = responses)
            result = forwardMessage(tg; chat_id = 789, from_chat_id = 456, message_id = 123, disable_notification = true)
            @test result["message_id"] == 124
        end
    end

    @testset "copyMessage" begin
        @testset "successful copyMessage" begin
            responses = Dict("copyMessage" => Dict("message_id" => 125))
            tg = MockClient("test_token"; responses = responses)
            result = copyMessage(tg; chat_id = 789, from_chat_id = 456, message_id = 123)
            @test result["message_id"] == 125
        end
    end

    @testset "sendPhoto" begin
        @testset "successful sendPhoto" begin
            responses = Dict("sendPhoto" => Dict(
                "message_id" => 126,
                "photo" => [Dict("file_id" => "photo_123")]
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPhoto(tg; chat_id = 123, photo = "photo_file_id")
            @test result["message_id"] == 126
        end
    end

    @testset "sendDocument" begin
        @testset "successful sendDocument" begin
            responses = Dict("sendDocument" => Dict(
                "message_id" => 127,
                "document" => Dict("file_id" => "doc_123")
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendDocument(tg; chat_id = 123, document = "doc_file_id")
            @test result["message_id"] == 127
        end
    end

    @testset "sendVideo" begin
        @testset "successful sendVideo" begin
            responses = Dict("sendVideo" => Dict(
                "message_id" => 128,
                "video" => Dict("file_id" => "video_123")
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendVideo(tg; chat_id = 123, video = "video_file_id")
            @test result["message_id"] == 128
        end
    end

    @testset "sendPoll" begin
        @testset "successful sendPoll" begin
            responses = Dict("sendPoll" => Dict(
                "message_id" => 129,
                "poll" => Dict("id" => "poll_123", "question" => "Test?")
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendPoll(tg; chat_id = 123, question = "Test?", options = ["Yes", "No"])
            @test result["message_id"] == 129
        end
    end

    @testset "sendDice" begin
        @testset "successful sendDice" begin
            responses = Dict("sendDice" => Dict(
                "message_id" => 130,
                "dice" => Dict("value" => 6, "emoji" => "🎲")
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendDice(tg; chat_id = 123)
            @test result["message_id"] == 130
        end
    end
end

# RF-043: Chat management methods
@testset "Chat Management Methods" begin
    @testset "getChat" begin
        @testset "successful getChat" begin
            responses = Dict("getChat" => Dict(
                "id" => 123,
                "type" => "private",
                "first_name" => "John",
                "last_name" => "Doe"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getChat(tg; chat_id = 123)
            @test result["id"] == 123
            @test result["type"] == "private"
        end
    end

    @testset "getChatAdministrators" begin
        @testset "successful getChatAdministrators" begin
            responses = Dict("getChatAdministrators" => [
                Dict("user" => Dict("id" => 1, "first_name" => "Admin"), "status" => "creator")
            ])
            tg = MockClient("test_token"; responses = responses)
            result = getChatAdministrators(tg; chat_id = 123)
            @test length(result) == 1
            @test result[1]["status"] == "creator"
        end
    end

    @testset "getChatMemberCount" begin
        @testset "successful getChatMemberCount" begin
            responses = Dict("getChatMemberCount" => 100)
            tg = MockClient("test_token"; responses = responses)
            result = getChatMemberCount(tg; chat_id = 123)
            @test result == 100
        end
    end

    @testset "getChatMember" begin
        @testset "successful getChatMember" begin
            responses = Dict("getChatMember" => Dict(
                "user" => Dict("id" => 123, "first_name" => "User"),
                "status" => "member"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getChatMember(tg; chat_id = 123, user_id = 123)
            @test result["status"] == "member"
        end
    end

    @testset "exportChatInviteLink" begin
        @testset "successful exportChatInviteLink" begin
            responses = Dict("exportChatInviteLink" => "https://t.me/+abc123")
            tg = MockClient("test_token"; responses = responses)
            result = exportChatInviteLink(tg; chat_id = 123)
            @test result == "https://t.me/+abc123"
        end
    end

    @testset "createChatInviteLink" begin
        @testset "successful createChatInviteLink" begin
            responses = Dict("createChatInviteLink" => Dict(
                "invite_link" => "https://t.me/+xyz789",
                "creator" => Dict("id" => 1),
                "creates_join_request" => false
            ))
            tg = MockClient("test_token"; responses = responses)
            result = createChatInviteLink(tg; chat_id = 123)
            @test result["invite_link"] == "https://t.me/+xyz789"
        end
    end

    @testset "editChatInviteLink" begin
        @testset "successful editChatInviteLink" begin
            responses = Dict("editChatInviteLink" => Dict(
                "invite_link" => "https://t.me/+xyz789",
                "name" => "Updated"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editChatInviteLink(tg; chat_id = 123, invite_link = "https://t.me/+xyz789", name = "Updated")
            @test result["name"] == "Updated"
        end
    end

    @testset "revokeChatInviteLink" begin
        @testset "successful revokeChatInviteLink" begin
            responses = Dict("revokeChatInviteLink" => Dict(
                "invite_link" => "https://t.me/+revoked",
                "is_revoked" => true
            ))
            tg = MockClient("test_token"; responses = responses)
            result = revokeChatInviteLink(tg; chat_id = 123, invite_link = "https://t.me/+revoked")
            @test result["is_revoked"] == true
        end
    end
end

# RF-044: Query methods
@testset "Query Methods" begin
    @testset "answerCallbackQuery" begin
        @testset "successful answerCallbackQuery" begin
            responses = Dict("answerCallbackQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerCallbackQuery(tg; callback_query_id = "query_123")
            @test result == true
        end

        @testset "answerCallbackQuery with show_alert" begin
            responses = Dict("answerCallbackQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerCallbackQuery(tg; callback_query_id = "query_123", show_alert = true, text = "Alert!")
            @test result == true
        end
    end

    @testset "answerInlineQuery" begin
        @testset "successful answerInlineQuery" begin
            responses = Dict("answerInlineQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerInlineQuery(tg; inline_query_id = "inline_123", results = [])
            @test result == true
        end
    end

    @testset "answerPreCheckoutQuery" begin
        @testset "successful answerPreCheckoutQuery" begin
            responses = Dict("answerPreCheckoutQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerPreCheckoutQuery(tg; pre_checkout_query_id = "pre_123", ok = true)
            @test result == true
        end

        @testset "answerPreCheckoutQuery with error" begin
            responses = Dict("answerPreCheckoutQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerPreCheckoutQuery(tg; pre_checkout_query_id = "pre_123", ok = false, error_message = "Out of stock")
            @test result == true
        end
    end

    @testset "answerShippingQuery" begin
        @testset "successful answerShippingQuery" begin
            responses = Dict("answerShippingQuery" => true)
            tg = MockClient("test_token"; responses = responses)
            result = answerShippingQuery(tg; shipping_query_id = "ship_123", ok = true, shipping_options = [])
            @test result == true
        end
    end
end

# RF-045: Member and forum methods
@testset "Member and Forum Methods" begin
    @testset "banChatMember" begin
        @testset "successful banChatMember" begin
            responses = Dict("banChatMember" => true)
            tg = MockClient("test_token"; responses = responses)
            result = banChatMember(tg; chat_id = 123, user_id = 456)
            @test result == true
        end

        @testset "banChatMember with until_date" begin
            responses = Dict("banChatMember" => true)
            tg = MockClient("test_token"; responses = responses)
            result = banChatMember(tg; chat_id = 123, user_id = 456, until_date = 1700000000)
            @test result == true
        end
    end

    @testset "unbanChatMember" begin
        @testset "successful unbanChatMember" begin
            responses = Dict("unbanChatMember" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unbanChatMember(tg; chat_id = 123, user_id = 456)
            @test result == true
        end
    end

    @testset "restrictChatMember" begin
        @testset "successful restrictChatMember" begin
            responses = Dict("restrictChatMember" => true)
            tg = MockClient("test_token"; responses = responses)
            result = restrictChatMember(tg; chat_id = 123, user_id = 456, permissions = Dict())
            @test result == true
        end
    end

    @testset "promoteChatMember" begin
        @testset "successful promoteChatMember" begin
            responses = Dict("promoteChatMember" => true)
            tg = MockClient("test_token"; responses = responses)
            result = promoteChatMember(tg; chat_id = 123, user_id = 456, can_post_messages = true)
            @test result == true
        end
    end

    @testset "setChatAdministratorCustomTitle" begin
        @testset "successful setChatAdministratorCustomTitle" begin
            responses = Dict("setChatAdministratorCustomTitle" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatAdministratorCustomTitle(tg; chat_id = 123, user_id = 456, custom_title = "Moderator")
            @test result == true
        end
    end

    @testset "pinChatMessage" begin
        @testset "successful pinChatMessage" begin
            responses = Dict("pinChatMessage" => true)
            tg = MockClient("test_token"; responses = responses)
            result = pinChatMessage(tg; chat_id = 123, message_id = 456)
            @test result == true
        end

        @testset "pinChatMessage with disable_notification" begin
            responses = Dict("pinChatMessage" => true)
            tg = MockClient("test_token"; responses = responses)
            result = pinChatMessage(tg; chat_id = 123, message_id = 456, disable_notification = true)
            @test result == true
        end
    end

    @testset "unpinChatMessage" begin
        @testset "successful unpinChatMessage" begin
            responses = Dict("unpinChatMessage" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unpinChatMessage(tg; chat_id = 123, message_id = 456)
            @test result == true
        end
    end

    @testset "unpinAllChatMessages" begin
        @testset "successful unpinAllChatMessages" begin
            responses = Dict("unpinAllChatMessages" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unpinAllChatMessages(tg; chat_id = 123)
            @test result == true
        end
    end

    @testset "leaveChat" begin
        @testset "successful leaveChat" begin
            responses = Dict("leaveChat" => true)
            tg = MockClient("test_token"; responses = responses)
            result = leaveChat(tg; chat_id = 123)
            @test result == true
        end
    end
end

# RF-046: Chat settings and message editing
@testset "Chat Settings and Message Editing" begin
    @testset "setChatTitle" begin
        @testset "successful setChatTitle" begin
            responses = Dict("setChatTitle" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatTitle(tg; chat_id = 123, title = "New Title")
            @test result == true
        end
    end

    @testset "setChatDescription" begin
        @testset "successful setChatDescription" begin
            responses = Dict("setChatDescription" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatDescription(tg; chat_id = 123, description = "New description")
            @test result == true
        end
    end

    @testset "editMessageText" begin
        @testset "successful editMessageText" begin
            responses = Dict("editMessageText" => Dict(
                "message_id" => 123,
                "text" => "Updated text"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageText(tg; chat_id = 123, message_id = 123, text = "Updated text")
            @test result["text"] == "Updated text"
        end

        @testset "editMessageText inline" begin
            responses = Dict("editMessageText" => Dict(
                "message_id" => 123,
                "text" => "Updated inline"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageText(tg; inline_message_id = "inline_123", text = "Updated inline")
            @test result["text"] == "Updated inline"
        end
    end

    @testset "editMessageCaption" begin
        @testset "successful editMessageCaption" begin
            responses = Dict("editMessageCaption" => Dict(
                "message_id" => 123,
                "caption" => "Updated caption"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageCaption(tg; chat_id = 123, message_id = 123, caption = "Updated caption")
            @test result["caption"] == "Updated caption"
        end
    end

    @testset "editMessageReplyMarkup" begin
        @testset "successful editMessageReplyMarkup" begin
            responses = Dict("editMessageReplyMarkup" => Dict(
                "message_id" => 123,
                "reply_markup" => Dict("inline_keyboard" => [])
            ))
            tg = MockClient("test_token"; responses = responses)
            result = editMessageReplyMarkup(tg; chat_id = 123, message_id = 123, reply_markup = Dict())
            @test result["message_id"] == 123
        end
    end

    @testset "deleteMessage" begin
        @testset "successful deleteMessage" begin
            responses = Dict("deleteMessage" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteMessage(tg; chat_id = 123, message_id = 456)
            @test result == true
        end
    end

    @testset "stopPoll" begin
        @testset "successful stopPoll" begin
            responses = Dict("stopPoll" => Dict(
                "message_id" => 123,
                "poll" => Dict("id" => "poll_123", "is_closed" => true)
            ))
            tg = MockClient("test_token"; responses = responses)
            result = stopPoll(tg; chat_id = 123, message_id = 123)
            @test result["poll"]["is_closed"] == true
        end
    end

    @testset "sendChatAction" begin
        @testset "successful sendChatAction typing" begin
            responses = Dict("sendChatAction" => true)
            tg = MockClient("test_token"; responses = responses)
            result = sendChatAction(tg; chat_id = 123, action = "typing")
            @test result == true
        end

        @testset "sendChatAction upload_photo" begin
            responses = Dict("sendChatAction" => true)
            tg = MockClient("test_token"; responses = responses)
            result = sendChatAction(tg; chat_id = 123, action = "upload_photo")
            @test result == true
        end
    end
end

# RF-047: File and game methods
@testset "File and Game Methods" begin
    @testset "getFile" begin
        @testset "successful getFile" begin
            responses = Dict("getFile" => Dict(
                "file_id" => "file_123",
                "file_unique_id" => "unique_123",
                "file_size" => 1000,
                "file_path" => "documents/file.pdf"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getFile(tg; file_id = "file_123")
            @test result["file_id"] == "file_123"
            @test result["file_size"] == 1000
        end
    end

    @testset "getUserProfilePhotos" begin
        @testset "successful getUserProfilePhotos" begin
            responses = Dict("getUserProfilePhotos" => Dict(
                "total_count" => 2,
                "photos" => [[Dict("file_id" => "photo_1")]]
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getUserProfilePhotos(tg; user_id = 123)
            @test result["total_count"] == 2
        end
    end

    @testset "getGameHighScores" begin
        @testset "successful getGameHighScores" begin
            responses = Dict("getGameHighScores" => [
                Dict("position" => 1, "score" => 100, "user" => Dict("id" => 123))
            ])
            tg = MockClient("test_token"; responses = responses)
            result = getGameHighScores(tg; user_id = 123, game_message_id = 456)
            @test length(result) == 1
            @test result[1]["score"] == 100
        end
    end
end

# RF-048: Sticker methods
@testset "Sticker Methods" begin
    @testset "getStickerSet" begin
        @testset "successful getStickerSet" begin
            responses = Dict("getStickerSet" => Dict(
                "name" => "test_set",
                "title" => "Test Sticker Set",
                "is_animated" => false,
                "is_video" => false,
                "stickers" => []
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getStickerSet(tg; name = "test_set")
            @test result["name"] == "test_set"
            @test result["title"] == "Test Sticker Set"
        end
    end

    @testset "getCustomEmojiStickers" begin
        @testset "successful getCustomEmojiStickers" begin
            responses = Dict("getCustomEmojiStickers" => [
                Dict("file_id" => "sticker_1", "custom_emoji_id" => "emoji_1")
            ])
            tg = MockClient("test_token"; responses = responses)
            result = getCustomEmojiStickers(tg; custom_emoji_ids = ["emoji_1"])
            @test length(result) == 1
        end
    end

    @testset "createNewStickerSet" begin
        @testset "successful createNewStickerSet" begin
            responses = Dict("createNewStickerSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = createNewStickerSet(tg; user_id = 123, name = "new_set", title = "New Set", png_sticker = "sticker_data", emojis = "😀")
            @test result == true
        end
    end

    @testset "addStickerToSet" begin
        @testset "successful addStickerToSet" begin
            responses = Dict("addStickerToSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = addStickerToSet(tg; user_id = 123, name = "set", png_sticker = "sticker", emojis = "😀")
            @test result == true
        end
    end

    @testset "setStickerPositionInSet" begin
        @testset "successful setStickerPositionInSet" begin
            responses = Dict("setStickerPositionInSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setStickerPositionInSet(tg; sticker = "sticker_123", position = 0)
            @test result == true
        end
    end

    @testset "deleteStickerFromSet" begin
        @testset "successful deleteStickerFromSet" begin
            responses = Dict("deleteStickerFromSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteStickerFromSet(tg; sticker = "sticker_123")
            @test result == true
        end
    end

    @testset "setStickerEmojiList" begin
        @testset "successful setStickerEmojiList" begin
            responses = Dict("setStickerEmojiList" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setStickerEmojiList(tg; sticker = "sticker_123", emoji_list = ["😀", "🎉"])
            @test result == true
        end
    end

    @testset "deleteStickerSet" begin
        @testset "successful deleteStickerSet" begin
            responses = Dict("deleteStickerSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteStickerSet(tg; name = "test_set")
            @test result == true
        end
    end
end

# RF-049: Inline query and payment methods
@testset "Inline Query and Payment Methods" begin
    @testset "answerWebAppQuery" begin
        @testset "successful answerWebAppQuery" begin
            responses = Dict("answerWebAppQuery" => Dict(
                "inline_message_id" => "inline_123"
            ))
            tg = MockClient("test_token"; responses = responses)
            result = answerWebAppQuery(tg; web_app_query_id = "query_123", result = Dict())
            @test result["inline_message_id"] == "inline_123"
        end
    end

    @testset "sendInvoice" begin
        @testset "successful sendInvoice" begin
            responses = Dict("sendInvoice" => Dict(
                "message_id" => 123,
                "invoice" => Dict("invoice_id" => "invoice_123")
            ))
            tg = MockClient("test_token"; responses = responses)
            result = sendInvoice(tg; chat_id = 123, title = "Product", description = "Desc", payload = "pay", provider_token = "token", prices = [])
            @test result["message_id"] == 123
        end
    end

    @testset "createInvoiceLink" begin
        @testset "successful createInvoiceLink" begin
            responses = Dict("createInvoiceLink" => "https://t.me/invoice/123")
            tg = MockClient("test_token"; responses = responses)
            result = createInvoiceLink(tg; title = "Product", description = "Desc", payload = "pay", provider_token = "token", prices = [])
            @test result == "https://t.me/invoice/123"
        end
    end
end

# RF-050: Forum topic methods
@testset "Forum Topic Methods" begin
    @testset "createForumTopic" begin
        @testset "successful createForumTopic" begin
            responses = Dict("createForumTopic" => Dict(
                "message_thread_id" => 123,
                "name" => "New Topic",
                "icon_color" => 7322096
            ))
            tg = MockClient("test_token"; responses = responses)
            result = createForumTopic(tg; chat_id = 123, name = "New Topic")
            @test result["message_thread_id"] == 123
        end
    end

    @testset "editForumTopic" begin
        @testset "successful editForumTopic" begin
            responses = Dict("editForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = editForumTopic(tg; chat_id = 123, message_thread_id = 456, name = "Updated Topic")
            @test result == true
        end
    end

    @testset "closeForumTopic" begin
        @testset "successful closeForumTopic" begin
            responses = Dict("closeForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = closeForumTopic(tg; chat_id = 123, message_thread_id = 456)
            @test result == true
        end
    end

    @testset "deleteForumTopic" begin
        @testset "successful deleteForumTopic" begin
            responses = Dict("deleteForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteForumTopic(tg; chat_id = 123, message_thread_id = 456)
            @test result == true
        end
    end

    @testset "unpinAllForumTopicMessages" begin
        @testset "successful unpinAllForumTopicMessages" begin
            responses = Dict("unpinAllForumTopicMessages" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unpinAllForumTopicMessages(tg; chat_id = 123, message_thread_id = 456)
            @test result == true
        end
    end

    @testset "editGeneralForumTopic" begin
        @testset "successful editGeneralForumTopic" begin
            responses = Dict("editGeneralForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = editGeneralForumTopic(tg; chat_id = 123, name = "General Topic")
            @test result == true
        end
    end

    @testset "closeGeneralForumTopic" begin
        @testset "successful closeGeneralForumTopic" begin
            responses = Dict("closeGeneralForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = closeGeneralForumTopic(tg; chat_id = 123)
            @test result == true
        end
    end

    @testset "hideGeneralForumTopic" begin
        @testset "successful hideGeneralForumTopic" begin
            responses = Dict("hideGeneralForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = hideGeneralForumTopic(tg; chat_id = 123)
            @test result == true
        end
    end

    @testset "unhideGeneralForumTopic" begin
        @testset "successful unhideGeneralForumTopic" begin
            responses = Dict("unhideGeneralForumTopic" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unhideGeneralForumTopic(tg; chat_id = 123)
            @test result == true
        end
    end
end

# RF-051: Bot commands and menu methods
@testset "Bot Commands and Menu Methods" begin
    @testset "setMyCommands" begin
        @testset "successful setMyCommands" begin
            responses = Dict("setMyCommands" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyCommands(tg; commands = [Dict("command" => "start", "description" => "Start")])
            @test result == true
        end
    end

    @testset "getMyCommands" begin
        @testset "successful getMyCommands" begin
            responses = Dict("getMyCommands" => [
                Dict("command" => "start", "description" => "Start the bot")
            ])
            tg = MockClient("test_token"; responses = responses)
            result = getMyCommands(tg)
            @test length(result) == 1
            @test result[1]["command"] == "start"
        end
    end

    @testset "deleteMyCommands" begin
        @testset "successful deleteMyCommands" begin
            responses = Dict("deleteMyCommands" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteMyCommands(tg)
            @test result == true
        end
    end

    @testset "getMyDefaultAdministratorRights" begin
        @testset "successful getMyDefaultAdministratorRights" begin
            responses = Dict("getMyDefaultAdministratorRights" => Dict(
                "can_manage_chat" => true
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getMyDefaultAdministratorRights(tg)
            @test result["can_manage_chat"] == true
        end
    end

    @testset "setMyDefaultAdministratorRights" begin
        @testset "successful setMyDefaultAdministratorRights" begin
            responses = Dict("setMyDefaultAdministratorRights" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setMyDefaultAdministratorRights(tg; rights = Dict("can_manage_chat" => true))
            @test result == true
        end
    end
end

# RF-052: Chat photo and sticker set methods
@testset "Chat Photo and Sticker Set Methods" begin
    @testset "setChatPhoto" begin
        @testset "successful setChatPhoto" begin
            responses = Dict("setChatPhoto" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatPhoto(tg; chat_id = 123, photo = "photo_data")
            @test result == true
        end
    end

    @testset "deleteChatPhoto" begin
        @testset "successful deleteChatPhoto" begin
            responses = Dict("deleteChatPhoto" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteChatPhoto(tg; chat_id = 123)
            @test result == true
        end
    end

    @testset "setChatStickerSet" begin
        @testset "successful setChatStickerSet" begin
            responses = Dict("setChatStickerSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatStickerSet(tg; chat_id = 123, sticker_set_name = "myset")
            @test result == true
        end
    end

    @testset "deleteChatStickerSet" begin
        @testset "successful deleteChatStickerSet" begin
            responses = Dict("deleteChatStickerSet" => true)
            tg = MockClient("test_token"; responses = responses)
            result = deleteChatStickerSet(tg; chat_id = 123)
            @test result == true
        end
    end
end

# RF-053: Chat permissions and join methods
@testset "Chat Permissions and Join Methods" begin
    @testset "setChatPermissions" begin
        @testset "successful setChatPermissions" begin
            responses = Dict("setChatPermissions" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatPermissions(tg; chat_id = 123, permissions = Dict())
            @test result == true
        end
    end

    @testset "approveChatJoinRequest" begin
        @testset "successful approveChatJoinRequest" begin
            responses = Dict("approveChatJoinRequest" => true)
            tg = MockClient("test_token"; responses = responses)
            result = approveChatJoinRequest(tg; chat_id = 123, user_id = 456)
            @test result == true
        end
    end

    @testset "declineChatJoinRequest" begin
        @testset "successful declineChatJoinRequest" begin
            responses = Dict("declineChatJoinRequest" => true)
            tg = MockClient("test_token"; responses = responses)
            result = declineChatJoinRequest(tg; chat_id = 123, user_id = 456)
            @test result == true
        end
    end

    @testset "banChatSenderChat" begin
        @testset "successful banChatSenderChat" begin
            responses = Dict("banChatSenderChat" => true)
            tg = MockClient("test_token"; responses = responses)
            result = banChatSenderChat(tg; chat_id = 123, sender_chat_id = 456)
            @test result == true
        end
    end

    @testset "unbanChatSenderChat" begin
        @testset "successful unbanChatSenderChat" begin
            responses = Dict("unbanChatSenderChat" => true)
            tg = MockClient("test_token"; responses = responses)
            result = unbanChatSenderChat(tg; chat_id = 123, sender_chat_id = 456)
            @test result == true
        end
    end
end

# RF-054: Chat menu and reaction methods
@testset "Chat Menu and Reaction Methods" begin
    @testset "getChatMenuButton" begin
        @testset "successful getChatMenuButton" begin
            responses = Dict("getChatMenuButton" => Dict("text" => "Menu"))
            tg = MockClient("test_token"; responses = responses)
            result = getChatMenuButton(tg)
            @test result["text"] == "Menu"
        end
    end

    @testset "setChatMenuButton" begin
        @testset "successful setChatMenuButton" begin
            responses = Dict("setChatMenuButton" => true)
            tg = MockClient("test_token"; responses = responses)
            result = setChatMenuButton(tg)
            @test result == true
        end
    end
end

# RF-055: Chat boost and user boost methods
@testset "Chat Boost and User Boost Methods" begin
    @testset "getUserChatBoosts" begin
        @testset "successful getUserChatBoosts" begin
            responses = Dict("getUserChatBoosts" => Dict(
                "boosts" => []
            ))
            tg = MockClient("test_token"; responses = responses)
            result = getUserChatBoosts(tg; user_id = 123)
            @test haskey(result, "boosts")
        end
    end
end

end # module
