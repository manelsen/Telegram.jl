module TestAPI7x
using Test
using Telegram
using Telegram.API
using JSON3

# Mock TelegramClient for testing
function mock_client()
    Telegram.TelegramClient("test_token"; chat_id = "123456", use_globally = false)
end

@testset "API 7.x New Methods" begin
    @testset "getBusinessConnection" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.getBusinessConnection, (Telegram.TelegramClient,))
        
        # Test that the method accepts business_connection_id parameter
        @test hasmethod(Telegram.API.getBusinessConnection, (Telegram.TelegramClient,), (:business_connection_id,))
    end
    
    @testset "refundStarPayment" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.refundStarPayment, (Telegram.TelegramClient,))
        
        # Test that the method accepts required parameters
        @test hasmethod(Telegram.API.refundStarPayment, (Telegram.TelegramClient,), (:user_id, :telegram_payment_charge_id))
    end
    
    @testset "getStarTransactions" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.getStarTransactions, (Telegram.TelegramClient,))
        
        # Test that the method accepts optional parameters
        @test hasmethod(Telegram.API.getStarTransactions, (Telegram.TelegramClient,), (:offset, :limit))
    end
    
    @testset "sendPaidMedia" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.sendPaidMedia, (Telegram.TelegramClient,))
        
        # Test that the method accepts required parameters
        @test hasmethod(Telegram.API.sendPaidMedia, (Telegram.TelegramClient,), 
            (:chat_id, :star_count, :media))
        
        # Test that the method accepts optional parameters
        @test hasmethod(Telegram.API.sendPaidMedia, (Telegram.TelegramClient,), 
            (:chat_id, :star_count, :media, :caption, :parse_mode, :show_caption_above_media))
    end
    
    @testset "createChatSubscriptionInviteLink" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.createChatSubscriptionInviteLink, (Telegram.TelegramClient,))
        
        # Test that the method accepts required parameters
        @test hasmethod(Telegram.API.createChatSubscriptionInviteLink, (Telegram.TelegramClient,), 
            (:chat_id, :subscription_period, :subscription_price))
    end
    
    @testset "editChatSubscriptionInviteLink" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.editChatSubscriptionInviteLink, (Telegram.TelegramClient,))
        
        # Test that the method accepts required parameters
        @test hasmethod(Telegram.API.editChatSubscriptionInviteLink, (Telegram.TelegramClient,), 
            (:chat_id, :invite_link))
    end
    
    @testset "setUserEmojiStatus" begin
        # Test method signature exists
        client = mock_client()
        @test hasmethod(Telegram.API.setUserEmojiStatus, (Telegram.TelegramClient,))
        
        # Test that the method accepts required parameters
        @test hasmethod(Telegram.API.setUserEmojiStatus, (Telegram.TelegramClient,), 
            (:user_id,))
    end
    
    @testset "Verification Methods" begin
        client = mock_client()
        
        @testset "verifyUser" begin
            @test hasmethod(Telegram.API.verifyUser, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.verifyUser, (Telegram.TelegramClient,), (:user_id,))
        end
        
        @testset "verifyChat" begin
            @test hasmethod(Telegram.API.verifyChat, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.verifyChat, (Telegram.TelegramClient,), (:chat_id,))
        end
        
        @testset "removeUserVerification" begin
            @test hasmethod(Telegram.API.removeUserVerification, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.removeUserVerification, (Telegram.TelegramClient,), (:user_id,))
        end
        
        @testset "removeChatVerification" begin
            @test hasmethod(Telegram.API.removeChatVerification, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.removeChatVerification, (Telegram.TelegramClient,), (:chat_id,))
        end
    end
    
    @testset "editUserStarSubscription" begin
        client = mock_client()
        @test hasmethod(Telegram.API.editUserStarSubscription, (Telegram.TelegramClient,))
        @test hasmethod(Telegram.API.editUserStarSubscription, (Telegram.TelegramClient,), 
            (:user_id, :telegram_payment_charge_id, :is_canceled))
    end
    
    @testset "savePreparedInlineMessage" begin
        client = mock_client()
        @test hasmethod(Telegram.API.savePreparedInlineMessage, (Telegram.TelegramClient,))
        @test hasmethod(Telegram.API.savePreparedInlineMessage, (Telegram.TelegramClient,), 
            (:user_id, :result))
    end
    
    @testset "Gift Methods" begin
        client = mock_client()
        
        @testset "getAvailableGifts" begin
            @test hasmethod(Telegram.API.getAvailableGifts, (Telegram.TelegramClient,))
        end
        
        @testset "sendGift" begin
            @test hasmethod(Telegram.API.sendGift, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.sendGift, (Telegram.TelegramClient,), 
                (:user_id, :gift_id))
        end
        
        @testset "giftPremiumSubscription" begin
            @test hasmethod(Telegram.API.giftPremiumSubscription, (Telegram.TelegramClient,))
            @test hasmethod(Telegram.API.giftPremiumSubscription, (Telegram.TelegramClient,), 
                (:user_id, :month_count, :star_count))
        end
    end
end

@testset "API 7.x Modified Methods" begin
    client = mock_client()
    
    @testset "sendMessage with new parameters" begin
        # Test that new parameters are supported
        @test hasmethod(Telegram.API.sendMessage, (Telegram.TelegramClient,), 
            (:chat_id, :text, :business_connection_id, :message_effect_id, :allow_paid_broadcast))
    end
    
    @testset "sendPhoto with new parameters" begin
        @test hasmethod(Telegram.API.sendPhoto, (Telegram.TelegramClient,), 
            (:chat_id, :photo, :business_connection_id, :message_effect_id, :show_caption_above_media))
    end
    
    @testset "sendVideo with new parameters" begin
        @test hasmethod(Telegram.API.sendVideo, (Telegram.TelegramClient,), 
            (:chat_id, :video, :business_connection_id, :message_effect_id, :cover, :start_timestamp))
    end
    
    @testset "copyMessage with new parameters" begin
        @test hasmethod(Telegram.API.copyMessage, (Telegram.TelegramClient,), 
            (:chat_id, :from_chat_id, :message_id, :show_caption_above_media, :video_start_timestamp))
    end
    
    @testset "forwardMessage with new parameters" begin
        @test hasmethod(Telegram.API.forwardMessage, (Telegram.TelegramClient,), 
            (:chat_id, :from_chat_id, :message_id, :message_effect_id, :video_start_timestamp))
    end
    
    @testset "createInvoiceLink with new parameters" begin
        @test hasmethod(Telegram.API.createInvoiceLink, (Telegram.TelegramClient,), 
            (:title, :description, :payload, :currency, :prices, :subscription_period, :business_connection_id))
    end
    
    @testset "sendInvoice with new parameters" begin
        @test hasmethod(Telegram.API.sendInvoice, (Telegram.TelegramClient,), 
            (:chat_id, :title, :description, :payload, :currency, :prices, :message_effect_id))
    end
end

@testset "API 7.x Method Count" begin
    # Count total methods in TELEGRAM_API
    method_count = length(Telegram.API.TELEGRAM_API)
    @test method_count >= 125  # Original 113 + at least 12 new methods from API 7.x
end

end # module
