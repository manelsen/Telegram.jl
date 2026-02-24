# Telegram Bot API 7.x Types
# This file contains all type definitions for Telegram API responses and requests

using JSON3

# ============== Base Types ==============

"""
    BaseObjectType
Abstract type for all Telegram objects
"""
abstract type BaseObjectType end

"""
    TelegramObject{T}
Generic Telegram object type
"""
mutable struct TelegramObject{T} <: BaseObjectType
    id::T
end

# ============== Update Types ==============

"""
    Update
Represents an incoming update. At least one of the fields must be non-empty.
"""
mutable struct Update <: BaseObjectType
    # Basic fields
    update_id::Int

    # API 6.x fields
    message::Union{Message, Nothing}
    edited_message::Union{Message, Nothing}
    channel_post::Union{Message, Nothing}
    edited_channel_post::Union{Message, Nothing}
    inline_query::Union{InlineQuery, Nothing}
    chosen_inline_result::Union{ChosenInlineResult, Nothing}
    callback_query::Union{CallbackQuery, Nothing}
    shipping_query::Union{ShippingQuery, Nothing}
    pre_checkout_query::Union{PreCheckoutQuery, Nothing}
    poll::Union{Poll, Nothing}
    poll_answer::Union{PollAnswer, Nothing}
    my_chat_member::Union{ChatMemberUpdated, Nothing}
    chat_member::Union{ChatMemberUpdated, Nothing}
    chat_join_request::Union{ChatJoinRequest, Nothing}

    # API 7.x new fields (RF-036 to RF-038)
    business_connection::Union{BusinessConnection, Nothing}  # CT-036, RF-036
    business_message::Union{Message, Nothing}               # CT-037, RF-037
    edited_business_message::Union{Message, Nothing}        # CT-038, RF-038

    function Update(; kwargs...)
        fields = Dict(kwargs)
        obj = new(
            fields[:update_id]::Int
        )
        # Assign optional fields
        for (key, value) in fields
            if key in fieldnames(Update)
                setfield!(obj, key, value)
            end
        end
        return obj
    end
end

"""
    BusinessConnection
Represents a connection of a business account with a user.
"""
mutable struct BusinessConnection <: BaseObjectType
    id::String
    user_chat_id::Int
    date::Int
    can_write::Bool
    user::Union{User, Nothing}
end

# ============== Message Types ==============

"""
    Message
Represents a message.
"""
mutable struct Message <: BaseObjectType
    # Basic fields
    message_id::Int
    date::Int
    chat::Chat

    # API 6.x fields
    from::Union{User, Nothing}
    sender_chat::Union{Chat, Nothing}
    forward_from::Union{User, Nothing}
    forward_from_chat::Union{Chat, Nothing}
    forward_signature::Union{String, Nothing}
    forward_sender_name::Union{String, Nothing}
    forward_date::Union{Int, Nothing}
    reply_to_message::Union{Message, Nothing}
    via_bot::Union{User, Nothing}
    edit_date::Union{Int, Nothing}
    has_protected_content::Bool
    media_group_id::Union{String, Nothing}
    author_signature::Union{String, Nothing}
    disable_web_page_preview::Bool
    animation::Union{Animation, Nothing}
    audio::Union{Audio, Nothing}
    document::Union{Document, Nothing}
    paid_media::Union{PaidMediaInfo, Nothing}     # CT-040, RF-040
    game::Union{Game, Nothing}
    photo::Array{PhotoSize}
    sticker::Union{Sticker, Nothing}
    video::Union{Video, Nothing}
    video_note::Union{VideoNote, Nothing}
    voice::Union{Voice, Nothing}
    caption::Union{String, Nothing}
    caption_entities::Array{MessageEntity}
    has_caption::Bool
    contact::Union{Contact, Nothing}
    location::Union{Location, Nothing}
    venue::Union{Venue, Nothing}
    poll::Union{Poll, Nothing}
    new_chat_members::Array{User}
    left_chat_member::Union{User, Nothing}
    new_chat_title::Union{String, Nothing}
    new_chat_photo::Array{PhotoSize}
    delete_chat_photo::Bool
    group_chat_created::Bool
    supergroup_chat_created::Bool
    channel_chat_created::Bool
    migrate_to_chat_id::Union{Int, Nothing}
    migrate_from_chat_id::Union{Int, Nothing}
    pinned_message::Union{Message, Nothing}
    invoice::Union{Invoice, Nothing}
    successful_payment::Union{SuccessfulPayment, Nothing}
    refunded_payment::Union{RefundedPayment, Nothing}  # New in API 7.7
    connected_website::Union{String, Nothing}
    reply_markup::Union{InlineKeyboardMarkup, ReplyKeyboardMarkup, ReplyKeyboardRemove, ForceReply, Nothing}
    business_connection_id::Union{String, Nothing}     # CT-039, RF-039
    gift::Union{Gift, Nothing}                         # CT-041, RF-041
    effect_id::Union{String, Nothing}                 # API 7.4+
    paid_star_count::Union{Int, Nothing}              # API 7.4+

    function Message(; kwargs...)
        fields = Dict(kwargs)
        # Check if message_id is provided
        if haskey(fields, :message_id)
            obj = new(
                fields[:message_id]::Int,
                fields[:date]::Int,
                fields[:chat]
            )
        else
            obj = new(0, 0, fields[:chat])
        end

        # Assign optional fields
        for (key, value) in fields
            if key in fieldnames(Message)
                if value !== nothing
                    setfield!(obj, key, value)
                end
            end
        end
        return obj
    end
end

"""
    Gift
Represents a Telegram Star gift.
"""
mutable struct Gift <: BaseObjectType
    id::String
    title::String
    description::String
    thumbnail::Union{PhotoSize, Nothing}
end

# ============== Chat Types ==============

"""
    Chat
Represents a chat.
"""
mutable struct Chat <: BaseObjectType
    id::Union{Int, String}
    type::String
    title::Union{String, Nothing}
    username::Union{String, Nothing}
    first_name::Union{String, Nothing}
    last_name::Union{String, Nothing}
    is_forum::Bool
    photo::Union{Array{PhotoSize}, Nothing}
    bio::Union{String, Nothing}
    has_private_forwards::Bool
    description::Union{String, Nothing}
    invite_link::Union{String, Nothing}
    pinned_message::Union{Message, Nothing}
    permissions::Union{ChatPermissions, Nothing}
    slow_mode_delay::Union{Int, Nothing}
    can_be_edited::Bool
    has_protected_content::Bool
    has_restricted_voice_and_video_messages::Bool
    join_to_send_messages::Bool
    join_by_request::Bool
    message_auto_delete_time::Union{Int, Nothing}
    has_aggressive_anti_spam_enabled::Bool
    has_hidden_members::Bool
    has_protected_content::Bool
    sticker_set_name::Union{String, Nothing}
    can_set_sticker_set::Bool
    can_send_paid_media::Bool               # API 7.4+
    business_intro::Union{BusinessIntro, Nothing}    # CT-042, RF-042
    business_location::Union{BusinessLocation, Nothing}  # CT-043, RF-043

    function Chat(; kwargs...)
        fields = Dict(kwargs)
        obj = new(
            fields[:id],
            fields[:type]
        )
        # Assign optional fields
        for (key, value) in fields
            if key in fieldnames(Chat)
                if value !== nothing
                    setfield!(obj, key, value)
                end
            end
        end
        return obj
    end
end

"""
    BusinessIntro
Represents a business chat introduction.
"""
mutable struct BusinessIntro <: BaseObjectType
    title::String
    message::String
    sticker::Union{Sticker, Nothing}
end

"""
    BusinessLocation
Represents a business chat location.
"""
mutable struct BusinessLocation <: BaseObjectType
    address::String
    location::Union{Location, Nothing}
end

# ============== Payment Types ==============

"""
    PaidMediaInfo
Represents information about a paid media.
"""
mutable struct PaidMediaInfo <: BaseObjectType
    paid_media::Array{Union{PaidMedia, Nothing}}
    paid_media_ids::Array{String}
end

"""
    PaidMedia
Represents a paid media.
"""
abstract type PaidMedia <: BaseObjectType end

"""
    PaidMediaPhoto
Represents a paid photo.
"""
mutable struct PaidMediaPhoto <: PaidMedia
    type::String
    photo::Array{PhotoSize}
    thumbnail::Union{PhotoSize, Nothing}
end

"""
    PaidMediaVideo
Represents a paid video.
"""
mutable struct PaidMediaVideo <: PaidMedia
    type::String
    video::Union{Video, Nothing}
    thumbnail::Union{PhotoSize, Nothing}
    duration::Int
    width::Int
    height::Int
end

# ============== Helper Functions ==============

function parse_update(json::AbstractString)
    return JSON3.read(json, Update)
end

function parse_message(json::AbstractString)
    return JSON3.read(json, Message)
end

function parse_chat(json::AbstractString)
    return JSON3.read(json, Chat)
end
