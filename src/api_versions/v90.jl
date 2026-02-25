"""
    Telegram.API.V90

Métodos da API 9.0 - Business Accounts
Released: April 2025

API 9.0 adds many Business Account methods:
"""
module V90
using ...Telegram
using ...Telegram.API

"""
    readBusinessMessage([client]; business_connection_id, chat_id, message_id)

Use this method to mark incoming messages as read on behalf of a business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `chat_id`: Chat identifier
- `message_id`: Message identifier
"""
function readBusinessMessage(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "readBusinessMessage", Dict{Symbol, Any}(kwargs))
end

"""
    deleteBusinessMessages([client]; business_connection_id, chat_id, message_ids)

Use this method to delete messages on behalf of a business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `chat_id`: Chat identifier
- `message_ids`: Array of message identifiers
"""
function deleteBusinessMessages(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "deleteBusinessMessages", Dict{Symbol, Any}(kwargs))
end

"""
    setBusinessAccountName([client]; business_connection_id; kwargs...)

Use this method to change the first and last name of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
"""
function setBusinessAccountName(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setBusinessAccountName", Dict{Symbol, Any}(kwargs))
end

"""
    setBusinessAccountUsername([client]; business_connection_id, username)

Use this method to change the username of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `username`: New username (empty string to remove)
"""
function setBusinessAccountUsername(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setBusinessAccountUsername", Dict{Symbol, Any}(kwargs))
end

"""
    setBusinessAccountBio([client]; business_connection_id, bio)

Use this method to change the bio of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `bio`: New bio
"""
function setBusinessAccountBio(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setBusinessAccountBio", Dict{Symbol, Any}(kwargs))
end

"""
    setBusinessAccountProfilePhoto([client]; business_connection_id, photo)

Use this method to change the profile photo of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `photo`: InputProfilePhoto
"""
function setBusinessAccountProfilePhoto(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setBusinessAccountProfilePhoto", Dict{Symbol, Any}(kwargs))
end

"""
    removeBusinessAccountProfilePhoto([client]; business_connection_id)

Use this method to remove the profile photo of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
"""
function removeBusinessAccountProfilePhoto(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "removeBusinessAccountProfilePhoto", Dict{Symbol, Any}(kwargs))
end

"""
    setBusinessAccountGiftSettings([client]; business_connection_id; kwargs...)

Use this method to change gift privacy settings of a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
"""
function setBusinessAccountGiftSettings(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "setBusinessAccountGiftSettings", Dict{Symbol, Any}(kwargs))
end

"""
    getBusinessAccountStarBalance([client]; business_connection_id)

Use this method to get the star balance of a managed business account. 
Returns StarAmount on success.

# Arguments
- `business_connection_id`: Business connection identifier
"""
function getBusinessAccountStarBalance(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getBusinessAccountStarBalance", Dict{Symbol, Any}(kwargs))
end

"""
    transferBusinessAccountStars([client]; business_connection_id, star_count)

Use this method to transfer stars from a managed business account. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `star_count`: Number of stars to transfer
"""
function transferBusinessAccountStars(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "transferBusinessAccountStars", Dict{Symbol, Any}(kwargs))
end

"""
    getBusinessAccountGifts([client]; business_connection_id; kwargs...)

Use this method to get the list of gifts owned by a managed business account. 
Returns OwnedGifts on success.

# Arguments
- `business_connection_id`: Business connection identifier
"""
function getBusinessAccountGifts(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "getBusinessAccountGifts", Dict{Symbol, Any}(kwargs))
end

"""
    convertGiftToStars([client]; business_connection_id, gift_id)

Use this method to convert a gift to stars. 
Returns StarAmount on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `gift_id`: Gift identifier
"""
function convertGiftToStars(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "convertGiftToStars", Dict{Symbol, Any}(kwargs))
end

"""
    upgradeGift([client]; business_connection_id, gift_id; kwargs...)

Use this method to upgrade a regular gift to a unique gift. 
Returns UniqueGift on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `gift_id`: Gift identifier
"""
function upgradeGift(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "upgradeGift", Dict{Symbol, Any}(kwargs))
end

"""
    transferGift([client]; business_connection_id, gift_id, new_owner_user_id)

Use this method to transfer a unique gift. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `gift_id`: Gift identifier
- `new_owner_user_id`: New owner user identifier
"""
function transferGift(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "transferGift", Dict{Symbol, Any}(kwargs))
end

"""
    postStory([client]; business_connection_id, chat_id, media; kwargs...)

Use this method to post a story on behalf of a managed business account. 
Returns Message on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `chat_id`: Chat identifier
- `media`: Story content
"""
function postStory(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "postStory", Dict{Symbol, Any}(kwargs))
end

"""
    editStory([client]; business_connection_id, story_id, media; kwargs...)

Use this method to edit a story. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `story_id`: Story identifier
- `media`: New story content
"""
function editStory(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "editStory", Dict{Symbol, Any}(kwargs))
end

"""
    deleteStory([client]; business_connection_id, story_id)

Use this method to delete a story. 
Returns True on success.

# Arguments
- `business_connection_id`: Business connection identifier
- `story_id`: Story identifier
"""
function deleteStory(client::TelegramClient = DEFAULT_OPTS.client; kwargs...)
    query(client, "deleteStory", Dict{Symbol, Any}(kwargs))
end

export readBusinessMessage,
       deleteBusinessMessages,
       setBusinessAccountName,
       setBusinessAccountUsername,
       setBusinessAccountBio,
       setBusinessAccountProfilePhoto,
       removeBusinessAccountProfilePhoto,
       setBusinessAccountGiftSettings,
       getBusinessAccountStarBalance,
       transferBusinessAccountStars,
       getBusinessAccountGifts,
       convertGiftToStars,
       upgradeGift,
       transferGift,
       postStory,
       editStory,
       deleteStory
end
