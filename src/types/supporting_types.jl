# Supporting Types for Telegram API 7.x
# This file contains all supporting type definitions that are referenced in the main types

using JSON3

# ============== User Types ==============

"""
    User
Represents a Telegram user.
"""
mutable struct User <: BaseObjectType
    id::Int
    is_bot::Bool
    first_name::String
    last_name::Union{String, Nothing}
    username::Union{String, Nothing}
    language_code::Union{String, Nothing}
    is_premium::Bool
    added_to_attachment_menu::Bool
    can_join_groups::Bool
    can_read_all_group_messages::Bool
    supports_inline_queries::Bool
    has_main_web_app::Bool  # API 7.9+
    connectable_name::Union{String, Nothing}
end

"""
    ChatPermissions
Represents default chat permissions.
"""
mutable struct ChatPermissions <: BaseObjectType
    can_send_messages::Bool
    can_send_media_messages::Bool
    can_send_polls::Bool
    can_send_other_messages::Bool
    can_add_web_page_previews::Bool
    can_change_info::Bool
    can_invite_users::Bool
    can_pin_messages::Bool
    can_manage_topics::Bool
end

# ============== Chat Types (continued) ==============

"""
    ChatMemberUpdated
Describes changes in the status of a chat member.
"""
mutable struct ChatMemberUpdated <: BaseObjectType
    chat::Chat
    from::User
    date::Int
    old_chat_member::ChatMember
    new_chat_member::ChatMember
    invite_link::Union{ChatInviteLink, Nothing}
    via_chat_folder_invite_link::Bool
    user_chat_administrator_rights::Union{ChatAdministratorRights, Nothing}
    chat_join_by_request::Bool
    sender_boost::Union{ChatBoost, Nothing}
end

"""
    ChatAdministratorRights
Represents the rights of an administrator in a chat.
"""
mutable struct ChatAdministratorRights <: BaseObjectType
    is_anonymous::Bool
    can_manage_chat::Bool
    can_delete_messages::Bool
    can_manage_video_chats::Bool
    can_restrict_members::Bool
    can_promote_members::Bool
    can_change_info::Bool
    can_invite_users::Bool
    can_pin_messages::Bool
    can_manage_topics::Bool
    can_manage_forum_topics::Bool
    can_post_stories::Bool
    can_edit_stories::Bool
    can_delete_stories::Bool
    can_polls::Bool
    can_change_usernames::Bool
    can_manage_chat_photo::Bool
    can_manage_video_chats::Bool
    can_manage_messages::Bool
    can_use_independent_chat_permissions::Bool
end

# ============== Message Types (continued) ==============

"""
    MessageEntity
Represents one special entity in a text message.
"""
mutable struct MessageEntity <: BaseObjectType
    type::String
    offset::Int
    length::Int
    url::Union{String, Nothing}
    user::Union{User, Nothing}
    language::Union{String, Nothing}
    custom_emoji_id::Union{String, Nothing}
    # API 7.9+ support for blockquotes
    message_id::Union{Int, Nothing}
    position::Union{Int, Nothing}
end

"""
    PhotoSize
Represents a photo size.
"""
mutable struct PhotoSize <: BaseObjectType
    file_id::String
    file_unique_id::String
    width::Int
    height::Int
    file_size::Union{Int, Nothing}
end

# ============== Audio/Video Types ==============

"""
    Audio
Represents an audio file to be treated as custom by client.
"""
mutable struct Audio <: BaseObjectType
    file_id::String
    file_unique_id::String
    duration::Int
    performer::Union{String, Nothing}
    title::Union{String, Nothing}
    file_name::Union{String, Nothing}
    mime_type::Union{String, Nothing}
    file_size::Union{Int, Nothing}
    thumbnail::Union{PhotoSize, Nothing}
end

"""
    Video
Represents a video.
"""
mutable struct Video <: BaseObjectType
    file_id::String
    file_unique_id::String
    width::Int
    height::Int
    duration::Int
    supports_streaming::Bool
    mime_type::Union{String, Nothing}
    file_size::Union{Int, Nothing}
    thumb::Union{PhotoSize, Nothing}
    has_stickers::Bool
end

"""
    Document
Represents a general file.
"""
mutable struct Document <: BaseObjectType
    file_id::String
    file_unique_id::String
    thumb::Union{PhotoSize, Nothing}
    file_name::Union{String, Nothing}
    mime_type::Union{String, Nothing}
    file_size::Union{Int, Nothing}
end

"""
    Animation
Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).
"""
mutable struct Animation <: BaseObjectType
    file_id::String
    file_unique_id::String
    width::Int
    height::Int
    duration::Int
    thumb::Union{PhotoSize, Nothing}
    file_name::Union{String, Nothing}
    mime_type::Union{String, Nothing}
    file_size::Union{Int, Nothing}
end

"""
    VideoNote
Represents a video message (GIF-like format).
"""
mutable struct VideoNote <: BaseObjectType
    file_id::String
    file_unique_id::String
    length::Int
    duration::Int
    thumb::Union{PhotoSize, Nothing}
    file_size::Union{Int, Nothing}
end

"""
    Voice
Represents a voice note.
"""
mutable struct Voice <: BaseObjectType
    file_id::String
    file_unique_id::String
    duration::Int
    mime_type::Union{String, Nothing}
    file_size::Union{Int, Nothing}
end

# ============== Sticker Types ==============

"""
    Sticker
Represents a sticker.
"""
mutable struct Sticker <: BaseObjectType
    file_id::String
    file_unique_id::String
    width::Int
    height::Int
    is_animated::Bool
    is_video::Bool
    is_video_note::Bool
    type::String
    sticker::Union{PhotoSize, Animation, Video, Voice, Document, Nothing}
    premium_animation::Union{Animation, Video, Voice, Nothing}
    thumbnail::Union{PhotoSize, Nothing}
    emoji::Union{String, Nothing}
    set_name::Union{String, Nothing}
    mask_position::Union{MaskPosition, Nothing}
    file_size::Union{Int, Nothing}
    is_animations_allowed::Bool
    requires_payment::Bool
    is_premium::Bool
    speech_recognition_hint::Union{String, Nothing}
    is_custom_emoji::Bool
    format::Union{String, Nothing}
end

# ============== Poll Types ==============

"""
    Poll
Represents a poll.
"""
mutable struct Poll <: BaseObjectType
    id::String
    question::String
    options::Array{PollOption}
    total_vote_count::Int
    is_closed::Bool
    is_anonymous::Bool
    type::String
    allows_multiple_answers::Bool
    correct_option_id::Union{Int, Nothing}
    explanation::Union{String, Nothing}
    explanation_entities::Array{MessageEntity}
    open_period::Union{Int, Nothing}
    close_date::Union{Int, Nothing}
    # API 7.3+ support for question_entities
    question_entities::Array{MessageEntity}
end

"""
    PollOption
Represents an option in a poll.
"""
mutable struct PollOption <: BaseObjectType
    text::String
    voter_count::Int
    text_entities::Array{MessageEntity}
end

"""
    PollAnswer
Represents an answer of a user in a non-anonymous poll.
"""
mutable struct PollAnswer <: BaseObjectType
    poll_id::String
    user::User
    option_ids::Array{Int}
end

# ============== Location Types ==============

"""
    Location
Represents a point on the map.
"""
mutable struct Location <: BaseObjectType
    longitude::Float64
    latitude::Float64
    horizontal_accuracy::Union{Float64, Nothing}
    live_period::Union{Int, Nothing}
    heading::Union{Int, Nothing}
    proximity_alert_radius::Union{Int, Nothing}
end

"""
    Venue
Represents a venue.
"""
mutable struct Venue <: BaseObjectType
    location::Location
    title::String
    address::String
    foursquare_id::Union{String, Nothing}
    foursquare_type::Union{String, Nothing}
    google_place_id::Union{String, Nothing}
    google_place_type::Union{String, Nothing}
end

# ============== Invoice Types ==============

"""
    Invoice
Represents an invoice.
"""
mutable struct Invoice <: BaseObjectType
    title::String
    description::String
    start_parameter::String
    currency::String
    total_amount::Int
end

"""
    SuccessfulPayment
Represents an incoming paid message.
"""
mutable struct SuccessfulPayment <: BaseObjectType
    currency::String
    total_amount::Int
    invoice_payload::String
    shipping_option_id::Union{String, Nothing}
    order_info::Union{OrderInfo, Nothing}
    telegram_payment_charge_id::String
    provider_payment_charge_id::Union{String, Nothing}
    # API 7.7+ fields
    subscription_expiration_date::Union{Int, Nothing}
    is_recurring::Union{Bool, Nothing}
    is_first_recurring::Union{Bool, Nothing}
    # API 7.9+ fields
    transaction_partner::Union{TransactionPartner, Nothing}
    subscription_period::Union{Int, Nothing}
end

"""
    RefundedPayment
Represents a refunded payment.
"""
mutable struct RefundedPayment <: BaseObjectType
    currency::String
    total_amount::Int
    invoice_payload::String
    telegram_payment_charge_id::String
    provider_payment_charge_id::Union{String, Nothing}
end

"""
    OrderInfo
Represents information about an order.
"""
mutable struct OrderInfo <: BaseObjectType
    name::Union{String, Nothing}
    phone_number::Union{String, Nothing}
    email::Union{String, Nothing}
    shipping_address::Union{ShippingAddress, Nothing}
end

"""
    ShippingAddress
Represents an address of an order.
"""
mutable struct ShippingAddress <: BaseObjectType
    country_code::String
    state::String
    city::String
    street_line1::String
    street_line2::Union{String, Nothing}
    postal_code::String
end

# ============== Contact Types ==============

"""
    Contact
Represents a contact.
"""
mutable struct Contact <: BaseObjectType
    phone_number::String
    first_name::String
    last_name::Union{String, Nothing}
    user_id::Union{Int, Nothing}
    vcard::Union{String, Nothing}
end

# ============== Inline Query Types ==============

"""
    InlineQuery
Represents an incoming inline query.
"""
mutable struct InlineQuery <: BaseObjectType
    id::String
    from::User
    query::String
    offset::String
    chat_type::Union{String, Nothing}
    location::Union{Location, Nothing}
end

"""
    ChosenInlineResult
Represents a result of an inline query that was chosen by the user and sent to their chat partner.
"""
mutable struct ChosenInlineResult <: BaseObjectType
    id::String
    from::User
    query::String
    location::Union{Location, Nothing}
    inline_message_id::Union{String, Nothing}
    result_id::String
end

"""
    CallbackQuery
Represents an incoming callback query from a callback button in an inline keyboard.
"""
mutable struct CallbackQuery <: BaseObjectType
    id::String
    from::User
    message::Union{Message, Nothing}
    inline_message_id::Union{String, Nothing}
    chat_instance::String
    data::Union{String, Nothing}
    game_short_name::Union{String, Nothing}
    inline_message_text::Union{String, Nothing}
    # API 7.2+ support for business connection
    business_connection_id::Union{String, Nothing}
end

# ============== Shipping/Pre-Checkout Types ==============

"""
    ShippingQuery
Represents an incoming shipping query.
"""
mutable struct ShippingQuery <: BaseObjectType
    id::String
    from::User
    invoice_payload::String
    shipping_address::ShippingAddress
end

"""
    PreCheckoutQuery
Represents an incoming pre-checkout query.
"""
mutable struct PreCheckoutQuery <: BaseObjectType
    id::String
    from::User
    currency::String
    total_amount::Int
    invoice_payload::String
    shipping_option_id::Union{String, Nothing}
    order_info::Union{OrderInfo, Nothing}
end

# ============== Chat Types (continued) ==============

"""
    ChatInviteLink
Represents an invite link for a chat.
"""
mutable struct ChatInviteLink <: BaseObjectType
    invite_link::String
    creator_user_id::Int
    creates_join_request::Bool
    is_primary::Bool
    is_revoked::Bool
    name::Union{String, Nothing}
    expire_date::Union{Int, Nothing}
    member_limit::Union{Int, Nothing}
    pending_join_request_count::Int
    # API 7.9+ fields
    subscription_period::Union{Int, Nothing}
    subscription_price::Union{Int, Nothing}
end

"""
    ChatBoost
Represents a boost added to a chat.
"""
mutable struct ChatBoost <: BaseObjectType
    id::String
    add_date::Int
    boost_source::String
    user::User
end

# ============== Reply Markup Types ==============

"""
    InlineKeyboardMarkup
Represents an inline keyboard.
"""
mutable struct InlineKeyboardMarkup <: BaseObjectType
    inline_keyboard::Array{Array{InlineKeyboardButton}}
end

"""
    InlineKeyboardButton
Represents a button of an inline keyboard.
"""
mutable struct InlineKeyboardButton <: BaseObjectType
    text::String
    url::Union{String, Nothing}
    callback_data::Union{String, Nothing}
    web_app::Union{WebAppInfo, Nothing}
    login_url::Union{LoginUrl, Nothing}
    switch_inline_query::Union{String, Nothing}
    switch_inline_query_current_chat::Union{String, Nothing}
    callback_game::Union{CallbackGame, Nothing}
    pay::Bool
    # API 7.9+ support
    copy_text::Union{CopyTextButton, Nothing}
end

"""
    ReplyKeyboardMarkup
Represents a custom keyboard with reply options.
"""
mutable struct ReplyKeyboardMarkup <: BaseObjectType
    keyboard::Array{Array{KeyboardButton}}
    resize_keyboard::Bool
    one_time_keyboard::Bool
    selective::Bool
end

"""
    KeyboardButton
Represents a button of a reply keyboard.
"""
mutable struct KeyboardButton <: BaseObjectType
    text::String
    request_location::Bool
    request_contact::Bool
    request_poll::Union{KeyboardButtonPollType, Nothing}
    web_app::Union{WebAppInfo, Nothing}
end

"""
    KeyboardButtonPollType
Represents the type of poll to be created.
"""
mutable struct KeyboardButtonPollType <: BaseObjectType
    type::String
end

"""
    ReplyKeyboardRemove
Represents a reply keyboard removal.
"""
mutable struct ReplyKeyboardRemove <: BaseObjectType
    remove_keyboard::Bool
    selective::Bool
end

"""
    ForceReply
Represents a force reply.
"""
mutable struct ForceReply <: BaseObjectType
    force_reply::Bool
    input_field_placeholder::Union{String, Nothing}
    selective::Bool
end

# ============== Web App Types ==============

"""
    WebAppInfo
Represents information about an inline keyboard button that opens an inline mode.
"""
mutable struct WebAppInfo <: BaseObjectType
    url::String
    name::Union{String, Nothing}
    description::Union{String, Nothing}
end

"""
    LoginUrl
Represents an HTTP URL which should be opened by a Web App.
"""
mutable struct LoginUrl <: BaseObjectType
    url::String
    forward_text::Union{String, Nothing}
    bot_username::Union{String, Nothing}
    request_write_access::Bool
end

"""
    CallbackGame
Represents a parameter for a bot game.
"""
mutable struct CallbackGame <: BaseObjectType
    # Empty struct - just a placeholder
end

"""
    CopyTextButton
Represents a button which copies text to clipboard.
"""
mutable struct CopyTextButton <: BaseObjectType
    text::String
end

# ============== Payment/Partner Types ==============

"""
    TransactionPartner
Represents the partner of a transaction.
"""
abstract type TransactionPartner <: BaseObjectType end

"""
    TransactionPartnerUser
Represents a transaction partner of a user.
"""
mutable struct TransactionPartnerUser <: TransactionPartner
    user::User
    # API 7.9+ fields
    invoice_payload::Union{String, Nothing}
    subscription_period::Union{Int, Nothing}
    premium_subscription_duration::Union{Int, Nothing}
    transaction_type::Union{String, Nothing}
    gift::Union{Gift, Nothing}
    paid_media::Union{Array{PaidMedia}, Nothing}
    affiliate::Union{AffiliateInfo, Nothing}
end

"""
    TransactionPartnerChat
Represents a transaction partner of a chat.
"""
mutable struct TransactionPartnerChat <: TransactionPartner
    chat::Chat
end

"""
    TransactionPartnerTelegramAds
Represents a transaction partner of Telegram Ads.
"""
mutable struct TransactionPartnerTelegramAds <: TransactionPartner
    chat::Chat
end

"""
    TransactionPartnerTelegramApi
Represents a transaction partner of Telegram API.
"""
mutable struct TransactionPartnerTelegramApi <: TransactionPartner
    chat::Chat
end

"""
    TransactionPartnerAffiliateProgram
Represents a transaction partner of an affiliate program.
"""
mutable struct TransactionPartnerAffiliateProgram <: TransactionPartner
    affiliate_info::AffiliateInfo
end

"""
    AffiliateInfo
Represents information about an affiliate program.
"""
mutable struct AffiliateInfo <: BaseObjectType
    affiliate_id::String
    affiliate_name::String
end

# ============== Mask Position ==============

"""
    MaskPosition
Represents the position on a sticker mask.
"""
mutable struct MaskPosition <: BaseObjectType
    point::String
    x_shift::Float64
    y_shift::Float64
    scale::Float64
end

# ============== Import supporting types into main module ==============

include("telegram_types.jl")
