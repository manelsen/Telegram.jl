# Telegram Bot API 10.3 Object Schemas

This is a reference for **400 Bot API object types**, generated from the pinned
specification. Telegram.jl returns dynamic JSON3 objects and accepts nested
JSON-serializable dictionaries; these entries describe API schemas, not Julia struct types.
Files embedded in nested objects may require explicit Telegram `attach://` handling.

See the [official Telegram Bot API](https://core.telegram.org/bots/api).

## `AcceptedGiftTypes`

[Official object specification](https://core.telegram.org/bots/api#acceptedgifttypes)

| Field | Type | Required |
|---|---|---|
| `unlimited_gifts` | Boolean | Yes |
| `limited_gifts` | Boolean | Yes |
| `unique_gifts` | Boolean | Yes |
| `premium_subscription` | Boolean | Yes |
| `gifts_from_channels` | Boolean | Yes |

## `AffiliateInfo`

[Official object specification](https://core.telegram.org/bots/api#affiliateinfo)

| Field | Type | Required |
|---|---|---|
| `affiliate_user` | User | No |
| `affiliate_chat` | Chat | No |
| `commission_per_mille` | Integer | Yes |
| `amount` | Integer | Yes |
| `nanostar_amount` | Integer | No |

## `Animation`

[Official object specification](https://core.telegram.org/bots/api#animation)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `duration` | Integer | Yes |
| `thumbnail` | PhotoSize | No |
| `file_name` | String | No |
| `mime_type` | String | No |
| `file_size` | Integer | No |

## `Audio`

[Official object specification](https://core.telegram.org/bots/api#audio)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `duration` | Integer | Yes |
| `performer` | String | No |
| `title` | String | No |
| `file_name` | String | No |
| `mime_type` | String | No |
| `file_size` | Integer | No |
| `thumbnail` | PhotoSize | No |

## `BackgroundFill`

[Official object specification](https://core.telegram.org/bots/api#backgroundfill)

Implementations: `BackgroundFillSolid`, `BackgroundFillGradient`, `BackgroundFillFreeformGradient`.

## `BackgroundFillFreeformGradient`

[Official object specification](https://core.telegram.org/bots/api#backgroundfillfreeformgradient)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `colors` | Array of Integer | Yes |

## `BackgroundFillGradient`

[Official object specification](https://core.telegram.org/bots/api#backgroundfillgradient)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `top_color` | Integer | Yes |
| `bottom_color` | Integer | Yes |
| `rotation_angle` | Integer | Yes |

## `BackgroundFillSolid`

[Official object specification](https://core.telegram.org/bots/api#backgroundfillsolid)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `color` | Integer | Yes |

## `BackgroundType`

[Official object specification](https://core.telegram.org/bots/api#backgroundtype)

Implementations: `BackgroundTypeFill`, `BackgroundTypeWallpaper`, `BackgroundTypePattern`, `BackgroundTypeChatTheme`.

## `BackgroundTypeChatTheme`

[Official object specification](https://core.telegram.org/bots/api#backgroundtypechattheme)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `theme_name` | String | Yes |

## `BackgroundTypeFill`

[Official object specification](https://core.telegram.org/bots/api#backgroundtypefill)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `fill` | BackgroundFill | Yes |
| `dark_theme_dimming` | Integer | Yes |

## `BackgroundTypePattern`

[Official object specification](https://core.telegram.org/bots/api#backgroundtypepattern)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `document` | Document | Yes |
| `fill` | BackgroundFill | Yes |
| `intensity` | Integer | Yes |
| `is_inverted` | Boolean | No |
| `is_moving` | Boolean | No |

## `BackgroundTypeWallpaper`

[Official object specification](https://core.telegram.org/bots/api#backgroundtypewallpaper)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `document` | Document | Yes |
| `dark_theme_dimming` | Integer | Yes |
| `is_blurred` | Boolean | No |
| `is_moving` | Boolean | No |

## `Birthdate`

[Official object specification](https://core.telegram.org/bots/api#birthdate)

| Field | Type | Required |
|---|---|---|
| `day` | Integer | Yes |
| `month` | Integer | Yes |
| `year` | Integer | No |

## `BotAccessSettings`

[Official object specification](https://core.telegram.org/bots/api#botaccesssettings)

| Field | Type | Required |
|---|---|---|
| `is_access_restricted` | Boolean | Yes |
| `added_users` | Array of User | No |

## `BotCommand`

[Official object specification](https://core.telegram.org/bots/api#botcommand)

| Field | Type | Required |
|---|---|---|
| `command` | String | Yes |
| `description` | String | Yes |
| `is_ephemeral` | Boolean | No |

## `BotCommandScope`

[Official object specification](https://core.telegram.org/bots/api#botcommandscope)

Implementations: `BotCommandScopeDefault`, `BotCommandScopeAllPrivateChats`, `BotCommandScopeAllGroupChats`, `BotCommandScopeAllChatAdministrators`, `BotCommandScopeChat`, `BotCommandScopeChatAdministrators`, `BotCommandScopeChatMember`.

## `BotCommandScopeAllChatAdministrators`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopeallchatadministrators)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `BotCommandScopeAllGroupChats`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopeallgroupchats)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `BotCommandScopeAllPrivateChats`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopeallprivatechats)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `BotCommandScopeChat`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopechat)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `chat_id` | Integer or String | Yes |

## `BotCommandScopeChatAdministrators`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopechatadministrators)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `chat_id` | Integer or String | Yes |

## `BotCommandScopeChatMember`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopechatmember)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `chat_id` | Integer or String | Yes |
| `user_id` | Integer | Yes |

## `BotCommandScopeDefault`

[Official object specification](https://core.telegram.org/bots/api#botcommandscopedefault)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `BotDescription`

[Official object specification](https://core.telegram.org/bots/api#botdescription)

| Field | Type | Required |
|---|---|---|
| `description` | String | Yes |

## `BotName`

[Official object specification](https://core.telegram.org/bots/api#botname)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |

## `BotShortDescription`

[Official object specification](https://core.telegram.org/bots/api#botshortdescription)

| Field | Type | Required |
|---|---|---|
| `short_description` | String | Yes |

## `BotSubscriptionUpdated`

[Official object specification](https://core.telegram.org/bots/api#botsubscriptionupdated)

| Field | Type | Required |
|---|---|---|
| `user` | User | Yes |
| `invoice_payload` | String | Yes |
| `state` | String | Yes |

## `BusinessBotRights`

[Official object specification](https://core.telegram.org/bots/api#businessbotrights)

| Field | Type | Required |
|---|---|---|
| `can_reply` | Boolean | No |
| `can_read_messages` | Boolean | No |
| `can_delete_sent_messages` | Boolean | No |
| `can_delete_all_messages` | Boolean | No |
| `can_edit_name` | Boolean | No |
| `can_edit_bio` | Boolean | No |
| `can_edit_profile_photo` | Boolean | No |
| `can_edit_username` | Boolean | No |
| `can_change_gift_settings` | Boolean | No |
| `can_view_gifts_and_stars` | Boolean | No |
| `can_convert_gifts_to_stars` | Boolean | No |
| `can_transfer_and_upgrade_gifts` | Boolean | No |
| `can_transfer_stars` | Boolean | No |
| `can_manage_stories` | Boolean | No |

## `BusinessConnection`

[Official object specification](https://core.telegram.org/bots/api#businessconnection)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `user` | User | Yes |
| `user_chat_id` | Integer | Yes |
| `date` | Integer | Yes |
| `rights` | BusinessBotRights | No |
| `is_enabled` | Boolean | Yes |

## `BusinessIntro`

[Official object specification](https://core.telegram.org/bots/api#businessintro)

| Field | Type | Required |
|---|---|---|
| `title` | String | No |
| `message` | String | No |
| `sticker` | Sticker | No |

## `BusinessLocation`

[Official object specification](https://core.telegram.org/bots/api#businesslocation)

| Field | Type | Required |
|---|---|---|
| `address` | String | Yes |
| `location` | Location | No |

## `BusinessMessagesDeleted`

[Official object specification](https://core.telegram.org/bots/api#businessmessagesdeleted)

| Field | Type | Required |
|---|---|---|
| `business_connection_id` | String | Yes |
| `chat` | Chat | Yes |
| `message_ids` | Array of Integer | Yes |

## `BusinessOpeningHours`

[Official object specification](https://core.telegram.org/bots/api#businessopeninghours)

| Field | Type | Required |
|---|---|---|
| `time_zone_name` | String | Yes |
| `opening_hours` | Array of BusinessOpeningHoursInterval | Yes |

## `BusinessOpeningHoursInterval`

[Official object specification](https://core.telegram.org/bots/api#businessopeninghoursinterval)

| Field | Type | Required |
|---|---|---|
| `opening_minute` | Integer | Yes |
| `closing_minute` | Integer | Yes |

## `CallbackGame`

[Official object specification](https://core.telegram.org/bots/api#callbackgame)

## `CallbackQuery`

[Official object specification](https://core.telegram.org/bots/api#callbackquery)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `from` | User | Yes |
| `message` | MaybeInaccessibleMessage | No |
| `inline_message_id` | String | No |
| `chat_instance` | String | Yes |
| `data` | String | No |
| `game_short_name` | String | No |

## `Chat`

[Official object specification](https://core.telegram.org/bots/api#chat)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `type` | String | Yes |
| `title` | String | No |
| `username` | String | No |
| `first_name` | String | No |
| `last_name` | String | No |
| `is_forum` | Boolean | No |
| `is_direct_messages` | Boolean | No |

## `ChatAdministratorRights`

[Official object specification](https://core.telegram.org/bots/api#chatadministratorrights)

| Field | Type | Required |
|---|---|---|
| `is_anonymous` | Boolean | Yes |
| `can_manage_chat` | Boolean | Yes |
| `can_delete_messages` | Boolean | Yes |
| `can_manage_video_chats` | Boolean | Yes |
| `can_restrict_members` | Boolean | Yes |
| `can_promote_members` | Boolean | Yes |
| `can_change_info` | Boolean | Yes |
| `can_invite_users` | Boolean | Yes |
| `can_post_stories` | Boolean | Yes |
| `can_edit_stories` | Boolean | Yes |
| `can_delete_stories` | Boolean | Yes |
| `can_post_messages` | Boolean | No |
| `can_edit_messages` | Boolean | No |
| `can_pin_messages` | Boolean | No |
| `can_manage_topics` | Boolean | No |
| `can_manage_direct_messages` | Boolean | No |
| `can_manage_tags` | Boolean | No |
| `can_send_welcome_messages` | Boolean | Yes |

## `ChatBackground`

[Official object specification](https://core.telegram.org/bots/api#chatbackground)

| Field | Type | Required |
|---|---|---|
| `type` | BackgroundType | Yes |

## `ChatBoost`

[Official object specification](https://core.telegram.org/bots/api#chatboost)

| Field | Type | Required |
|---|---|---|
| `boost_id` | String | Yes |
| `add_date` | Integer | Yes |
| `expiration_date` | Integer | Yes |
| `source` | ChatBoostSource | Yes |

## `ChatBoostAdded`

[Official object specification](https://core.telegram.org/bots/api#chatboostadded)

| Field | Type | Required |
|---|---|---|
| `boost_count` | Integer | Yes |

## `ChatBoostRemoved`

[Official object specification](https://core.telegram.org/bots/api#chatboostremoved)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `boost_id` | String | Yes |
| `remove_date` | Integer | Yes |
| `source` | ChatBoostSource | Yes |

## `ChatBoostSource`

[Official object specification](https://core.telegram.org/bots/api#chatboostsource)

Implementations: `ChatBoostSourcePremium`, `ChatBoostSourceGiftCode`, `ChatBoostSourceGiveaway`.

## `ChatBoostSourceGiftCode`

[Official object specification](https://core.telegram.org/bots/api#chatboostsourcegiftcode)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `user` | User | Yes |

## `ChatBoostSourceGiveaway`

[Official object specification](https://core.telegram.org/bots/api#chatboostsourcegiveaway)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `giveaway_message_id` | Integer | Yes |
| `user` | User | No |
| `prize_star_count` | Integer | No |
| `is_unclaimed` | Boolean | No |

## `ChatBoostSourcePremium`

[Official object specification](https://core.telegram.org/bots/api#chatboostsourcepremium)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `user` | User | Yes |

## `ChatBoostUpdated`

[Official object specification](https://core.telegram.org/bots/api#chatboostupdated)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `boost` | ChatBoost | Yes |

## `ChatFullInfo`

[Official object specification](https://core.telegram.org/bots/api#chatfullinfo)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `type` | String | Yes |
| `title` | String | No |
| `username` | String | No |
| `first_name` | String | No |
| `last_name` | String | No |
| `is_forum` | Boolean | No |
| `is_direct_messages` | Boolean | No |
| `accent_color_id` | Integer | Yes |
| `max_reaction_count` | Integer | Yes |
| `photo` | ChatPhoto | No |
| `active_usernames` | Array of String | No |
| `birthdate` | Birthdate | No |
| `business_intro` | BusinessIntro | No |
| `business_location` | BusinessLocation | No |
| `business_opening_hours` | BusinessOpeningHours | No |
| `personal_chat` | Chat | No |
| `parent_chat` | Chat | No |
| `available_reactions` | Array of ReactionType | No |
| `background_custom_emoji_id` | String | No |
| `profile_accent_color_id` | Integer | No |
| `profile_background_custom_emoji_id` | String | No |
| `emoji_status_custom_emoji_id` | String | No |
| `emoji_status_expiration_date` | Integer | No |
| `bio` | String | No |
| `has_private_forwards` | Boolean | No |
| `has_restricted_voice_and_video_messages` | Boolean | No |
| `join_to_send_messages` | Boolean | No |
| `join_by_request` | Boolean | No |
| `description` | String | No |
| `invite_link` | String | No |
| `pinned_message` | Message | No |
| `permissions` | ChatPermissions | No |
| `accepted_gift_types` | AcceptedGiftTypes | Yes |
| `can_send_paid_media` | Boolean | No |
| `slow_mode_delay` | Integer | No |
| `unrestrict_boost_count` | Integer | No |
| `message_auto_delete_time` | Integer | No |
| `has_aggressive_anti_spam_enabled` | Boolean | No |
| `has_hidden_members` | Boolean | No |
| `has_protected_content` | Boolean | No |
| `has_visible_history` | Boolean | No |
| `sticker_set_name` | String | No |
| `can_set_sticker_set` | Boolean | No |
| `custom_emoji_sticker_set_name` | String | No |
| `linked_chat_id` | Integer | No |
| `location` | ChatLocation | No |
| `rating` | UserRating | No |
| `first_profile_audio` | Audio | No |
| `unique_gift_colors` | UniqueGiftColors | No |
| `paid_message_star_count` | Integer | No |
| `guard_bot` | User | No |
| `community` | Community | No |

## `ChatInviteLink`

[Official object specification](https://core.telegram.org/bots/api#chatinvitelink)

| Field | Type | Required |
|---|---|---|
| `invite_link` | String | Yes |
| `creator` | User | Yes |
| `creates_join_request` | Boolean | Yes |
| `is_primary` | Boolean | Yes |
| `is_revoked` | Boolean | Yes |
| `name` | String | No |
| `expire_date` | Integer | No |
| `member_limit` | Integer | No |
| `pending_join_request_count` | Integer | No |
| `subscription_period` | Integer | No |
| `subscription_price` | Integer | No |

## `ChatJoinRequest`

[Official object specification](https://core.telegram.org/bots/api#chatjoinrequest)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `from` | User | Yes |
| `user_chat_id` | Integer | Yes |
| `date` | Integer | Yes |
| `bio` | String | No |
| `invite_link` | ChatInviteLink | No |
| `query_id` | String | No |

## `ChatLocation`

[Official object specification](https://core.telegram.org/bots/api#chatlocation)

| Field | Type | Required |
|---|---|---|
| `location` | Location | Yes |
| `address` | String | Yes |

## `ChatMember`

[Official object specification](https://core.telegram.org/bots/api#chatmember)

Implementations: `ChatMemberOwner`, `ChatMemberAdministrator`, `ChatMemberMember`, `ChatMemberRestricted`, `ChatMemberLeft`, `ChatMemberBanned`.

## `ChatMemberAdministrator`

[Official object specification](https://core.telegram.org/bots/api#chatmemberadministrator)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `user` | User | Yes |
| `can_be_edited` | Boolean | Yes |
| `is_anonymous` | Boolean | Yes |
| `can_manage_chat` | Boolean | Yes |
| `can_delete_messages` | Boolean | Yes |
| `can_manage_video_chats` | Boolean | Yes |
| `can_restrict_members` | Boolean | Yes |
| `can_promote_members` | Boolean | Yes |
| `can_change_info` | Boolean | Yes |
| `can_invite_users` | Boolean | Yes |
| `can_post_stories` | Boolean | Yes |
| `can_edit_stories` | Boolean | Yes |
| `can_delete_stories` | Boolean | Yes |
| `can_post_messages` | Boolean | No |
| `can_edit_messages` | Boolean | No |
| `can_pin_messages` | Boolean | No |
| `can_manage_topics` | Boolean | No |
| `can_manage_direct_messages` | Boolean | No |
| `can_manage_tags` | Boolean | No |
| `can_send_welcome_messages` | Boolean | Yes |
| `custom_title` | String | No |

## `ChatMemberBanned`

[Official object specification](https://core.telegram.org/bots/api#chatmemberbanned)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `user` | User | Yes |
| `until_date` | Integer | Yes |

## `ChatMemberLeft`

[Official object specification](https://core.telegram.org/bots/api#chatmemberleft)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `user` | User | Yes |

## `ChatMemberMember`

[Official object specification](https://core.telegram.org/bots/api#chatmembermember)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `tag` | String | No |
| `user` | User | Yes |
| `until_date` | Integer | No |

## `ChatMemberOwner`

[Official object specification](https://core.telegram.org/bots/api#chatmemberowner)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `user` | User | Yes |
| `is_anonymous` | Boolean | Yes |
| `custom_title` | String | No |

## `ChatMemberRestricted`

[Official object specification](https://core.telegram.org/bots/api#chatmemberrestricted)

| Field | Type | Required |
|---|---|---|
| `status` | String | Yes |
| `tag` | String | No |
| `user` | User | Yes |
| `is_member` | Boolean | Yes |
| `can_send_messages` | Boolean | Yes |
| `can_send_audios` | Boolean | Yes |
| `can_send_documents` | Boolean | Yes |
| `can_send_photos` | Boolean | Yes |
| `can_send_videos` | Boolean | Yes |
| `can_send_video_notes` | Boolean | Yes |
| `can_send_voice_notes` | Boolean | Yes |
| `can_send_polls` | Boolean | Yes |
| `can_send_other_messages` | Boolean | Yes |
| `can_add_web_page_previews` | Boolean | Yes |
| `can_react_to_messages` | Boolean | Yes |
| `can_edit_tag` | Boolean | Yes |
| `can_change_info` | Boolean | Yes |
| `can_invite_users` | Boolean | Yes |
| `can_pin_messages` | Boolean | Yes |
| `can_manage_topics` | Boolean | Yes |
| `until_date` | Integer | Yes |

## `ChatMemberUpdated`

[Official object specification](https://core.telegram.org/bots/api#chatmemberupdated)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `from` | User | Yes |
| `date` | Integer | Yes |
| `old_chat_member` | ChatMember | Yes |
| `new_chat_member` | ChatMember | Yes |
| `invite_link` | ChatInviteLink | No |
| `via_join_request` | Boolean | No |
| `via_chat_folder_invite_link` | Boolean | No |

## `ChatOwnerChanged`

[Official object specification](https://core.telegram.org/bots/api#chatownerchanged)

| Field | Type | Required |
|---|---|---|
| `new_owner` | User | Yes |

## `ChatOwnerLeft`

[Official object specification](https://core.telegram.org/bots/api#chatownerleft)

| Field | Type | Required |
|---|---|---|
| `new_owner` | User | No |

## `ChatPermissions`

[Official object specification](https://core.telegram.org/bots/api#chatpermissions)

| Field | Type | Required |
|---|---|---|
| `can_send_messages` | Boolean | No |
| `can_send_audios` | Boolean | No |
| `can_send_documents` | Boolean | No |
| `can_send_photos` | Boolean | No |
| `can_send_videos` | Boolean | No |
| `can_send_video_notes` | Boolean | No |
| `can_send_voice_notes` | Boolean | No |
| `can_send_polls` | Boolean | No |
| `can_send_other_messages` | Boolean | No |
| `can_add_web_page_previews` | Boolean | No |
| `can_react_to_messages` | Boolean | No |
| `can_edit_tag` | Boolean | No |
| `can_change_info` | Boolean | No |
| `can_invite_users` | Boolean | No |
| `can_pin_messages` | Boolean | No |
| `can_manage_topics` | Boolean | No |

## `ChatPhoto`

[Official object specification](https://core.telegram.org/bots/api#chatphoto)

| Field | Type | Required |
|---|---|---|
| `small_file_id` | String | Yes |
| `small_file_unique_id` | String | Yes |
| `big_file_id` | String | Yes |
| `big_file_unique_id` | String | Yes |

## `ChatShared`

[Official object specification](https://core.telegram.org/bots/api#chatshared)

| Field | Type | Required |
|---|---|---|
| `request_id` | Integer | Yes |
| `chat_id` | Integer | Yes |
| `title` | String | No |
| `username` | String | No |
| `photo` | Array of PhotoSize | No |

## `Checklist`

[Official object specification](https://core.telegram.org/bots/api#checklist)

| Field | Type | Required |
|---|---|---|
| `title` | String | Yes |
| `title_entities` | Array of MessageEntity | No |
| `tasks` | Array of ChecklistTask | Yes |
| `others_can_add_tasks` | Boolean | No |
| `others_can_mark_tasks_as_done` | Boolean | No |

## `ChecklistTask`

[Official object specification](https://core.telegram.org/bots/api#checklisttask)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `text` | String | Yes |
| `text_entities` | Array of MessageEntity | No |
| `completed_by_user` | User | No |
| `completed_by_chat` | Chat | No |
| `completion_date` | Integer | No |

## `ChecklistTasksAdded`

[Official object specification](https://core.telegram.org/bots/api#checklisttasksadded)

| Field | Type | Required |
|---|---|---|
| `checklist_message` | Message | No |
| `tasks` | Array of ChecklistTask | Yes |

## `ChecklistTasksDone`

[Official object specification](https://core.telegram.org/bots/api#checklisttasksdone)

| Field | Type | Required |
|---|---|---|
| `checklist_message` | Message | No |
| `marked_as_done_task_ids` | Array of Integer | No |
| `marked_as_not_done_task_ids` | Array of Integer | No |

## `ChosenInlineResult`

[Official object specification](https://core.telegram.org/bots/api#choseninlineresult)

| Field | Type | Required |
|---|---|---|
| `result_id` | String | Yes |
| `from` | User | Yes |
| `location` | Location | No |
| `inline_message_id` | String | No |
| `query` | String | Yes |

## `Community`

[Official object specification](https://core.telegram.org/bots/api#community)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `name` | String | Yes |

## `CommunityChatAdded`

[Official object specification](https://core.telegram.org/bots/api#communitychatadded)

| Field | Type | Required |
|---|---|---|
| `community` | Community | Yes |

## `CommunityChatJoined`

[Official object specification](https://core.telegram.org/bots/api#communitychatjoined)

| Field | Type | Required |
|---|---|---|
| `community` | Community | Yes |

## `CommunityChatRemoved`

[Official object specification](https://core.telegram.org/bots/api#communitychatremoved)

## `Contact`

[Official object specification](https://core.telegram.org/bots/api#contact)

| Field | Type | Required |
|---|---|---|
| `phone_number` | String | Yes |
| `first_name` | String | Yes |
| `last_name` | String | No |
| `user_id` | Integer | No |
| `vcard` | String | No |

## `CopyTextButton`

[Official object specification](https://core.telegram.org/bots/api#copytextbutton)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |

## `Dice`

[Official object specification](https://core.telegram.org/bots/api#dice)

| Field | Type | Required |
|---|---|---|
| `emoji` | String | Yes |
| `value` | Integer | Yes |

## `DirectMessagePriceChanged`

[Official object specification](https://core.telegram.org/bots/api#directmessagepricechanged)

| Field | Type | Required |
|---|---|---|
| `are_direct_messages_enabled` | Boolean | Yes |
| `direct_message_star_count` | Integer | No |

## `DirectMessagesTopic`

[Official object specification](https://core.telegram.org/bots/api#directmessagestopic)

| Field | Type | Required |
|---|---|---|
| `topic_id` | Integer | Yes |
| `user` | User | No |

## `DisabledButton`

[Official object specification](https://core.telegram.org/bots/api#disabledbutton)

## `Document`

[Official object specification](https://core.telegram.org/bots/api#document)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `thumbnail` | PhotoSize | No |
| `file_name` | String | No |
| `mime_type` | String | No |
| `file_size` | Integer | No |

## `EncryptedCredentials`

[Official object specification](https://core.telegram.org/bots/api#encryptedcredentials)

| Field | Type | Required |
|---|---|---|
| `data` | String | Yes |
| `hash` | String | Yes |
| `secret` | String | Yes |

## `EncryptedPassportElement`

[Official object specification](https://core.telegram.org/bots/api#encryptedpassportelement)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `data` | String | No |
| `phone_number` | String | No |
| `email` | String | No |
| `files` | Array of PassportFile | No |
| `front_side` | PassportFile | No |
| `reverse_side` | PassportFile | No |
| `selfie` | PassportFile | No |
| `translation` | Array of PassportFile | No |
| `hash` | String | Yes |

## `EphemeralMessageParameters`

[Official object specification](https://core.telegram.org/bots/api#ephemeralmessageparameters)

| Field | Type | Required |
|---|---|---|
| `receiver_user_id` | Integer | Yes |
| `callback_query_id` | String | No |
| `replace_callback_query_message` | Boolean | No |

## `ExternalReplyInfo`

[Official object specification](https://core.telegram.org/bots/api#externalreplyinfo)

| Field | Type | Required |
|---|---|---|
| `origin` | MessageOrigin | Yes |
| `chat` | Chat | No |
| `message_id` | Integer | No |
| `link_preview_options` | LinkPreviewOptions | No |
| `animation` | Animation | No |
| `audio` | Audio | No |
| `document` | Document | No |
| `live_photo` | LivePhoto | No |
| `paid_media` | PaidMediaInfo | No |
| `photo` | Array of PhotoSize | No |
| `sticker` | Sticker | No |
| `story` | Story | No |
| `video` | Video | No |
| `video_note` | VideoNote | No |
| `voice` | Voice | No |
| `has_media_spoiler` | Boolean | No |
| `checklist` | Checklist | No |
| `contact` | Contact | No |
| `dice` | Dice | No |
| `game` | Game | No |
| `giveaway` | Giveaway | No |
| `giveaway_winners` | GiveawayWinners | No |
| `invoice` | Invoice | No |
| `location` | Location | No |
| `poll` | Poll | No |
| `venue` | Venue | No |

## `File`

[Official object specification](https://core.telegram.org/bots/api#file)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `file_size` | Integer | No |
| `file_path` | String | No |

## `ForceReply`

[Official object specification](https://core.telegram.org/bots/api#forcereply)

| Field | Type | Required |
|---|---|---|
| `force_reply` | Boolean | Yes |
| `input_field_placeholder` | String | No |
| `selective` | Boolean | No |

## `ForumTopic`

[Official object specification](https://core.telegram.org/bots/api#forumtopic)

| Field | Type | Required |
|---|---|---|
| `message_thread_id` | Integer | Yes |
| `name` | String | Yes |
| `icon_color` | Integer | Yes |
| `icon_custom_emoji_id` | String | No |
| `is_name_implicit` | Boolean | No |

## `ForumTopicClosed`

[Official object specification](https://core.telegram.org/bots/api#forumtopicclosed)

## `ForumTopicCreated`

[Official object specification](https://core.telegram.org/bots/api#forumtopiccreated)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |
| `icon_color` | Integer | Yes |
| `icon_custom_emoji_id` | String | No |
| `is_name_implicit` | Boolean | No |

## `ForumTopicEdited`

[Official object specification](https://core.telegram.org/bots/api#forumtopicedited)

| Field | Type | Required |
|---|---|---|
| `name` | String | No |
| `icon_custom_emoji_id` | String | No |

## `ForumTopicReopened`

[Official object specification](https://core.telegram.org/bots/api#forumtopicreopened)

## `Game`

[Official object specification](https://core.telegram.org/bots/api#game)

| Field | Type | Required |
|---|---|---|
| `title` | String | Yes |
| `description` | String | Yes |
| `photo` | Array of PhotoSize | Yes |
| `text` | String | No |
| `text_entities` | Array of MessageEntity | No |
| `animation` | Animation | No |

## `GameHighScore`

[Official object specification](https://core.telegram.org/bots/api#gamehighscore)

| Field | Type | Required |
|---|---|---|
| `position` | Integer | Yes |
| `user` | User | Yes |
| `score` | Integer | Yes |

## `GeneralForumTopicHidden`

[Official object specification](https://core.telegram.org/bots/api#generalforumtopichidden)

## `GeneralForumTopicUnhidden`

[Official object specification](https://core.telegram.org/bots/api#generalforumtopicunhidden)

## `Gift`

[Official object specification](https://core.telegram.org/bots/api#gift)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `sticker` | Sticker | Yes |
| `star_count` | Integer | Yes |
| `upgrade_star_count` | Integer | No |
| `is_premium` | Boolean | No |
| `has_colors` | Boolean | No |
| `total_count` | Integer | No |
| `remaining_count` | Integer | No |
| `personal_total_count` | Integer | No |
| `personal_remaining_count` | Integer | No |
| `background` | GiftBackground | No |
| `unique_gift_variant_count` | Integer | No |
| `publisher_chat` | Chat | No |

## `GiftBackground`

[Official object specification](https://core.telegram.org/bots/api#giftbackground)

| Field | Type | Required |
|---|---|---|
| `center_color` | Integer | Yes |
| `edge_color` | Integer | Yes |
| `text_color` | Integer | Yes |

## `GiftInfo`

[Official object specification](https://core.telegram.org/bots/api#giftinfo)

| Field | Type | Required |
|---|---|---|
| `gift` | Gift | Yes |
| `owned_gift_id` | String | No |
| `convert_star_count` | Integer | No |
| `prepaid_upgrade_star_count` | Integer | No |
| `is_upgrade_separate` | Boolean | No |
| `can_be_upgraded` | Boolean | No |
| `text` | String | No |
| `entities` | Array of MessageEntity | No |
| `is_private` | Boolean | No |
| `unique_gift_number` | Integer | No |

## `Gifts`

[Official object specification](https://core.telegram.org/bots/api#gifts)

| Field | Type | Required |
|---|---|---|
| `gifts` | Array of Gift | Yes |

## `Giveaway`

[Official object specification](https://core.telegram.org/bots/api#giveaway)

| Field | Type | Required |
|---|---|---|
| `chats` | Array of Chat | Yes |
| `winners_selection_date` | Integer | Yes |
| `winner_count` | Integer | Yes |
| `only_new_members` | Boolean | No |
| `has_public_winners` | Boolean | No |
| `prize_description` | String | No |
| `country_codes` | Array of String | No |
| `prize_star_count` | Integer | No |
| `premium_subscription_month_count` | Integer | No |

## `GiveawayCompleted`

[Official object specification](https://core.telegram.org/bots/api#giveawaycompleted)

| Field | Type | Required |
|---|---|---|
| `winner_count` | Integer | Yes |
| `unclaimed_prize_count` | Integer | No |
| `giveaway_message` | Message | No |
| `is_star_giveaway` | Boolean | No |

## `GiveawayCreated`

[Official object specification](https://core.telegram.org/bots/api#giveawaycreated)

| Field | Type | Required |
|---|---|---|
| `prize_star_count` | Integer | No |

## `GiveawayWinners`

[Official object specification](https://core.telegram.org/bots/api#giveawaywinners)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `giveaway_message_id` | Integer | Yes |
| `winners_selection_date` | Integer | Yes |
| `winner_count` | Integer | Yes |
| `winners` | Array of User | Yes |
| `additional_chat_count` | Integer | No |
| `prize_star_count` | Integer | No |
| `premium_subscription_month_count` | Integer | No |
| `unclaimed_prize_count` | Integer | No |
| `only_new_members` | Boolean | No |
| `was_refunded` | Boolean | No |
| `prize_description` | String | No |

## `InaccessibleMessage`

[Official object specification](https://core.telegram.org/bots/api#inaccessiblemessage)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `message_id` | Integer | Yes |
| `date` | Integer | Yes |

## `InlineKeyboardButton`

[Official object specification](https://core.telegram.org/bots/api#inlinekeyboardbutton)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |
| `icon_custom_emoji_id` | String | No |
| `style` | String | No |
| `url` | String | No |
| `callback_data` | String | No |
| `web_app` | WebAppInfo | No |
| `login_url` | LoginUrl | No |
| `switch_inline_query` | String | No |
| `switch_inline_query_current_chat` | String | No |
| `switch_inline_query_chosen_chat` | SwitchInlineQueryChosenChat | No |
| `copy_text` | CopyTextButton | No |
| `callback_game` | CallbackGame | No |
| `pay` | Boolean | No |
| `disabled` | DisabledButton | No |

## `InlineKeyboardMarkup`

[Official object specification](https://core.telegram.org/bots/api#inlinekeyboardmarkup)

| Field | Type | Required |
|---|---|---|
| `inline_keyboard` | Array of Array of InlineKeyboardButton | Yes |
| `force_reply` | Boolean | No |

## `InlineQuery`

[Official object specification](https://core.telegram.org/bots/api#inlinequery)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `from` | User | Yes |
| `query` | String | Yes |
| `offset` | String | Yes |
| `chat_type` | String | No |
| `location` | Location | No |

## `InlineQueryResult`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresult)

Implementations: `InlineQueryResultCachedAudio`, `InlineQueryResultCachedDocument`, `InlineQueryResultCachedGif`, `InlineQueryResultCachedMpeg4Gif`, `InlineQueryResultCachedPhoto`, `InlineQueryResultCachedSticker`, `InlineQueryResultCachedVideo`, `InlineQueryResultCachedVoice`, `InlineQueryResultArticle`, `InlineQueryResultAudio`, `InlineQueryResultContact`, `InlineQueryResultGame`, `InlineQueryResultDocument`, `InlineQueryResultGif`, `InlineQueryResultLocation`, `InlineQueryResultMpeg4Gif`, `InlineQueryResultPhoto`, `InlineQueryResultVenue`, `InlineQueryResultVideo`, `InlineQueryResultVoice`.

## `InlineQueryResultArticle`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultarticle)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `title` | String | Yes |
| `input_message_content` | InputMessageContent | Yes |
| `reply_markup` | InlineKeyboardMarkup | No |
| `url` | String | No |
| `description` | String | No |
| `thumbnail_url` | String | No |
| `thumbnail_width` | Integer | No |
| `thumbnail_height` | Integer | No |

## `InlineQueryResultAudio`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultaudio)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `audio_url` | String | Yes |
| `title` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `performer` | String | No |
| `audio_duration` | Integer | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedAudio`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedaudio)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `audio_file_id` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedDocument`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcacheddocument)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `title` | String | Yes |
| `document_file_id` | String | Yes |
| `description` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedGif`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedgif)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `gif_file_id` | String | Yes |
| `title` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedMpeg4Gif`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedmpeg4gif)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `mpeg4_file_id` | String | Yes |
| `title` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedPhoto`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `photo_file_id` | String | Yes |
| `title` | String | No |
| `description` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedSticker`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedsticker)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `sticker_file_id` | String | Yes |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedVideo`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedvideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `video_file_id` | String | Yes |
| `title` | String | Yes |
| `description` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultCachedVoice`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcachedvoice)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `voice_file_id` | String | Yes |
| `title` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultContact`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultcontact)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `phone_number` | String | Yes |
| `first_name` | String | Yes |
| `last_name` | String | No |
| `vcard` | String | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |
| `thumbnail_url` | String | No |
| `thumbnail_width` | Integer | No |
| `thumbnail_height` | Integer | No |

## `InlineQueryResultDocument`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultdocument)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `title` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `document_url` | String | Yes |
| `mime_type` | String | Yes |
| `description` | String | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |
| `thumbnail_url` | String | No |
| `thumbnail_width` | Integer | No |
| `thumbnail_height` | Integer | No |

## `InlineQueryResultGame`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultgame)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `game_short_name` | String | Yes |
| `reply_markup` | InlineKeyboardMarkup | No |

## `InlineQueryResultGif`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultgif)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `gif_url` | String | Yes |
| `gif_width` | Integer | No |
| `gif_height` | Integer | No |
| `gif_duration` | Integer | No |
| `thumbnail_url` | String | Yes |
| `thumbnail_mime_type` | String | No |
| `title` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultLocation`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultlocation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `title` | String | Yes |
| `horizontal_accuracy` | Float | No |
| `live_period` | Integer | No |
| `heading` | Integer | No |
| `proximity_alert_radius` | Integer | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |
| `thumbnail_url` | String | No |
| `thumbnail_width` | Integer | No |
| `thumbnail_height` | Integer | No |

## `InlineQueryResultMpeg4Gif`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultmpeg4gif)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `mpeg4_url` | String | Yes |
| `mpeg4_width` | Integer | No |
| `mpeg4_height` | Integer | No |
| `mpeg4_duration` | Integer | No |
| `thumbnail_url` | String | Yes |
| `thumbnail_mime_type` | String | No |
| `title` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultPhoto`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `photo_url` | String | Yes |
| `thumbnail_url` | String | Yes |
| `photo_width` | Integer | No |
| `photo_height` | Integer | No |
| `title` | String | No |
| `description` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultsButton`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultsbutton)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |
| `web_app` | WebAppInfo | No |
| `start_parameter` | String | No |

## `InlineQueryResultVenue`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultvenue)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `title` | String | Yes |
| `address` | String | Yes |
| `foursquare_id` | String | No |
| `foursquare_type` | String | No |
| `google_place_id` | String | No |
| `google_place_type` | String | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |
| `thumbnail_url` | String | No |
| `thumbnail_width` | Integer | No |
| `thumbnail_height` | Integer | No |

## `InlineQueryResultVideo`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultvideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `video_url` | String | Yes |
| `mime_type` | String | Yes |
| `thumbnail_url` | String | Yes |
| `title` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `video_width` | Integer | No |
| `video_height` | Integer | No |
| `video_duration` | Integer | No |
| `description` | String | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InlineQueryResultVoice`

[Official object specification](https://core.telegram.org/bots/api#inlinequeryresultvoice)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `id` | String | Yes |
| `voice_url` | String | Yes |
| `title` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `voice_duration` | Integer | No |
| `reply_markup` | InlineKeyboardMarkup | No |
| `input_message_content` | InputMessageContent | No |

## `InputChecklist`

[Official object specification](https://core.telegram.org/bots/api#inputchecklist)

| Field | Type | Required |
|---|---|---|
| `title` | String | Yes |
| `parse_mode` | String | No |
| `title_entities` | Array of MessageEntity | No |
| `tasks` | Array of InputChecklistTask | Yes |
| `others_can_add_tasks` | Boolean | No |
| `others_can_mark_tasks_as_done` | Boolean | No |

## `InputChecklistTask`

[Official object specification](https://core.telegram.org/bots/api#inputchecklisttask)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `text` | String | Yes |
| `parse_mode` | String | No |
| `text_entities` | Array of MessageEntity | No |

## `InputContactMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputcontactmessagecontent)

| Field | Type | Required |
|---|---|---|
| `phone_number` | String | Yes |
| `first_name` | String | Yes |
| `last_name` | String | No |
| `vcard` | String | No |

## `InputFile`

[Official object specification](https://core.telegram.org/bots/api#inputfile)

## `InputInvoiceMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputinvoicemessagecontent)

| Field | Type | Required |
|---|---|---|
| `title` | String | Yes |
| `description` | String | Yes |
| `payload` | String | Yes |
| `provider_token` | String | No |
| `currency` | String | Yes |
| `prices` | Array of LabeledPrice | Yes |
| `max_tip_amount` | Integer | No |
| `suggested_tip_amounts` | Array of Integer | No |
| `provider_data` | String | No |
| `photo_url` | String | No |
| `photo_size` | Integer | No |
| `photo_width` | Integer | No |
| `photo_height` | Integer | No |
| `need_name` | Boolean | No |
| `need_phone_number` | Boolean | No |
| `need_email` | Boolean | No |
| `need_shipping_address` | Boolean | No |
| `send_phone_number_to_provider` | Boolean | No |
| `send_email_to_provider` | Boolean | No |
| `is_flexible` | Boolean | No |

## `InputLocationMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputlocationmessagecontent)

| Field | Type | Required |
|---|---|---|
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `horizontal_accuracy` | Float | No |
| `live_period` | Integer | No |
| `heading` | Integer | No |
| `proximity_alert_radius` | Integer | No |

## `InputMedia`

[Official object specification](https://core.telegram.org/bots/api#inputmedia)

Implementations: `InputMediaAnimation`, `InputMediaAudio`, `InputMediaDocument`, `InputMediaLivePhoto`, `InputMediaPhoto`, `InputMediaVideo`.

## `InputMediaAnimation`

[Official object specification](https://core.telegram.org/bots/api#inputmediaanimation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `thumbnail` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `width` | Integer | No |
| `height` | Integer | No |
| `duration` | Integer | No |
| `has_spoiler` | Boolean | No |

## `InputMediaAudio`

[Official object specification](https://core.telegram.org/bots/api#inputmediaaudio)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `thumbnail` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `duration` | Integer | No |
| `performer` | String | No |
| `title` | String | No |

## `InputMediaDocument`

[Official object specification](https://core.telegram.org/bots/api#inputmediadocument)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `thumbnail` | String | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `disable_content_type_detection` | Boolean | No |

## `InputMediaLink`

[Official object specification](https://core.telegram.org/bots/api#inputmedialink)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `url` | String | Yes |

## `InputMediaLivePhoto`

[Official object specification](https://core.telegram.org/bots/api#inputmedialivephoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `photo` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `has_spoiler` | Boolean | No |

## `InputMediaLocation`

[Official object specification](https://core.telegram.org/bots/api#inputmedialocation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `horizontal_accuracy` | Float | No |

## `InputMediaPhoto`

[Official object specification](https://core.telegram.org/bots/api#inputmediaphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `has_spoiler` | Boolean | No |

## `InputMediaSticker`

[Official object specification](https://core.telegram.org/bots/api#inputmediasticker)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `emoji` | String | No |

## `InputMediaVenue`

[Official object specification](https://core.telegram.org/bots/api#inputmediavenue)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `title` | String | Yes |
| `address` | String | Yes |
| `foursquare_id` | String | No |
| `foursquare_type` | String | No |
| `google_place_id` | String | No |
| `google_place_type` | String | No |

## `InputMediaVideo`

[Official object specification](https://core.telegram.org/bots/api#inputmediavideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `thumbnail` | String | No |
| `cover` | String | No |
| `start_timestamp` | Integer | No |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `width` | Integer | No |
| `height` | Integer | No |
| `duration` | Integer | No |
| `supports_streaming` | Boolean | No |
| `has_spoiler` | Boolean | No |

## `InputMediaVoiceNote`

[Official object specification](https://core.telegram.org/bots/api#inputmediavoicenote)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `caption` | String | No |
| `parse_mode` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `duration` | Integer | No |

## `InputMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputmessagecontent)

Implementations: `InputTextMessageContent`, `InputRichMessageContent`, `InputLocationMessageContent`, `InputVenueMessageContent`, `InputContactMessageContent`, `InputInvoiceMessageContent`.

## `InputPaidMedia`

[Official object specification](https://core.telegram.org/bots/api#inputpaidmedia)

Implementations: `InputPaidMediaLivePhoto`, `InputPaidMediaPhoto`, `InputPaidMediaVideo`.

## `InputPaidMediaLivePhoto`

[Official object specification](https://core.telegram.org/bots/api#inputpaidmedialivephoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `photo` | String | Yes |

## `InputPaidMediaPhoto`

[Official object specification](https://core.telegram.org/bots/api#inputpaidmediaphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |

## `InputPaidMediaVideo`

[Official object specification](https://core.telegram.org/bots/api#inputpaidmediavideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `media` | String | Yes |
| `thumbnail` | String | No |
| `cover` | String | No |
| `start_timestamp` | Integer | No |
| `width` | Integer | No |
| `height` | Integer | No |
| `duration` | Integer | No |
| `supports_streaming` | Boolean | No |

## `InputPollMedia`

[Official object specification](https://core.telegram.org/bots/api#inputpollmedia)

Implementations: `InputMediaAnimation`, `InputMediaAudio`, `InputMediaDocument`, `InputMediaLivePhoto`, `InputMediaLocation`, `InputMediaPhoto`, `InputMediaVenue`, `InputMediaVideo`.

## `InputPollOption`

[Official object specification](https://core.telegram.org/bots/api#inputpolloption)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |
| `text_parse_mode` | String | No |
| `text_entities` | Array of MessageEntity | No |
| `media` | InputPollOptionMedia | No |

## `InputPollOptionMedia`

[Official object specification](https://core.telegram.org/bots/api#inputpolloptionmedia)

Implementations: `InputMediaAnimation`, `InputMediaLink`, `InputMediaLivePhoto`, `InputMediaLocation`, `InputMediaPhoto`, `InputMediaSticker`, `InputMediaVenue`, `InputMediaVideo`.

## `InputProfilePhoto`

[Official object specification](https://core.telegram.org/bots/api#inputprofilephoto)

Implementations: `InputProfilePhotoStatic`, `InputProfilePhotoAnimated`.

## `InputProfilePhotoAnimated`

[Official object specification](https://core.telegram.org/bots/api#inputprofilephotoanimated)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `animation` | String | Yes |
| `main_frame_timestamp` | Float | No |

## `InputProfilePhotoStatic`

[Official object specification](https://core.telegram.org/bots/api#inputprofilephotostatic)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `photo` | String | Yes |

## `InputRichBlock`

[Official object specification](https://core.telegram.org/bots/api#inputrichblock)

Implementations: `InputRichBlockParagraph`, `InputRichBlockSectionHeading`, `InputRichBlockPreformatted`, `InputRichBlockFooter`, `InputRichBlockDivider`, `InputRichBlockMathematicalExpression`, `InputRichBlockAnchor`, `InputRichBlockList`, `InputRichBlockBlockQuotation`, `InputRichBlockExpandableBlockQuotation`, `InputRichBlockPullQuotation`, `InputRichBlockCollage`, `InputRichBlockSlideshow`, `InputRichBlockTable`, `InputRichBlockDetails`, `InputRichBlockMap`, `InputRichBlockButtons`, `InputRichBlockAnimation`, `InputRichBlockAudio`, `InputRichBlockDocument`, `InputRichBlockPhoto`, `InputRichBlockVideo`, `InputRichBlockVoiceNote`, `InputRichBlockThinking`.

## `InputRichBlockAnchor`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockanchor)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `name` | String | Yes |

## `InputRichBlockAnimation`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockanimation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `animation` | InputMediaAnimation | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockAudio`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockaudio)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `audio` | InputMediaAudio | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockBlockQuotation`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockblockquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of InputRichBlock | Yes |
| `credit` | RichText | No |

## `InputRichBlockButtons`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockbuttons)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `buttons` | Array of RichMessageButton | Yes |
| `align` | String | No |

## `InputRichBlockCollage`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockcollage)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of InputRichBlock | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockDetails`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockdetails)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `summary` | RichText | Yes |
| `blocks` | Array of InputRichBlock | Yes |
| `is_open` | Boolean | No |

## `InputRichBlockDivider`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockdivider)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `InputRichBlockDocument`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockdocument)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `document` | InputMediaDocument | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockExpandableBlockQuotation`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockexpandableblockquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `credit` | RichText | No |

## `InputRichBlockFooter`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockfooter)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `InputRichBlockList`

[Official object specification](https://core.telegram.org/bots/api#inputrichblocklist)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `items` | Array of InputRichBlockListItem | Yes |

## `InputRichBlockListItem`

[Official object specification](https://core.telegram.org/bots/api#inputrichblocklistitem)

| Field | Type | Required |
|---|---|---|
| `blocks` | Array of InputRichBlock | Yes |
| `has_checkbox` | Boolean | No |
| `is_checked` | Boolean | No |
| `value` | Integer | No |
| `type` | String | No |

## `InputRichBlockMap`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockmap)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `location` | Location | Yes |
| `zoom` | Integer | No |
| `width` | Integer | No |
| `height` | Integer | No |
| `caption` | RichBlockCaption | No |

## `InputRichBlockMathematicalExpression`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockmathematicalexpression)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `expression` | String | Yes |

## `InputRichBlockParagraph`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockparagraph)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `InputRichBlockPhoto`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `photo` | InputMediaPhoto | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockPreformatted`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockpreformatted)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `language` | String | No |

## `InputRichBlockPullQuotation`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockpullquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `credit` | RichText | No |

## `InputRichBlockSectionHeading`

[Official object specification](https://core.telegram.org/bots/api#inputrichblocksectionheading)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `size` | Integer | Yes |

## `InputRichBlockSlideshow`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockslideshow)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of InputRichBlock | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockTable`

[Official object specification](https://core.telegram.org/bots/api#inputrichblocktable)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `cells` | Array of Array of RichBlockTableCell | Yes |
| `is_bordered` | Boolean | No |
| `is_striped` | Boolean | No |
| `is_compact` | Boolean | No |
| `caption` | RichText | No |

## `InputRichBlockThinking`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockthinking)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `InputRichBlockVideo`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockvideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `video` | InputMediaVideo | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichBlockVoiceNote`

[Official object specification](https://core.telegram.org/bots/api#inputrichblockvoicenote)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `voice_note` | InputMediaVoiceNote | Yes |
| `caption` | RichBlockCaption | No |

## `InputRichMessage`

[Official object specification](https://core.telegram.org/bots/api#inputrichmessage)

| Field | Type | Required |
|---|---|---|
| `blocks` | Array of InputRichBlock | No |
| `html` | String | No |
| `markdown` | String | No |
| `media` | Array of InputRichMessageMedia | No |
| `is_rtl` | Boolean | No |
| `skip_entity_detection` | Boolean | No |

## `InputRichMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputrichmessagecontent)

| Field | Type | Required |
|---|---|---|
| `rich_message` | InputRichMessage | Yes |

## `InputRichMessageMedia`

[Official object specification](https://core.telegram.org/bots/api#inputrichmessagemedia)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `media` | InputMediaAnimation or InputMediaAudio or InputMediaDocument or InputMediaPhoto or InputMediaVideo or InputMediaVoiceNote | Yes |

## `InputSticker`

[Official object specification](https://core.telegram.org/bots/api#inputsticker)

| Field | Type | Required |
|---|---|---|
| `sticker` | String | Yes |
| `format` | String | Yes |
| `emoji_list` | Array of String | Yes |
| `mask_position` | MaskPosition | No |
| `keywords` | Array of String | No |

## `InputStoryContent`

[Official object specification](https://core.telegram.org/bots/api#inputstorycontent)

Implementations: `InputStoryContentPhoto`, `InputStoryContentVideo`.

## `InputStoryContentPhoto`

[Official object specification](https://core.telegram.org/bots/api#inputstorycontentphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `photo` | String | Yes |

## `InputStoryContentVideo`

[Official object specification](https://core.telegram.org/bots/api#inputstorycontentvideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `video` | String | Yes |
| `duration` | Float | No |
| `cover_frame_timestamp` | Float | No |
| `is_animation` | Boolean | No |

## `InputTextMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputtextmessagecontent)

| Field | Type | Required |
|---|---|---|
| `message_text` | String | Yes |
| `parse_mode` | String | No |
| `entities` | Array of MessageEntity | No |
| `link_preview_options` | LinkPreviewOptions | No |

## `InputVenueMessageContent`

[Official object specification](https://core.telegram.org/bots/api#inputvenuemessagecontent)

| Field | Type | Required |
|---|---|---|
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `title` | String | Yes |
| `address` | String | Yes |
| `foursquare_id` | String | No |
| `foursquare_type` | String | No |
| `google_place_id` | String | No |
| `google_place_type` | String | No |

## `Invoice`

[Official object specification](https://core.telegram.org/bots/api#invoice)

| Field | Type | Required |
|---|---|---|
| `title` | String | Yes |
| `description` | String | Yes |
| `start_parameter` | String | Yes |
| `currency` | String | Yes |
| `total_amount` | Integer | Yes |

## `KeyboardButton`

[Official object specification](https://core.telegram.org/bots/api#keyboardbutton)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |
| `icon_custom_emoji_id` | String | No |
| `style` | String | No |
| `request_users` | KeyboardButtonRequestUsers | No |
| `request_chat` | KeyboardButtonRequestChat | No |
| `request_managed_bot` | KeyboardButtonRequestManagedBot | No |
| `request_contact` | Boolean | No |
| `request_location` | Boolean | No |
| `request_poll` | KeyboardButtonPollType | No |
| `web_app` | WebAppInfo | No |

## `KeyboardButtonPollType`

[Official object specification](https://core.telegram.org/bots/api#keyboardbuttonpolltype)

| Field | Type | Required |
|---|---|---|
| `type` | String | No |

## `KeyboardButtonRequestChat`

[Official object specification](https://core.telegram.org/bots/api#keyboardbuttonrequestchat)

| Field | Type | Required |
|---|---|---|
| `request_id` | Integer | Yes |
| `chat_is_channel` | Boolean | Yes |
| `chat_is_forum` | Boolean | No |
| `chat_has_username` | Boolean | No |
| `chat_is_created` | Boolean | No |
| `user_administrator_rights` | ChatAdministratorRights | No |
| `bot_administrator_rights` | ChatAdministratorRights | No |
| `bot_is_member` | Boolean | No |
| `request_title` | Boolean | No |
| `request_username` | Boolean | No |
| `request_photo` | Boolean | No |

## `KeyboardButtonRequestManagedBot`

[Official object specification](https://core.telegram.org/bots/api#keyboardbuttonrequestmanagedbot)

| Field | Type | Required |
|---|---|---|
| `request_id` | Integer | Yes |
| `suggested_name` | String | No |
| `suggested_username` | String | No |

## `KeyboardButtonRequestUsers`

[Official object specification](https://core.telegram.org/bots/api#keyboardbuttonrequestusers)

| Field | Type | Required |
|---|---|---|
| `request_id` | Integer | Yes |
| `user_is_bot` | Boolean | No |
| `user_is_premium` | Boolean | No |
| `max_quantity` | Integer | No |
| `request_name` | Boolean | No |
| `request_username` | Boolean | No |
| `request_photo` | Boolean | No |

## `LabeledPrice`

[Official object specification](https://core.telegram.org/bots/api#labeledprice)

| Field | Type | Required |
|---|---|---|
| `label` | String | Yes |
| `amount` | Integer | Yes |

## `Link`

[Official object specification](https://core.telegram.org/bots/api#link)

| Field | Type | Required |
|---|---|---|
| `url` | String | Yes |

## `LinkPreviewOptions`

[Official object specification](https://core.telegram.org/bots/api#linkpreviewoptions)

| Field | Type | Required |
|---|---|---|
| `is_disabled` | Boolean | No |
| `url` | String | No |
| `prefer_small_media` | Boolean | No |
| `prefer_large_media` | Boolean | No |
| `show_above_text` | Boolean | No |

## `LivePhoto`

[Official object specification](https://core.telegram.org/bots/api#livephoto)

| Field | Type | Required |
|---|---|---|
| `photo` | Array of PhotoSize | No |
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `duration` | Integer | Yes |
| `mime_type` | String | No |
| `file_size` | Integer | No |

## `Location`

[Official object specification](https://core.telegram.org/bots/api#location)

| Field | Type | Required |
|---|---|---|
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `horizontal_accuracy` | Float | No |
| `live_period` | Integer | No |
| `heading` | Integer | No |
| `proximity_alert_radius` | Integer | No |

## `LocationAddress`

[Official object specification](https://core.telegram.org/bots/api#locationaddress)

| Field | Type | Required |
|---|---|---|
| `country_code` | String | Yes |
| `state` | String | No |
| `city` | String | No |
| `street` | String | No |

## `LoginUrl`

[Official object specification](https://core.telegram.org/bots/api#loginurl)

| Field | Type | Required |
|---|---|---|
| `url` | String | Yes |
| `forward_text` | String | No |
| `bot_username` | String | No |
| `request_write_access` | Boolean | No |

## `ManagedBotCreated`

[Official object specification](https://core.telegram.org/bots/api#managedbotcreated)

| Field | Type | Required |
|---|---|---|
| `bot` | User | Yes |

## `ManagedBotUpdated`

[Official object specification](https://core.telegram.org/bots/api#managedbotupdated)

| Field | Type | Required |
|---|---|---|
| `user` | User | Yes |
| `bot` | User | Yes |

## `MaskPosition`

[Official object specification](https://core.telegram.org/bots/api#maskposition)

| Field | Type | Required |
|---|---|---|
| `point` | String | Yes |
| `x_shift` | Float | Yes |
| `y_shift` | Float | Yes |
| `scale` | Float | Yes |

## `MaybeInaccessibleMessage`

[Official object specification](https://core.telegram.org/bots/api#maybeinaccessiblemessage)

Implementations: `Message`, `InaccessibleMessage`.

## `MenuButton`

[Official object specification](https://core.telegram.org/bots/api#menubutton)

Implementations: `MenuButtonCommands`, `MenuButtonWebApp`, `MenuButtonDefault`.

## `MenuButtonCommands`

[Official object specification](https://core.telegram.org/bots/api#menubuttoncommands)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `MenuButtonDefault`

[Official object specification](https://core.telegram.org/bots/api#menubuttondefault)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `MenuButtonWebApp`

[Official object specification](https://core.telegram.org/bots/api#menubuttonwebapp)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | String | Yes |
| `web_app` | WebAppInfo | Yes |

## `Message`

[Official object specification](https://core.telegram.org/bots/api#message)

| Field | Type | Required |
|---|---|---|
| `message_id` | Integer | Yes |
| `message_thread_id` | Integer | No |
| `direct_messages_topic` | DirectMessagesTopic | No |
| `from` | User | No |
| `sender_chat` | Chat | No |
| `sender_boost_count` | Integer | No |
| `sender_business_bot` | User | No |
| `sender_tag` | String | No |
| `receiver_user` | User | No |
| `ephemeral_message_id` | Integer | No |
| `date` | Integer | Yes |
| `guest_query_id` | String | No |
| `business_connection_id` | String | No |
| `chat` | Chat | Yes |
| `forward_origin` | MessageOrigin | No |
| `is_topic_message` | Boolean | No |
| `is_automatic_forward` | Boolean | No |
| `reply_to_message` | Message | No |
| `external_reply` | ExternalReplyInfo | No |
| `quote` | TextQuote | No |
| `reply_to_story` | Story | No |
| `reply_to_checklist_task_id` | Integer | No |
| `reply_to_poll_option_id` | String | No |
| `via_bot` | User | No |
| `guest_bot_caller_user` | User | No |
| `guest_bot_caller_chat` | Chat | No |
| `edit_date` | Integer | No |
| `has_protected_content` | Boolean | No |
| `is_from_offline` | Boolean | No |
| `is_paid_post` | Boolean | No |
| `media_group_id` | String | No |
| `author_signature` | String | No |
| `paid_star_count` | Integer | No |
| `text` | String | No |
| `entities` | Array of MessageEntity | No |
| `link_preview_options` | LinkPreviewOptions | No |
| `suggested_post_info` | SuggestedPostInfo | No |
| `effect_id` | String | No |
| `rich_message` | RichMessage | No |
| `animation` | Animation | No |
| `audio` | Audio | No |
| `document` | Document | No |
| `live_photo` | LivePhoto | No |
| `paid_media` | PaidMediaInfo | No |
| `photo` | Array of PhotoSize | No |
| `sticker` | Sticker | No |
| `story` | Story | No |
| `video` | Video | No |
| `video_note` | VideoNote | No |
| `voice` | Voice | No |
| `caption` | String | No |
| `caption_entities` | Array of MessageEntity | No |
| `show_caption_above_media` | Boolean | No |
| `has_media_spoiler` | Boolean | No |
| `checklist` | Checklist | No |
| `contact` | Contact | No |
| `dice` | Dice | No |
| `game` | Game | No |
| `poll` | Poll | No |
| `venue` | Venue | No |
| `location` | Location | No |
| `new_chat_members` | Array of User | No |
| `left_chat_member` | User | No |
| `chat_owner_left` | ChatOwnerLeft | No |
| `chat_owner_changed` | ChatOwnerChanged | No |
| `new_chat_title` | String | No |
| `new_chat_photo` | Array of PhotoSize | No |
| `delete_chat_photo` | Boolean | No |
| `group_chat_created` | Boolean | No |
| `supergroup_chat_created` | Boolean | No |
| `channel_chat_created` | Boolean | No |
| `message_auto_delete_timer_changed` | MessageAutoDeleteTimerChanged | No |
| `migrate_to_chat_id` | Integer | No |
| `migrate_from_chat_id` | Integer | No |
| `pinned_message` | MaybeInaccessibleMessage | No |
| `invoice` | Invoice | No |
| `successful_payment` | SuccessfulPayment | No |
| `refunded_payment` | RefundedPayment | No |
| `users_shared` | UsersShared | No |
| `chat_shared` | ChatShared | No |
| `gift` | GiftInfo | No |
| `unique_gift` | UniqueGiftInfo | No |
| `gift_upgrade_sent` | GiftInfo | No |
| `connected_website` | String | No |
| `write_access_allowed` | WriteAccessAllowed | No |
| `passport_data` | PassportData | No |
| `proximity_alert_triggered` | ProximityAlertTriggered | No |
| `boost_added` | ChatBoostAdded | No |
| `chat_background_set` | ChatBackground | No |
| `checklist_tasks_done` | ChecklistTasksDone | No |
| `checklist_tasks_added` | ChecklistTasksAdded | No |
| `community_chat_added` | CommunityChatAdded | No |
| `community_chat_joined` | CommunityChatJoined | No |
| `community_chat_removed` | CommunityChatRemoved | No |
| `direct_message_price_changed` | DirectMessagePriceChanged | No |
| `forum_topic_created` | ForumTopicCreated | No |
| `forum_topic_edited` | ForumTopicEdited | No |
| `forum_topic_closed` | ForumTopicClosed | No |
| `forum_topic_reopened` | ForumTopicReopened | No |
| `general_forum_topic_hidden` | GeneralForumTopicHidden | No |
| `general_forum_topic_unhidden` | GeneralForumTopicUnhidden | No |
| `giveaway_created` | GiveawayCreated | No |
| `giveaway` | Giveaway | No |
| `giveaway_winners` | GiveawayWinners | No |
| `giveaway_completed` | GiveawayCompleted | No |
| `managed_bot_created` | ManagedBotCreated | No |
| `paid_message_price_changed` | PaidMessagePriceChanged | No |
| `poll_option_added` | PollOptionAdded | No |
| `poll_option_deleted` | PollOptionDeleted | No |
| `suggested_post_approved` | SuggestedPostApproved | No |
| `suggested_post_approval_failed` | SuggestedPostApprovalFailed | No |
| `suggested_post_declined` | SuggestedPostDeclined | No |
| `suggested_post_paid` | SuggestedPostPaid | No |
| `suggested_post_refunded` | SuggestedPostRefunded | No |
| `video_chat_scheduled` | VideoChatScheduled | No |
| `video_chat_started` | VideoChatStarted | No |
| `video_chat_ended` | VideoChatEnded | No |
| `video_chat_participants_invited` | VideoChatParticipantsInvited | No |
| `web_app_data` | WebAppData | No |
| `reply_markup` | InlineKeyboardMarkup | No |

## `MessageAutoDeleteTimerChanged`

[Official object specification](https://core.telegram.org/bots/api#messageautodeletetimerchanged)

| Field | Type | Required |
|---|---|---|
| `message_auto_delete_time` | Integer | Yes |

## `MessageEntity`

[Official object specification](https://core.telegram.org/bots/api#messageentity)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `offset` | Integer | Yes |
| `length` | Integer | Yes |
| `url` | String | No |
| `user` | User | No |
| `language` | String | No |
| `custom_emoji_id` | String | No |
| `unix_time` | Integer | No |
| `date_time_format` | String | No |

## `MessageGenerationStopped`

[Official object specification](https://core.telegram.org/bots/api#messagegenerationstopped)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `message_thread_id` | Integer | No |
| `draft_id` | Integer | Yes |

## `MessageId`

[Official object specification](https://core.telegram.org/bots/api#messageid)

| Field | Type | Required |
|---|---|---|
| `message_id` | Integer | Yes |

## `MessageOrigin`

[Official object specification](https://core.telegram.org/bots/api#messageorigin)

Implementations: `MessageOriginUser`, `MessageOriginHiddenUser`, `MessageOriginChat`, `MessageOriginChannel`.

## `MessageOriginChannel`

[Official object specification](https://core.telegram.org/bots/api#messageoriginchannel)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `date` | Integer | Yes |
| `chat` | Chat | Yes |
| `message_id` | Integer | Yes |
| `author_signature` | String | No |

## `MessageOriginChat`

[Official object specification](https://core.telegram.org/bots/api#messageoriginchat)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `date` | Integer | Yes |
| `sender_chat` | Chat | Yes |
| `author_signature` | String | No |

## `MessageOriginHiddenUser`

[Official object specification](https://core.telegram.org/bots/api#messageoriginhiddenuser)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `date` | Integer | Yes |
| `sender_user_name` | String | Yes |

## `MessageOriginUser`

[Official object specification](https://core.telegram.org/bots/api#messageoriginuser)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `date` | Integer | Yes |
| `sender_user` | User | Yes |

## `MessageReactionCountUpdated`

[Official object specification](https://core.telegram.org/bots/api#messagereactioncountupdated)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `message_id` | Integer | Yes |
| `date` | Integer | Yes |
| `reactions` | Array of ReactionCount | Yes |

## `MessageReactionUpdated`

[Official object specification](https://core.telegram.org/bots/api#messagereactionupdated)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `message_id` | Integer | Yes |
| `user` | User | No |
| `actor_chat` | Chat | No |
| `date` | Integer | Yes |
| `old_reaction` | Array of ReactionType | Yes |
| `new_reaction` | Array of ReactionType | Yes |

## `OrderInfo`

[Official object specification](https://core.telegram.org/bots/api#orderinfo)

| Field | Type | Required |
|---|---|---|
| `name` | String | No |
| `phone_number` | String | No |
| `email` | String | No |
| `shipping_address` | ShippingAddress | No |

## `OwnedGift`

[Official object specification](https://core.telegram.org/bots/api#ownedgift)

Implementations: `OwnedGiftRegular`, `OwnedGiftUnique`.

## `OwnedGiftRegular`

[Official object specification](https://core.telegram.org/bots/api#ownedgiftregular)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `gift` | Gift | Yes |
| `owned_gift_id` | String | No |
| `sender_user` | User | No |
| `send_date` | Integer | Yes |
| `text` | String | No |
| `entities` | Array of MessageEntity | No |
| `is_private` | Boolean | No |
| `is_saved` | Boolean | No |
| `can_be_upgraded` | Boolean | No |
| `was_refunded` | Boolean | No |
| `convert_star_count` | Integer | No |
| `prepaid_upgrade_star_count` | Integer | No |
| `is_upgrade_separate` | Boolean | No |
| `unique_gift_number` | Integer | No |

## `OwnedGifts`

[Official object specification](https://core.telegram.org/bots/api#ownedgifts)

| Field | Type | Required |
|---|---|---|
| `total_count` | Integer | Yes |
| `gifts` | Array of OwnedGift | Yes |
| `next_offset` | String | No |

## `OwnedGiftUnique`

[Official object specification](https://core.telegram.org/bots/api#ownedgiftunique)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `gift` | UniqueGift | Yes |
| `owned_gift_id` | String | No |
| `sender_user` | User | No |
| `send_date` | Integer | Yes |
| `is_saved` | Boolean | No |
| `can_be_transferred` | Boolean | No |
| `transfer_star_count` | Integer | No |
| `next_transfer_date` | Integer | No |

## `PaidMedia`

[Official object specification](https://core.telegram.org/bots/api#paidmedia)

Implementations: `PaidMediaLivePhoto`, `PaidMediaPhoto`, `PaidMediaPreview`, `PaidMediaVideo`.

## `PaidMediaInfo`

[Official object specification](https://core.telegram.org/bots/api#paidmediainfo)

| Field | Type | Required |
|---|---|---|
| `star_count` | Integer | Yes |
| `paid_media` | Array of PaidMedia | Yes |

## `PaidMediaLivePhoto`

[Official object specification](https://core.telegram.org/bots/api#paidmedialivephoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `live_photo` | LivePhoto | Yes |

## `PaidMediaPhoto`

[Official object specification](https://core.telegram.org/bots/api#paidmediaphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `photo` | Array of PhotoSize | Yes |

## `PaidMediaPreview`

[Official object specification](https://core.telegram.org/bots/api#paidmediapreview)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `width` | Integer | No |
| `height` | Integer | No |
| `duration` | Integer | No |

## `PaidMediaPurchased`

[Official object specification](https://core.telegram.org/bots/api#paidmediapurchased)

| Field | Type | Required |
|---|---|---|
| `from` | User | Yes |
| `paid_media_payload` | String | Yes |

## `PaidMediaVideo`

[Official object specification](https://core.telegram.org/bots/api#paidmediavideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `video` | Video | Yes |

## `PaidMessagePriceChanged`

[Official object specification](https://core.telegram.org/bots/api#paidmessagepricechanged)

| Field | Type | Required |
|---|---|---|
| `paid_message_star_count` | Integer | Yes |

## `PassportData`

[Official object specification](https://core.telegram.org/bots/api#passportdata)

| Field | Type | Required |
|---|---|---|
| `data` | Array of EncryptedPassportElement | Yes |
| `credentials` | EncryptedCredentials | Yes |

## `PassportElementError`

[Official object specification](https://core.telegram.org/bots/api#passportelementerror)

Implementations: `PassportElementErrorDataField`, `PassportElementErrorFrontSide`, `PassportElementErrorReverseSide`, `PassportElementErrorSelfie`, `PassportElementErrorFile`, `PassportElementErrorFiles`, `PassportElementErrorTranslationFile`, `PassportElementErrorTranslationFiles`, `PassportElementErrorUnspecified`.

## `PassportElementErrorDataField`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrordatafield)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `field_name` | String | Yes |
| `data_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorFile`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorfile)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorFiles`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorfiles)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hashes` | Array of String | Yes |
| `message` | String | Yes |

## `PassportElementErrorFrontSide`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorfrontside)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorReverseSide`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorreverseside)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorSelfie`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorselfie)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorTranslationFile`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrortranslationfile)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hash` | String | Yes |
| `message` | String | Yes |

## `PassportElementErrorTranslationFiles`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrortranslationfiles)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `file_hashes` | Array of String | Yes |
| `message` | String | Yes |

## `PassportElementErrorUnspecified`

[Official object specification](https://core.telegram.org/bots/api#passportelementerrorunspecified)

| Field | Type | Required |
|---|---|---|
| `source` | String | Yes |
| `type` | String | Yes |
| `element_hash` | String | Yes |
| `message` | String | Yes |

## `PassportFile`

[Official object specification](https://core.telegram.org/bots/api#passportfile)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `file_size` | Integer | Yes |
| `file_date` | Integer | Yes |

## `PhotoSize`

[Official object specification](https://core.telegram.org/bots/api#photosize)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `file_size` | Integer | No |

## `Poll`

[Official object specification](https://core.telegram.org/bots/api#poll)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `question` | String | Yes |
| `question_entities` | Array of MessageEntity | No |
| `options` | Array of PollOption | Yes |
| `total_voter_count` | Integer | Yes |
| `is_closed` | Boolean | Yes |
| `is_anonymous` | Boolean | Yes |
| `type` | String | Yes |
| `allows_multiple_answers` | Boolean | Yes |
| `allows_revoting` | Boolean | Yes |
| `members_only` | Boolean | Yes |
| `country_codes` | Array of String | No |
| `correct_option_ids` | Array of Integer | No |
| `explanation` | String | No |
| `explanation_entities` | Array of MessageEntity | No |
| `explanation_media` | PollMedia | No |
| `open_period` | Integer | No |
| `close_date` | Integer | No |
| `description` | String | No |
| `description_entities` | Array of MessageEntity | No |
| `media` | PollMedia | No |

## `PollAnswer`

[Official object specification](https://core.telegram.org/bots/api#pollanswer)

| Field | Type | Required |
|---|---|---|
| `poll_id` | String | Yes |
| `voter_chat` | Chat | No |
| `user` | User | No |
| `option_ids` | Array of Integer | Yes |
| `option_persistent_ids` | Array of String | Yes |

## `PollMedia`

[Official object specification](https://core.telegram.org/bots/api#pollmedia)

| Field | Type | Required |
|---|---|---|
| `animation` | Animation | No |
| `audio` | Audio | No |
| `document` | Document | No |
| `link` | Link | No |
| `live_photo` | LivePhoto | No |
| `location` | Location | No |
| `photo` | Array of PhotoSize | No |
| `sticker` | Sticker | No |
| `venue` | Venue | No |
| `video` | Video | No |

## `PollOption`

[Official object specification](https://core.telegram.org/bots/api#polloption)

| Field | Type | Required |
|---|---|---|
| `persistent_id` | String | Yes |
| `text` | String | Yes |
| `text_entities` | Array of MessageEntity | No |
| `media` | PollMedia | No |
| `voter_count` | Integer | Yes |
| `added_by_user` | User | No |
| `added_by_chat` | Chat | No |
| `addition_date` | Integer | No |

## `PollOptionAdded`

[Official object specification](https://core.telegram.org/bots/api#polloptionadded)

| Field | Type | Required |
|---|---|---|
| `poll_message` | MaybeInaccessibleMessage | No |
| `option_persistent_id` | String | Yes |
| `option_text` | String | Yes |
| `option_text_entities` | Array of MessageEntity | No |

## `PollOptionDeleted`

[Official object specification](https://core.telegram.org/bots/api#polloptiondeleted)

| Field | Type | Required |
|---|---|---|
| `poll_message` | MaybeInaccessibleMessage | No |
| `option_persistent_id` | String | Yes |
| `option_text` | String | Yes |
| `option_text_entities` | Array of MessageEntity | No |

## `PreCheckoutQuery`

[Official object specification](https://core.telegram.org/bots/api#precheckoutquery)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `from` | User | Yes |
| `currency` | String | Yes |
| `total_amount` | Integer | Yes |
| `invoice_payload` | String | Yes |
| `shipping_option_id` | String | No |
| `order_info` | OrderInfo | No |

## `PreparedInlineMessage`

[Official object specification](https://core.telegram.org/bots/api#preparedinlinemessage)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `expiration_date` | Integer | Yes |

## `PreparedKeyboardButton`

[Official object specification](https://core.telegram.org/bots/api#preparedkeyboardbutton)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |

## `ProximityAlertTriggered`

[Official object specification](https://core.telegram.org/bots/api#proximityalerttriggered)

| Field | Type | Required |
|---|---|---|
| `traveler` | User | Yes |
| `watcher` | User | Yes |
| `distance` | Integer | Yes |

## `ReactionCount`

[Official object specification](https://core.telegram.org/bots/api#reactioncount)

| Field | Type | Required |
|---|---|---|
| `type` | ReactionType | Yes |
| `total_count` | Integer | Yes |

## `ReactionType`

[Official object specification](https://core.telegram.org/bots/api#reactiontype)

Implementations: `ReactionTypeEmoji`, `ReactionTypeCustomEmoji`, `ReactionTypePaid`.

## `ReactionTypeCustomEmoji`

[Official object specification](https://core.telegram.org/bots/api#reactiontypecustomemoji)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `custom_emoji_id` | String | Yes |

## `ReactionTypeEmoji`

[Official object specification](https://core.telegram.org/bots/api#reactiontypeemoji)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `emoji` | String | Yes |

## `ReactionTypePaid`

[Official object specification](https://core.telegram.org/bots/api#reactiontypepaid)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `RefundedPayment`

[Official object specification](https://core.telegram.org/bots/api#refundedpayment)

| Field | Type | Required |
|---|---|---|
| `currency` | String | Yes |
| `total_amount` | Integer | Yes |
| `invoice_payload` | String | Yes |
| `telegram_payment_charge_id` | String | Yes |
| `provider_payment_charge_id` | String | No |

## `ReplyKeyboardMarkup`

[Official object specification](https://core.telegram.org/bots/api#replykeyboardmarkup)

| Field | Type | Required |
|---|---|---|
| `keyboard` | Array of Array of KeyboardButton | Yes |
| `is_persistent` | Boolean | No |
| `resize_keyboard` | Boolean | No |
| `one_time_keyboard` | Boolean | No |
| `input_field_placeholder` | String | No |
| `selective` | Boolean | No |
| `force_reply` | Boolean | No |

## `ReplyKeyboardRemove`

[Official object specification](https://core.telegram.org/bots/api#replykeyboardremove)

| Field | Type | Required |
|---|---|---|
| `remove_keyboard` | Boolean | Yes |
| `selective` | Boolean | No |

## `ReplyParameters`

[Official object specification](https://core.telegram.org/bots/api#replyparameters)

| Field | Type | Required |
|---|---|---|
| `message_id` | Integer | No |
| `chat_id` | Integer or String | No |
| `ephemeral_message_id` | Integer | No |
| `allow_sending_without_reply` | Boolean | No |
| `quote` | String | No |
| `quote_parse_mode` | String | No |
| `quote_entities` | Array of MessageEntity | No |
| `quote_position` | Integer | No |
| `checklist_task_id` | Integer | No |
| `poll_option_id` | String | No |

## `ResponseParameters`

[Official object specification](https://core.telegram.org/bots/api#responseparameters)

| Field | Type | Required |
|---|---|---|
| `migrate_to_chat_id` | Integer | No |
| `retry_after` | Integer | No |

## `RevenueWithdrawalState`

[Official object specification](https://core.telegram.org/bots/api#revenuewithdrawalstate)

Implementations: `RevenueWithdrawalStatePending`, `RevenueWithdrawalStateSucceeded`, `RevenueWithdrawalStateFailed`.

## `RevenueWithdrawalStateFailed`

[Official object specification](https://core.telegram.org/bots/api#revenuewithdrawalstatefailed)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `RevenueWithdrawalStatePending`

[Official object specification](https://core.telegram.org/bots/api#revenuewithdrawalstatepending)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `RevenueWithdrawalStateSucceeded`

[Official object specification](https://core.telegram.org/bots/api#revenuewithdrawalstatesucceeded)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `date` | Integer | Yes |
| `url` | String | Yes |

## `RichBlock`

[Official object specification](https://core.telegram.org/bots/api#richblock)

Implementations: `RichBlockParagraph`, `RichBlockSectionHeading`, `RichBlockPreformatted`, `RichBlockFooter`, `RichBlockDivider`, `RichBlockMathematicalExpression`, `RichBlockAnchor`, `RichBlockList`, `RichBlockBlockQuotation`, `RichBlockExpandableBlockQuotation`, `RichBlockPullQuotation`, `RichBlockCollage`, `RichBlockSlideshow`, `RichBlockTable`, `RichBlockDetails`, `RichBlockMap`, `RichBlockButtons`, `RichBlockAnimation`, `RichBlockAudio`, `RichBlockDocument`, `RichBlockPhoto`, `RichBlockVideo`, `RichBlockVoiceNote`, `RichBlockThinking`.

## `RichBlockAnchor`

[Official object specification](https://core.telegram.org/bots/api#richblockanchor)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `name` | String | Yes |

## `RichBlockAnimation`

[Official object specification](https://core.telegram.org/bots/api#richblockanimation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `animation` | Animation | Yes |
| `has_spoiler` | Boolean | No |
| `caption` | RichBlockCaption | No |

## `RichBlockAudio`

[Official object specification](https://core.telegram.org/bots/api#richblockaudio)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `audio` | Audio | Yes |
| `caption` | RichBlockCaption | No |

## `RichBlockBlockQuotation`

[Official object specification](https://core.telegram.org/bots/api#richblockblockquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of RichBlock | Yes |
| `credit` | RichText | No |

## `RichBlockButtons`

[Official object specification](https://core.telegram.org/bots/api#richblockbuttons)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `buttons` | Array of RichMessageButton | Yes |
| `align` | String | No |

## `RichBlockCaption`

[Official object specification](https://core.telegram.org/bots/api#richblockcaption)

| Field | Type | Required |
|---|---|---|
| `text` | RichText | Yes |
| `credit` | RichText | No |

## `RichBlockCollage`

[Official object specification](https://core.telegram.org/bots/api#richblockcollage)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of RichBlock | Yes |
| `caption` | RichBlockCaption | No |

## `RichBlockDetails`

[Official object specification](https://core.telegram.org/bots/api#richblockdetails)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `summary` | RichText | Yes |
| `blocks` | Array of RichBlock | Yes |
| `is_open` | Boolean | No |

## `RichBlockDivider`

[Official object specification](https://core.telegram.org/bots/api#richblockdivider)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `RichBlockDocument`

[Official object specification](https://core.telegram.org/bots/api#richblockdocument)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `document` | Document | Yes |
| `caption` | RichBlockCaption | No |

## `RichBlockExpandableBlockQuotation`

[Official object specification](https://core.telegram.org/bots/api#richblockexpandableblockquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `credit` | RichText | No |

## `RichBlockFooter`

[Official object specification](https://core.telegram.org/bots/api#richblockfooter)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichBlockList`

[Official object specification](https://core.telegram.org/bots/api#richblocklist)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `items` | Array of RichBlockListItem | Yes |

## `RichBlockListItem`

[Official object specification](https://core.telegram.org/bots/api#richblocklistitem)

| Field | Type | Required |
|---|---|---|
| `label` | String | Yes |
| `blocks` | Array of RichBlock | Yes |
| `has_checkbox` | Boolean | No |
| `is_checked` | Boolean | No |
| `value` | Integer | No |
| `type` | String | No |

## `RichBlockMap`

[Official object specification](https://core.telegram.org/bots/api#richblockmap)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `location` | Location | Yes |
| `zoom` | Integer | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `caption` | RichBlockCaption | No |

## `RichBlockMathematicalExpression`

[Official object specification](https://core.telegram.org/bots/api#richblockmathematicalexpression)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `expression` | String | Yes |

## `RichBlockParagraph`

[Official object specification](https://core.telegram.org/bots/api#richblockparagraph)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichBlockPhoto`

[Official object specification](https://core.telegram.org/bots/api#richblockphoto)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `photo` | Array of PhotoSize | Yes |
| `has_spoiler` | Boolean | No |
| `caption` | RichBlockCaption | No |

## `RichBlockPreformatted`

[Official object specification](https://core.telegram.org/bots/api#richblockpreformatted)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `language` | String | No |

## `RichBlockPullQuotation`

[Official object specification](https://core.telegram.org/bots/api#richblockpullquotation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `credit` | RichText | No |

## `RichBlockSectionHeading`

[Official object specification](https://core.telegram.org/bots/api#richblocksectionheading)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `size` | Integer | Yes |

## `RichBlockSlideshow`

[Official object specification](https://core.telegram.org/bots/api#richblockslideshow)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `blocks` | Array of RichBlock | Yes |
| `caption` | RichBlockCaption | No |

## `RichBlockTable`

[Official object specification](https://core.telegram.org/bots/api#richblocktable)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `cells` | Array of Array of RichBlockTableCell | Yes |
| `is_bordered` | Boolean | No |
| `is_striped` | Boolean | No |
| `is_compact` | Boolean | No |
| `caption` | RichText | No |

## `RichBlockTableCell`

[Official object specification](https://core.telegram.org/bots/api#richblocktablecell)

| Field | Type | Required |
|---|---|---|
| `text` | RichText | No |
| `is_header` | Boolean | No |
| `colspan` | Integer | No |
| `rowspan` | Integer | No |
| `align` | String | Yes |
| `valign` | String | Yes |

## `RichBlockThinking`

[Official object specification](https://core.telegram.org/bots/api#richblockthinking)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichBlockVideo`

[Official object specification](https://core.telegram.org/bots/api#richblockvideo)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `video` | Video | Yes |
| `has_spoiler` | Boolean | No |
| `caption` | RichBlockCaption | No |

## `RichBlockVoiceNote`

[Official object specification](https://core.telegram.org/bots/api#richblockvoicenote)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `voice_note` | Voice | Yes |
| `caption` | RichBlockCaption | No |

## `RichMessage`

[Official object specification](https://core.telegram.org/bots/api#richmessage)

| Field | Type | Required |
|---|---|---|
| `blocks` | Array of RichBlock | Yes |
| `is_rtl` | Boolean | No |

## `RichMessageButton`

[Official object specification](https://core.telegram.org/bots/api#richmessagebutton)

| Field | Type | Required |
|---|---|---|
| `text` | RichText | Yes |
| `style` | String | No |
| `url` | String | No |
| `callback_data` | String | No |
| `web_app` | WebAppInfo | No |
| `login_url` | LoginUrl | No |
| `switch_inline_query` | String | No |
| `switch_inline_query_current_chat` | String | No |
| `switch_inline_query_chosen_chat` | SwitchInlineQueryChosenChat | No |
| `copy_text` | CopyTextButton | No |
| `disabled` | DisabledButton | No |

## `RichText`

[Official object specification](https://core.telegram.org/bots/api#richtext)

Implementations: `String`, `Array of RichText`, `RichTextBold`, `RichTextItalic`, `RichTextUnderline`, `RichTextStrikethrough`, `RichTextSpoiler`, `RichTextDateTime`, `RichTextTextMention`, `RichTextSubscript`, `RichTextSuperscript`, `RichTextMarked`, `RichTextCode`, `RichTextCustomEmoji`, `RichTextMathematicalExpression`, `RichTextUrl`, `RichTextEmailAddress`, `RichTextPhoneNumber`, `RichTextBankCardNumber`, `RichTextMention`, `RichTextHashtag`, `RichTextCashtag`, `RichTextBotCommand`, `RichTextButton`, `RichTextAnchor`, `RichTextAnchorLink`, `RichTextReference`, `RichTextReferenceLink`.

## `RichTextAnchor`

[Official object specification](https://core.telegram.org/bots/api#richtextanchor)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `name` | String | Yes |

## `RichTextAnchorLink`

[Official object specification](https://core.telegram.org/bots/api#richtextanchorlink)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `anchor_name` | String | Yes |

## `RichTextBankCardNumber`

[Official object specification](https://core.telegram.org/bots/api#richtextbankcardnumber)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `bank_card_number` | String | Yes |

## `RichTextBold`

[Official object specification](https://core.telegram.org/bots/api#richtextbold)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextBotCommand`

[Official object specification](https://core.telegram.org/bots/api#richtextbotcommand)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `bot_command` | String | Yes |

## `RichTextButton`

[Official object specification](https://core.telegram.org/bots/api#richtextbutton)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `button` | RichMessageButton | Yes |

## `RichTextCashtag`

[Official object specification](https://core.telegram.org/bots/api#richtextcashtag)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `cashtag` | String | Yes |

## `RichTextCode`

[Official object specification](https://core.telegram.org/bots/api#richtextcode)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextCustomEmoji`

[Official object specification](https://core.telegram.org/bots/api#richtextcustomemoji)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `custom_emoji_id` | String | Yes |
| `alternative_text` | String | Yes |

## `RichTextDateTime`

[Official object specification](https://core.telegram.org/bots/api#richtextdatetime)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `unix_time` | Integer | Yes |
| `date_time_format` | String | Yes |

## `RichTextEmailAddress`

[Official object specification](https://core.telegram.org/bots/api#richtextemailaddress)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `email_address` | String | Yes |

## `RichTextHashtag`

[Official object specification](https://core.telegram.org/bots/api#richtexthashtag)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `hashtag` | String | Yes |

## `RichTextItalic`

[Official object specification](https://core.telegram.org/bots/api#richtextitalic)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextMarked`

[Official object specification](https://core.telegram.org/bots/api#richtextmarked)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextMathematicalExpression`

[Official object specification](https://core.telegram.org/bots/api#richtextmathematicalexpression)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `expression` | String | Yes |

## `RichTextMention`

[Official object specification](https://core.telegram.org/bots/api#richtextmention)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `username` | String | Yes |

## `RichTextPhoneNumber`

[Official object specification](https://core.telegram.org/bots/api#richtextphonenumber)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `phone_number` | String | Yes |

## `RichTextReference`

[Official object specification](https://core.telegram.org/bots/api#richtextreference)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `name` | String | Yes |

## `RichTextReferenceLink`

[Official object specification](https://core.telegram.org/bots/api#richtextreferencelink)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `reference_name` | String | Yes |

## `RichTextSpoiler`

[Official object specification](https://core.telegram.org/bots/api#richtextspoiler)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextStrikethrough`

[Official object specification](https://core.telegram.org/bots/api#richtextstrikethrough)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextSubscript`

[Official object specification](https://core.telegram.org/bots/api#richtextsubscript)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextSuperscript`

[Official object specification](https://core.telegram.org/bots/api#richtextsuperscript)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextTextMention`

[Official object specification](https://core.telegram.org/bots/api#richtexttextmention)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `user` | User | Yes |

## `RichTextUnderline`

[Official object specification](https://core.telegram.org/bots/api#richtextunderline)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |

## `RichTextUrl`

[Official object specification](https://core.telegram.org/bots/api#richtexturl)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `text` | RichText | Yes |
| `url` | String | Yes |

## `SentGuestMessage`

[Official object specification](https://core.telegram.org/bots/api#sentguestmessage)

| Field | Type | Required |
|---|---|---|
| `inline_message_id` | String | Yes |

## `SentWebAppMessage`

[Official object specification](https://core.telegram.org/bots/api#sentwebappmessage)

| Field | Type | Required |
|---|---|---|
| `inline_message_id` | String | No |

## `SharedUser`

[Official object specification](https://core.telegram.org/bots/api#shareduser)

| Field | Type | Required |
|---|---|---|
| `user_id` | Integer | Yes |
| `first_name` | String | No |
| `last_name` | String | No |
| `username` | String | No |
| `photo` | Array of PhotoSize | No |

## `ShippingAddress`

[Official object specification](https://core.telegram.org/bots/api#shippingaddress)

| Field | Type | Required |
|---|---|---|
| `country_code` | String | Yes |
| `state` | String | Yes |
| `city` | String | Yes |
| `street_line1` | String | Yes |
| `street_line2` | String | Yes |
| `post_code` | String | Yes |

## `ShippingOption`

[Official object specification](https://core.telegram.org/bots/api#shippingoption)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `title` | String | Yes |
| `prices` | Array of LabeledPrice | Yes |

## `ShippingQuery`

[Official object specification](https://core.telegram.org/bots/api#shippingquery)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `from` | User | Yes |
| `invoice_payload` | String | Yes |
| `shipping_address` | ShippingAddress | Yes |

## `StarAmount`

[Official object specification](https://core.telegram.org/bots/api#staramount)

| Field | Type | Required |
|---|---|---|
| `amount` | Integer | Yes |
| `nanostar_amount` | Integer | No |

## `StarTransaction`

[Official object specification](https://core.telegram.org/bots/api#startransaction)

| Field | Type | Required |
|---|---|---|
| `id` | String | Yes |
| `amount` | Integer | Yes |
| `nanostar_amount` | Integer | No |
| `date` | Integer | Yes |
| `source` | TransactionPartner | No |
| `receiver` | TransactionPartner | No |

## `StarTransactions`

[Official object specification](https://core.telegram.org/bots/api#startransactions)

| Field | Type | Required |
|---|---|---|
| `transactions` | Array of StarTransaction | Yes |

## `Sticker`

[Official object specification](https://core.telegram.org/bots/api#sticker)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `type` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `is_animated` | Boolean | Yes |
| `is_video` | Boolean | Yes |
| `thumbnail` | PhotoSize | No |
| `emoji` | String | No |
| `set_name` | String | No |
| `premium_animation` | File | No |
| `mask_position` | MaskPosition | No |
| `custom_emoji_id` | String | No |
| `needs_repainting` | Boolean | No |
| `file_size` | Integer | No |

## `StickerSet`

[Official object specification](https://core.telegram.org/bots/api#stickerset)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |
| `title` | String | Yes |
| `sticker_type` | String | Yes |
| `stickers` | Array of Sticker | Yes |
| `thumbnail` | PhotoSize | No |

## `Story`

[Official object specification](https://core.telegram.org/bots/api#story)

| Field | Type | Required |
|---|---|---|
| `chat` | Chat | Yes |
| `id` | Integer | Yes |

## `StoryArea`

[Official object specification](https://core.telegram.org/bots/api#storyarea)

| Field | Type | Required |
|---|---|---|
| `position` | StoryAreaPosition | Yes |
| `type` | StoryAreaType | Yes |

## `StoryAreaPosition`

[Official object specification](https://core.telegram.org/bots/api#storyareaposition)

| Field | Type | Required |
|---|---|---|
| `x_percentage` | Float | Yes |
| `y_percentage` | Float | Yes |
| `width_percentage` | Float | Yes |
| `height_percentage` | Float | Yes |
| `rotation_angle` | Float | Yes |
| `corner_radius_percentage` | Float | Yes |

## `StoryAreaType`

[Official object specification](https://core.telegram.org/bots/api#storyareatype)

Implementations: `StoryAreaTypeLocation`, `StoryAreaTypeSuggestedReaction`, `StoryAreaTypeLink`, `StoryAreaTypeWeather`, `StoryAreaTypeUniqueGift`.

## `StoryAreaTypeLink`

[Official object specification](https://core.telegram.org/bots/api#storyareatypelink)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `url` | String | Yes |

## `StoryAreaTypeLocation`

[Official object specification](https://core.telegram.org/bots/api#storyareatypelocation)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `latitude` | Float | Yes |
| `longitude` | Float | Yes |
| `address` | LocationAddress | No |

## `StoryAreaTypeSuggestedReaction`

[Official object specification](https://core.telegram.org/bots/api#storyareatypesuggestedreaction)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `reaction_type` | ReactionType | Yes |
| `is_dark` | Boolean | No |
| `is_flipped` | Boolean | No |

## `StoryAreaTypeUniqueGift`

[Official object specification](https://core.telegram.org/bots/api#storyareatypeuniquegift)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `name` | String | Yes |

## `StoryAreaTypeWeather`

[Official object specification](https://core.telegram.org/bots/api#storyareatypeweather)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `temperature` | Float | Yes |
| `emoji` | String | Yes |
| `background_color` | Integer | Yes |

## `SuccessfulPayment`

[Official object specification](https://core.telegram.org/bots/api#successfulpayment)

| Field | Type | Required |
|---|---|---|
| `currency` | String | Yes |
| `total_amount` | Integer | Yes |
| `invoice_payload` | String | Yes |
| `subscription_expiration_date` | Integer | No |
| `is_recurring` | Boolean | No |
| `is_first_recurring` | Boolean | No |
| `shipping_option_id` | String | No |
| `order_info` | OrderInfo | No |
| `telegram_payment_charge_id` | String | Yes |
| `provider_payment_charge_id` | String | Yes |

## `SuggestedPostApprovalFailed`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostapprovalfailed)

| Field | Type | Required |
|---|---|---|
| `suggested_post_message` | Message | No |
| `price` | SuggestedPostPrice | Yes |

## `SuggestedPostApproved`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostapproved)

| Field | Type | Required |
|---|---|---|
| `suggested_post_message` | Message | No |
| `price` | SuggestedPostPrice | No |
| `send_date` | Integer | Yes |

## `SuggestedPostDeclined`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostdeclined)

| Field | Type | Required |
|---|---|---|
| `suggested_post_message` | Message | No |
| `comment` | String | No |

## `SuggestedPostInfo`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostinfo)

| Field | Type | Required |
|---|---|---|
| `state` | String | Yes |
| `price` | SuggestedPostPrice | No |
| `send_date` | Integer | No |

## `SuggestedPostPaid`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostpaid)

| Field | Type | Required |
|---|---|---|
| `suggested_post_message` | Message | No |
| `currency` | String | Yes |
| `amount` | Integer | No |
| `star_amount` | StarAmount | No |

## `SuggestedPostParameters`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostparameters)

| Field | Type | Required |
|---|---|---|
| `price` | SuggestedPostPrice | No |
| `send_date` | Integer | No |

## `SuggestedPostPrice`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostprice)

| Field | Type | Required |
|---|---|---|
| `currency` | String | Yes |
| `amount` | Integer | Yes |

## `SuggestedPostRefunded`

[Official object specification](https://core.telegram.org/bots/api#suggestedpostrefunded)

| Field | Type | Required |
|---|---|---|
| `suggested_post_message` | Message | No |
| `reason` | String | Yes |

## `SwitchInlineQueryChosenChat`

[Official object specification](https://core.telegram.org/bots/api#switchinlinequerychosenchat)

| Field | Type | Required |
|---|---|---|
| `query` | String | No |
| `allow_user_chats` | Boolean | No |
| `allow_bot_chats` | Boolean | No |
| `allow_group_chats` | Boolean | No |
| `allow_channel_chats` | Boolean | No |

## `TextQuote`

[Official object specification](https://core.telegram.org/bots/api#textquote)

| Field | Type | Required |
|---|---|---|
| `text` | String | Yes |
| `entities` | Array of MessageEntity | No |
| `position` | Integer | Yes |
| `is_manual` | Boolean | No |

## `TransactionPartner`

[Official object specification](https://core.telegram.org/bots/api#transactionpartner)

Implementations: `TransactionPartnerUser`, `TransactionPartnerChat`, `TransactionPartnerAffiliateProgram`, `TransactionPartnerFragment`, `TransactionPartnerTelegramAds`, `TransactionPartnerTelegramApi`, `TransactionPartnerOther`.

## `TransactionPartnerAffiliateProgram`

[Official object specification](https://core.telegram.org/bots/api#transactionpartneraffiliateprogram)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `sponsor_user` | User | No |
| `commission_per_mille` | Integer | Yes |

## `TransactionPartnerChat`

[Official object specification](https://core.telegram.org/bots/api#transactionpartnerchat)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `chat` | Chat | Yes |
| `gift` | Gift | No |

## `TransactionPartnerFragment`

[Official object specification](https://core.telegram.org/bots/api#transactionpartnerfragment)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `withdrawal_state` | RevenueWithdrawalState | No |

## `TransactionPartnerOther`

[Official object specification](https://core.telegram.org/bots/api#transactionpartnerother)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `TransactionPartnerTelegramAds`

[Official object specification](https://core.telegram.org/bots/api#transactionpartnertelegramads)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |

## `TransactionPartnerTelegramApi`

[Official object specification](https://core.telegram.org/bots/api#transactionpartnertelegramapi)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `request_count` | Integer | Yes |

## `TransactionPartnerUser`

[Official object specification](https://core.telegram.org/bots/api#transactionpartneruser)

| Field | Type | Required |
|---|---|---|
| `type` | String | Yes |
| `transaction_type` | String | Yes |
| `user` | User | Yes |
| `affiliate` | AffiliateInfo | No |
| `invoice_payload` | String | No |
| `subscription_period` | Integer | No |
| `paid_media` | Array of PaidMedia | No |
| `paid_media_payload` | String | No |
| `gift` | Gift | No |
| `premium_subscription_duration` | Integer | No |

## `UniqueGift`

[Official object specification](https://core.telegram.org/bots/api#uniquegift)

| Field | Type | Required |
|---|---|---|
| `gift_id` | String | Yes |
| `base_name` | String | Yes |
| `name` | String | Yes |
| `number` | Integer | Yes |
| `model` | UniqueGiftModel | Yes |
| `symbol` | UniqueGiftSymbol | Yes |
| `backdrop` | UniqueGiftBackdrop | Yes |
| `is_premium` | Boolean | No |
| `is_burned` | Boolean | No |
| `is_from_blockchain` | Boolean | No |
| `colors` | UniqueGiftColors | No |
| `publisher_chat` | Chat | No |

## `UniqueGiftBackdrop`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftbackdrop)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |
| `colors` | UniqueGiftBackdropColors | Yes |
| `rarity_per_mille` | Integer | Yes |

## `UniqueGiftBackdropColors`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftbackdropcolors)

| Field | Type | Required |
|---|---|---|
| `center_color` | Integer | Yes |
| `edge_color` | Integer | Yes |
| `symbol_color` | Integer | Yes |
| `text_color` | Integer | Yes |

## `UniqueGiftColors`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftcolors)

| Field | Type | Required |
|---|---|---|
| `model_custom_emoji_id` | String | Yes |
| `symbol_custom_emoji_id` | String | Yes |
| `light_theme_main_color` | Integer | Yes |
| `light_theme_other_colors` | Array of Integer | Yes |
| `dark_theme_main_color` | Integer | Yes |
| `dark_theme_other_colors` | Array of Integer | Yes |

## `UniqueGiftInfo`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftinfo)

| Field | Type | Required |
|---|---|---|
| `gift` | UniqueGift | Yes |
| `origin` | String | Yes |
| `text` | String | No |
| `entities` | Array of MessageEntity | No |
| `is_private` | Boolean | No |
| `last_resale_currency` | String | No |
| `last_resale_amount` | Integer | No |
| `owned_gift_id` | String | No |
| `transfer_star_count` | Integer | No |
| `next_transfer_date` | Integer | No |

## `UniqueGiftModel`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftmodel)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |
| `sticker` | Sticker | Yes |
| `rarity_per_mille` | Integer | Yes |
| `rarity` | String | No |

## `UniqueGiftSymbol`

[Official object specification](https://core.telegram.org/bots/api#uniquegiftsymbol)

| Field | Type | Required |
|---|---|---|
| `name` | String | Yes |
| `sticker` | Sticker | Yes |
| `rarity_per_mille` | Integer | Yes |

## `Update`

[Official object specification](https://core.telegram.org/bots/api#update)

| Field | Type | Required |
|---|---|---|
| `update_id` | Integer | Yes |
| `message` | Message | No |
| `edited_message` | Message | No |
| `channel_post` | Message | No |
| `edited_channel_post` | Message | No |
| `business_connection` | BusinessConnection | No |
| `business_message` | Message | No |
| `edited_business_message` | Message | No |
| `deleted_business_messages` | BusinessMessagesDeleted | No |
| `guest_message` | Message | No |
| `message_reaction` | MessageReactionUpdated | No |
| `message_reaction_count` | MessageReactionCountUpdated | No |
| `inline_query` | InlineQuery | No |
| `chosen_inline_result` | ChosenInlineResult | No |
| `callback_query` | CallbackQuery | No |
| `shipping_query` | ShippingQuery | No |
| `pre_checkout_query` | PreCheckoutQuery | No |
| `purchased_paid_media` | PaidMediaPurchased | No |
| `poll` | Poll | No |
| `poll_answer` | PollAnswer | No |
| `my_chat_member` | ChatMemberUpdated | No |
| `chat_member` | ChatMemberUpdated | No |
| `chat_join_request` | ChatJoinRequest | No |
| `chat_boost` | ChatBoostUpdated | No |
| `removed_chat_boost` | ChatBoostRemoved | No |
| `managed_bot` | ManagedBotUpdated | No |
| `subscription` | BotSubscriptionUpdated | No |
| `stopped_message_generation` | MessageGenerationStopped | No |

## `User`

[Official object specification](https://core.telegram.org/bots/api#user)

| Field | Type | Required |
|---|---|---|
| `id` | Integer | Yes |
| `is_bot` | Boolean | Yes |
| `first_name` | String | Yes |
| `last_name` | String | No |
| `username` | String | No |
| `language_code` | String | No |
| `is_premium` | Boolean | No |
| `added_to_attachment_menu` | Boolean | No |
| `can_join_groups` | Boolean | No |
| `can_read_all_group_messages` | Boolean | No |
| `supports_guest_queries` | Boolean | No |
| `supports_inline_queries` | Boolean | No |
| `can_connect_to_business` | Boolean | No |
| `has_main_web_app` | Boolean | No |
| `has_topics_enabled` | Boolean | No |
| `allows_users_to_create_topics` | Boolean | No |
| `can_manage_bots` | Boolean | No |
| `supports_join_request_queries` | Boolean | No |

## `UserChatBoosts`

[Official object specification](https://core.telegram.org/bots/api#userchatboosts)

| Field | Type | Required |
|---|---|---|
| `boosts` | Array of ChatBoost | Yes |

## `UserProfileAudios`

[Official object specification](https://core.telegram.org/bots/api#userprofileaudios)

| Field | Type | Required |
|---|---|---|
| `total_count` | Integer | Yes |
| `audios` | Array of Audio | Yes |

## `UserProfilePhotos`

[Official object specification](https://core.telegram.org/bots/api#userprofilephotos)

| Field | Type | Required |
|---|---|---|
| `total_count` | Integer | Yes |
| `photos` | Array of Array of PhotoSize | Yes |

## `UserRating`

[Official object specification](https://core.telegram.org/bots/api#userrating)

| Field | Type | Required |
|---|---|---|
| `level` | Integer | Yes |
| `rating` | Integer | Yes |
| `current_level_rating` | Integer | Yes |
| `next_level_rating` | Integer | No |

## `UsersShared`

[Official object specification](https://core.telegram.org/bots/api#usersshared)

| Field | Type | Required |
|---|---|---|
| `request_id` | Integer | Yes |
| `users` | Array of SharedUser | Yes |

## `Venue`

[Official object specification](https://core.telegram.org/bots/api#venue)

| Field | Type | Required |
|---|---|---|
| `location` | Location | Yes |
| `title` | String | Yes |
| `address` | String | Yes |
| `foursquare_id` | String | No |
| `foursquare_type` | String | No |
| `google_place_id` | String | No |
| `google_place_type` | String | No |

## `Video`

[Official object specification](https://core.telegram.org/bots/api#video)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `duration` | Integer | Yes |
| `thumbnail` | PhotoSize | No |
| `cover` | Array of PhotoSize | No |
| `start_timestamp` | Integer | No |
| `qualities` | Array of VideoQuality | No |
| `file_name` | String | No |
| `mime_type` | String | No |
| `file_size` | Integer | No |

## `VideoChatEnded`

[Official object specification](https://core.telegram.org/bots/api#videochatended)

| Field | Type | Required |
|---|---|---|
| `duration` | Integer | Yes |

## `VideoChatParticipantsInvited`

[Official object specification](https://core.telegram.org/bots/api#videochatparticipantsinvited)

| Field | Type | Required |
|---|---|---|
| `users` | Array of User | Yes |

## `VideoChatScheduled`

[Official object specification](https://core.telegram.org/bots/api#videochatscheduled)

| Field | Type | Required |
|---|---|---|
| `start_date` | Integer | Yes |

## `VideoChatStarted`

[Official object specification](https://core.telegram.org/bots/api#videochatstarted)

## `VideoNote`

[Official object specification](https://core.telegram.org/bots/api#videonote)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `length` | Integer | Yes |
| `duration` | Integer | Yes |
| `thumbnail` | PhotoSize | No |
| `file_size` | Integer | No |

## `VideoQuality`

[Official object specification](https://core.telegram.org/bots/api#videoquality)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `width` | Integer | Yes |
| `height` | Integer | Yes |
| `codec` | String | Yes |
| `file_size` | Integer | No |

## `Voice`

[Official object specification](https://core.telegram.org/bots/api#voice)

| Field | Type | Required |
|---|---|---|
| `file_id` | String | Yes |
| `file_unique_id` | String | Yes |
| `duration` | Integer | Yes |
| `mime_type` | String | No |
| `file_size` | Integer | No |

## `WebAppData`

[Official object specification](https://core.telegram.org/bots/api#webappdata)

| Field | Type | Required |
|---|---|---|
| `data` | String | Yes |
| `button_text` | String | Yes |

## `WebAppInfo`

[Official object specification](https://core.telegram.org/bots/api#webappinfo)

| Field | Type | Required |
|---|---|---|
| `url` | String | Yes |

## `WebhookInfo`

[Official object specification](https://core.telegram.org/bots/api#webhookinfo)

| Field | Type | Required |
|---|---|---|
| `url` | String | Yes |
| `has_custom_certificate` | Boolean | Yes |
| `pending_update_count` | Integer | Yes |
| `ip_address` | String | No |
| `last_error_date` | Integer | No |
| `last_error_message` | String | No |
| `last_synchronization_error_date` | Integer | No |
| `max_connections` | Integer | No |
| `allowed_updates` | Array of String | No |

## `WriteAccessAllowed`

[Official object specification](https://core.telegram.org/bots/api#writeaccessallowed)

| Field | Type | Required |
|---|---|---|
| `from_request` | Boolean | No |
| `web_app_name` | String | No |
| `from_attachment_menu` | Boolean | No |

