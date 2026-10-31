module TestVersionedAPI

using Test
using Telegram

# The version modules must refer to the *same* generated API functions,
# rather than maintain additional implementations with a divergent contract.
const VERSION_METHODS = (
    (:V70, (:setMessageReaction,)),
    (:V72, (:getBusinessConnection,)),
    (:V73, (:editMessageLiveLocation, :stopMessageLiveLocation)),
    (:V74_75, (:refundStarPayment, :getStarTransactions)),
    (:V76_77, (:sendPaidMedia, :createChatSubscriptionInviteLink, :editChatSubscriptionInviteLink)),
    (:V80, (:editUserStarSubscription, :setUserEmojiStatus, :savePreparedInlineMessage)),
    (:V82, (:verifyUser, :verifyChat, :removeUserVerification, :removeChatVerification)),
    (:V90, (:readBusinessMessage, :deleteBusinessMessages, :setBusinessAccountName,
             :setBusinessAccountUsername, :setBusinessAccountBio, :setBusinessAccountProfilePhoto,
             :removeBusinessAccountProfilePhoto, :setBusinessAccountGiftSettings,
             :getBusinessAccountStarBalance, :transferBusinessAccountStars,
             :getBusinessAccountGifts, :convertGiftToStars, :upgradeGift,
             :transferGift, :postStory, :editStory, :deleteStory)),
    (:V91, (:sendChecklist, :editMessageChecklist, :getMyStarBalance)),
    (:V93, (:sendMessageDraft, :getUserGifts, :getChatGifts)),
    (:V94, (:setMyProfilePhoto, :removeMyProfilePhoto, :getUserProfileAudios)),
)

@testset "Versioned API compatibility" begin
    count = 0
    for (version, methods) in VERSION_METHODS
        namespace = getproperty(Telegram, version)
        for method in methods
            @test isdefined(namespace, method)
            @test getproperty(namespace, method) === getproperty(Telegram.API, method)
            count += 1
        end
    end
    @test count == 42

    @testset "all wrappers use the same keyword parameter contract" begin
        captured = Ref{Any}(nothing)
        query_func = (client, method, params) -> begin
            captured[] = (method, copy(params))
            return true
        end
        client = Telegram.TelegramClient("synthetic"; query_func,
                                         use_globally = false,
                                         enable_traceability = false)
        @test Telegram.V70.setMessageReaction(client; chat_id = 123,
            message_id = 456, reaction = [Dict("type" => "emoji", "emoji" => "👍")]) === true
        @test captured[][1] == "setMessageReaction"
        @test captured[][2][:chat_id] == 123
        @test captured[][2][:message_id] == 456
        @test captured[][2][:reaction][1]["emoji"] == "👍"

        @test Telegram.V90.readBusinessMessage(client; business_connection_id = "conn",
            chat_id = 123, message_id = 456) === true
        @test captured[][1] == "readBusinessMessage"
        @test captured[][2][:business_connection_id] == "conn"
    end
end

end # module TestVersionedAPI
