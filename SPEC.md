# SPECIFICATION - Telegram.jl API 7.x Update

## Document Information
- **Project**: Telegram.jl
- **Target Version**: API 7.x (7.0 through 7.11)
- **Date**: 2025-02-23
- **Status**: In Progress

---

## 1. API VERSIONS COVERED

### Bot API 7.0 (December 2023)
Base for major restructuring.

### Bot API 7.1 (February 2024)
Mini App improvements and reactions.

### Bot API 7.2 (March 2024)
**Business Accounts Integration** (Major Feature)
- BusinessConnection class
- Business account message handling
- New methods with business_connection_id parameter

### Bot API 7.3 (May 2024)
- ChatBackground support
- Poll improvements (question_entities, text_entities)
- Live location indefinite editing
- ChatFullInfo split from Chat

### Bot API 7.4 (May 2024)
**Telegram Stars Payments** (Major Feature)
- New currency "XTR"
- Star payments support
- Message effects
- Caption above media option
- Expandable blockquote entities

### Bot API 7.5 (June 2024)
- StarTransactions support
- getStarTransactions method
- Business account message editing

### Bot API 7.6 (July 2024)
**Paid Media** (Major Feature)
- PaidMedia classes
- sendPaidMedia method
- InputPaidMedia types

### Bot API 7.7 (July 2024)
- RefundedPayment class
- WebApp vertical swipe controls

### Bot API 7.8 (August 2024)
- Main Mini App support
- shareToStory for WebApps

### Bot API 7.9 (August 2024)
**Super Channels** (Major Feature)
- Channel messages with user/channel senders
- Paid media to any chat
- Subscription invite links
- createChatSubscriptionInviteLink
- ReactionTypePaid

### Bot API 7.10 (September 2024)
- PaidMediaPurchased updates
- payload parameter for sendPaidMedia
- Star giveaways

### Bot API 7.11 (October 2024)
- CopyTextButton class
- allow_paid_broadcast parameter
- TransactionPartnerTelegramApi

---

## 2. NEW METHODS TO ADD

### Business Account Methods
1. `getBusinessConnection(business_connection_id)`

### Telegram Stars Methods
2. `refundStarPayment(user_id, telegram_payment_charge_id)`
3. `getStarTransactions(offset, limit)`

### Paid Media Methods
4. `sendPaidMedia(chat_id, star_count, media, [caption], [payload], [business_connection_id])`

### Subscription Methods
5. `createChatSubscriptionInviteLink(chat_id, subscription_period, subscription_price, [name])`
6. `editChatSubscriptionInviteLink(chat_id, invite_link, [name])`

### WebApp/Bot Methods
7. `setUserEmojiStatus(user_id, emoji_status_custom_emoji_id, [emoji_status_expiration_date])`

---

## 3. MODIFIED EXISTING METHODS

### Methods with new `business_connection_id` parameter:
- sendMessage
- sendPhoto
- sendVideo
- sendAnimation
- sendAudio
- sendDocument
- sendSticker
- sendVideoNote
- sendVoice
- sendLocation
- sendVenue
- sendContact
- sendPoll
- sendDice
- sendGame
- sendMediaGroup
- sendChatAction
- editMessageText
- editMessageMedia
- editMessageCaption
- editMessageLiveLocation
- stopMessageLiveLocation
- editMessageReplyMarkup
- stopPoll
- pinChatMessage
- unpinChatMessage

### Methods with new parameters:
- `sendInvoice`: provider_token now optional for XTR
- `createInvoiceLink`: subscription_period, business_connection_id
- `sendPoll`: question_parse_mode, question_entities
- `editMessageLiveLocation`: live_period
- `sendAnimation`: show_caption_above_media
- `sendPhoto`: show_caption_above_media, message_effect_id
- `sendVideo`: show_caption_above_media, message_effect_id, cover, start_timestamp
- `copyMessage`: show_caption_above_media, message_effect_id, video_start_timestamp
- `editMessageCaption`: show_caption_above_media
- `forwardMessage`: message_effect_id, video_start_timestamp

---

## 4. NEW TYPES/CLASSES

### Business Account Types
- `BusinessConnection`
- `BusinessIntro`
- `BusinessLocation`
- `BusinessOpeningHours`
- `BusinessOpeningHoursInterval`
- `BusinessMessagesDeleted`

### Telegram Stars Types
- `StarTransactions`
- `StarTransaction`
- `TransactionPartner` (abstract)
- `TransactionPartnerUser`
- `TransactionPartnerChat`
- `TransactionPartnerTelegramAds`
- `TransactionPartnerTelegramApi`
- `TransactionPartnerAffiliateProgram`
- `RevenueWithdrawalState`
- `StarAmount`

### Paid Media Types
- `PaidMedia` (abstract)
- `PaidMediaInfo`
- `PaidMediaPreview`
- `PaidMediaPhoto`
- `PaidMediaVideo`
- `PaidMediaPurchased`
- `InputPaidMedia`
- `InputPaidMediaPhoto`
- `InputPaidMediaVideo`

### Payment Types
- `RefundedPayment`
- `SuccessfulPayment` (modified: subscription_expiration_date, is_recurring, is_first_recurring)

### Chat Types
- `ChatFullInfo` (split from Chat)
- `ChatBackground`
- `BackgroundType`
- `BackgroundFill`

### Poll Types
- `InputPollOption`

### Reaction Types
- `ReactionTypePaid`

### Button Types
- `CopyTextButton`

### Affiliate Types
- `AffiliateInfo`

---

## 5. MODIFIED EXISTING TYPES

### Message
New fields:
- `business_connection_id`
- `sender_business_bot`
- `paid_media`
- `refunded_payment`
- `effect_id`
- `paid_star_count`

### Update
New fields:
- `business_connection`
- `business_message`
- `edited_business_message`
- `deleted_business_messages`
- `purchased_paid_media`

### Chat
New fields:
- `business_intro`
- `business_location`
- `business_opening_hours`

### ChatFullInfo (formerly Chat via getChat)
New fields:
- `max_reaction_count`
- `can_send_paid_media`

### Poll
New fields:
- `question_entities`

### PollOption
New fields:
- `text_entities`

### User
New fields:
- `has_main_web_app`

### ChatMemberMember
New fields:
- `until_date` (for subscriptions)

### ChatInviteLink
New fields:
- `subscription_period`
- `subscription_price`

### InlineKeyboardButton
New fields:
- `copy_text`

### TransactionPartnerUser
New fields:
- `invoice_payload`
- `subscription_period`
- `premium_subscription_duration`
- `transaction_type`
- `gift`
- `paid_media`
- `affiliate`

### InputSticker
Modified:
- Added `format` field
- Removed sticker_format from createNewStickerSet

### StickerSet
Modified:
- Removed `is_animated` and `is_video` fields

### Various InputMedia and InlineQueryResult types
Added:
- `show_caption_above_media`

---

## 6. ARCHITECTURAL DECISIONS

### 6.1 Type Safety
- Abstract types for PaidMedia, TransactionPartner, RevenueWithdrawalState, BackgroundType, BackgroundFill
- Use Union types where appropriate

### 6.2 Parameter Handling
- Optional parameters as keyword arguments with defaults
- Nullable types for optional fields

### 6.3 Documentation Format
Follow existing pattern:
```julia
(:methodName, """
    methodName([tg::TelegramClient]; kwargs...)

Description...

# Required arguments
- `param`: (Type) Description

# Optional arguments
- `param`: (Type) Description

[Function documentation source](https://core.telegram.org/bots/api#methodname)
""")
```

### 6.4 Business Connection ID Pattern
Add to all relevant methods:
```julia
params[:business_connection_id] = get(params, :business_connection_id, nothing)
```

---

## 7. TESTING REQUIREMENTS

### 7.1 Unit Tests
- Test each new method signature
- Test parameter serialization
- Test type definitions

### 7.2 Integration Tests
- Mock API responses for new methods
- Test business connection flow
- Test star payment flow

### 7.3 Regression Tests
- Ensure existing methods still work
- Verify backward compatibility

---

## 8. IMPLEMENTATION PRIORITY

### Phase 1: Critical (Must Have)
1. All new methods
2. Modified method signatures
3. New parameter additions

### Phase 2: Important (Should Have)
1. New type definitions
2. Documentation updates

### Phase 3: Nice to Have
1. Advanced type safety
2. Additional convenience methods

---

## 9. DOCUMENTATION REFERENCES

- Telegram Bot API: https://core.telegram.org/bots/api
- Changelog: https://core.telegram.org/bots/api-changelog
- Mini Apps: https://core.telegram.org/bots/webapps
