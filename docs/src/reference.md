```@meta
CurrentModule = Telegram.API
```

# Bot API 10.3 Reference

This page is generated from the pinned Bot API 10.3 specification (August 24, 2026).
Use `using Telegram, Telegram.API`; every method accepts an optional `TelegramClient`
and keyword parameters matching the Telegram Bot API. Responses use dynamic `JSON3.Object`
or arrays; type declarations are documented separately.

See the [official Telegram Bot API](https://core.telegram.org/bots/api) for protocol details.

## Methods

- [`addStickerToSet`](https://core.telegram.org/bots/api#addstickertoset)
- [`answerCallbackQuery`](https://core.telegram.org/bots/api#answercallbackquery)
- [`answerChatJoinRequestQuery`](https://core.telegram.org/bots/api#answerchatjoinrequestquery)
- [`answerGuestQuery`](https://core.telegram.org/bots/api#answerguestquery)
- [`answerInlineQuery`](https://core.telegram.org/bots/api#answerinlinequery)
- [`answerPreCheckoutQuery`](https://core.telegram.org/bots/api#answerprecheckoutquery)
- [`answerShippingQuery`](https://core.telegram.org/bots/api#answershippingquery)
- [`answerWebAppQuery`](https://core.telegram.org/bots/api#answerwebappquery)
- [`approveChatJoinRequest`](https://core.telegram.org/bots/api#approvechatjoinrequest)
- [`approveSuggestedPost`](https://core.telegram.org/bots/api#approvesuggestedpost)
- [`banChatMember`](https://core.telegram.org/bots/api#banchatmember)
- [`banChatSenderChat`](https://core.telegram.org/bots/api#banchatsenderchat)
- [`close`](https://core.telegram.org/bots/api#close)
- [`closeForumTopic`](https://core.telegram.org/bots/api#closeforumtopic)
- [`closeGeneralForumTopic`](https://core.telegram.org/bots/api#closegeneralforumtopic)
- [`convertGiftToStars`](https://core.telegram.org/bots/api#convertgifttostars)
- [`copyMessage`](https://core.telegram.org/bots/api#copymessage)
- [`copyMessages`](https://core.telegram.org/bots/api#copymessages)
- [`createChatInviteLink`](https://core.telegram.org/bots/api#createchatinvitelink)
- [`createChatSubscriptionInviteLink`](https://core.telegram.org/bots/api#createchatsubscriptioninvitelink)
- [`createForumTopic`](https://core.telegram.org/bots/api#createforumtopic)
- [`createInvoiceLink`](https://core.telegram.org/bots/api#createinvoicelink)
- [`createNewStickerSet`](https://core.telegram.org/bots/api#createnewstickerset)
- [`declineChatJoinRequest`](https://core.telegram.org/bots/api#declinechatjoinrequest)
- [`declineSuggestedPost`](https://core.telegram.org/bots/api#declinesuggestedpost)
- [`deleteAllMessageReactions`](https://core.telegram.org/bots/api#deleteallmessagereactions)
- [`deleteBusinessMessages`](https://core.telegram.org/bots/api#deletebusinessmessages)
- [`deleteChatPhoto`](https://core.telegram.org/bots/api#deletechatphoto)
- [`deleteChatStickerSet`](https://core.telegram.org/bots/api#deletechatstickerset)
- [`deleteEphemeralMessage`](https://core.telegram.org/bots/api#deleteephemeralmessage)
- [`deleteForumTopic`](https://core.telegram.org/bots/api#deleteforumtopic)
- [`deleteMessage`](https://core.telegram.org/bots/api#deletemessage)
- [`deleteMessageReaction`](https://core.telegram.org/bots/api#deletemessagereaction)
- [`deleteMessages`](https://core.telegram.org/bots/api#deletemessages)
- [`deleteMyCommands`](https://core.telegram.org/bots/api#deletemycommands)
- [`deleteStickerFromSet`](https://core.telegram.org/bots/api#deletestickerfromset)
- [`deleteStickerSet`](https://core.telegram.org/bots/api#deletestickerset)
- [`deleteStory`](https://core.telegram.org/bots/api#deletestory)
- [`deleteWebhook`](https://core.telegram.org/bots/api#deletewebhook)
- [`editChatInviteLink`](https://core.telegram.org/bots/api#editchatinvitelink)
- [`editChatSubscriptionInviteLink`](https://core.telegram.org/bots/api#editchatsubscriptioninvitelink)
- [`editEphemeralMessageCaption`](https://core.telegram.org/bots/api#editephemeralmessagecaption)
- [`editEphemeralMessageMedia`](https://core.telegram.org/bots/api#editephemeralmessagemedia)
- [`editEphemeralMessageReplyMarkup`](https://core.telegram.org/bots/api#editephemeralmessagereplymarkup)
- [`editEphemeralMessageText`](https://core.telegram.org/bots/api#editephemeralmessagetext)
- [`editForumTopic`](https://core.telegram.org/bots/api#editforumtopic)
- [`editGeneralForumTopic`](https://core.telegram.org/bots/api#editgeneralforumtopic)
- [`editMessageCaption`](https://core.telegram.org/bots/api#editmessagecaption)
- [`editMessageChecklist`](https://core.telegram.org/bots/api#editmessagechecklist)
- [`editMessageLiveLocation`](https://core.telegram.org/bots/api#editmessagelivelocation)
- [`editMessageMedia`](https://core.telegram.org/bots/api#editmessagemedia)
- [`editMessageReplyMarkup`](https://core.telegram.org/bots/api#editmessagereplymarkup)
- [`editMessageText`](https://core.telegram.org/bots/api#editmessagetext)
- [`editStory`](https://core.telegram.org/bots/api#editstory)
- [`editUserStarSubscription`](https://core.telegram.org/bots/api#edituserstarsubscription)
- [`exportChatInviteLink`](https://core.telegram.org/bots/api#exportchatinvitelink)
- [`forwardMessage`](https://core.telegram.org/bots/api#forwardmessage)
- [`forwardMessages`](https://core.telegram.org/bots/api#forwardmessages)
- [`getAvailableGifts`](https://core.telegram.org/bots/api#getavailablegifts)
- [`getBusinessAccountGifts`](https://core.telegram.org/bots/api#getbusinessaccountgifts)
- [`getBusinessAccountStarBalance`](https://core.telegram.org/bots/api#getbusinessaccountstarbalance)
- [`getBusinessConnection`](https://core.telegram.org/bots/api#getbusinessconnection)
- [`getChat`](https://core.telegram.org/bots/api#getchat)
- [`getChatAdministrators`](https://core.telegram.org/bots/api#getchatadministrators)
- [`getChatGifts`](https://core.telegram.org/bots/api#getchatgifts)
- [`getChatMember`](https://core.telegram.org/bots/api#getchatmember)
- [`getChatMemberCount`](https://core.telegram.org/bots/api#getchatmembercount)
- [`getChatMenuButton`](https://core.telegram.org/bots/api#getchatmenubutton)
- [`getCustomEmojiStickers`](https://core.telegram.org/bots/api#getcustomemojistickers)
- [`getFile`](https://core.telegram.org/bots/api#getfile)
- [`getForumTopicIconStickers`](https://core.telegram.org/bots/api#getforumtopiciconstickers)
- [`getGameHighScores`](https://core.telegram.org/bots/api#getgamehighscores)
- [`getManagedBotAccessSettings`](https://core.telegram.org/bots/api#getmanagedbotaccesssettings)
- [`getManagedBotToken`](https://core.telegram.org/bots/api#getmanagedbottoken)
- [`getMe`](https://core.telegram.org/bots/api#getme)
- [`getMyCommands`](https://core.telegram.org/bots/api#getmycommands)
- [`getMyDefaultAdministratorRights`](https://core.telegram.org/bots/api#getmydefaultadministratorrights)
- [`getMyDescription`](https://core.telegram.org/bots/api#getmydescription)
- [`getMyName`](https://core.telegram.org/bots/api#getmyname)
- [`getMyShortDescription`](https://core.telegram.org/bots/api#getmyshortdescription)
- [`getMyStarBalance`](https://core.telegram.org/bots/api#getmystarbalance)
- [`getStarTransactions`](https://core.telegram.org/bots/api#getstartransactions)
- [`getStickerSet`](https://core.telegram.org/bots/api#getstickerset)
- [`getUpdates`](https://core.telegram.org/bots/api#getupdates)
- [`getUserChatBoosts`](https://core.telegram.org/bots/api#getuserchatboosts)
- [`getUserGifts`](https://core.telegram.org/bots/api#getusergifts)
- [`getUserPersonalChatMessages`](https://core.telegram.org/bots/api#getuserpersonalchatmessages)
- [`getUserProfileAudios`](https://core.telegram.org/bots/api#getuserprofileaudios)
- [`getUserProfilePhotos`](https://core.telegram.org/bots/api#getuserprofilephotos)
- [`getWebhookInfo`](https://core.telegram.org/bots/api#getwebhookinfo)
- [`giftPremiumSubscription`](https://core.telegram.org/bots/api#giftpremiumsubscription)
- [`hideGeneralForumTopic`](https://core.telegram.org/bots/api#hidegeneralforumtopic)
- [`leaveChat`](https://core.telegram.org/bots/api#leavechat)
- [`logOut`](https://core.telegram.org/bots/api#logout)
- [`pinChatMessage`](https://core.telegram.org/bots/api#pinchatmessage)
- [`postStory`](https://core.telegram.org/bots/api#poststory)
- [`promoteChatMember`](https://core.telegram.org/bots/api#promotechatmember)
- [`readBusinessMessage`](https://core.telegram.org/bots/api#readbusinessmessage)
- [`refundStarPayment`](https://core.telegram.org/bots/api#refundstarpayment)
- [`removeBusinessAccountProfilePhoto`](https://core.telegram.org/bots/api#removebusinessaccountprofilephoto)
- [`removeChatVerification`](https://core.telegram.org/bots/api#removechatverification)
- [`removeMyProfilePhoto`](https://core.telegram.org/bots/api#removemyprofilephoto)
- [`removeUserVerification`](https://core.telegram.org/bots/api#removeuserverification)
- [`reopenForumTopic`](https://core.telegram.org/bots/api#reopenforumtopic)
- [`reopenGeneralForumTopic`](https://core.telegram.org/bots/api#reopengeneralforumtopic)
- [`replaceManagedBotToken`](https://core.telegram.org/bots/api#replacemanagedbottoken)
- [`replaceStickerInSet`](https://core.telegram.org/bots/api#replacestickerinset)
- [`repostStory`](https://core.telegram.org/bots/api#repoststory)
- [`restrictChatMember`](https://core.telegram.org/bots/api#restrictchatmember)
- [`revokeChatInviteLink`](https://core.telegram.org/bots/api#revokechatinvitelink)
- [`savePreparedInlineMessage`](https://core.telegram.org/bots/api#savepreparedinlinemessage)
- [`savePreparedKeyboardButton`](https://core.telegram.org/bots/api#savepreparedkeyboardbutton)
- [`sendAnimation`](https://core.telegram.org/bots/api#sendanimation)
- [`sendAudio`](https://core.telegram.org/bots/api#sendaudio)
- [`sendChatAction`](https://core.telegram.org/bots/api#sendchataction)
- [`sendChatJoinRequestWebApp`](https://core.telegram.org/bots/api#sendchatjoinrequestwebapp)
- [`sendChecklist`](https://core.telegram.org/bots/api#sendchecklist)
- [`sendContact`](https://core.telegram.org/bots/api#sendcontact)
- [`sendDice`](https://core.telegram.org/bots/api#senddice)
- [`sendDocument`](https://core.telegram.org/bots/api#senddocument)
- [`sendGame`](https://core.telegram.org/bots/api#sendgame)
- [`sendGift`](https://core.telegram.org/bots/api#sendgift)
- [`sendInvoice`](https://core.telegram.org/bots/api#sendinvoice)
- [`sendLivePhoto`](https://core.telegram.org/bots/api#sendlivephoto)
- [`sendLocation`](https://core.telegram.org/bots/api#sendlocation)
- [`sendMediaGroup`](https://core.telegram.org/bots/api#sendmediagroup)
- [`sendMessage`](https://core.telegram.org/bots/api#sendmessage)
- [`sendMessageDraft`](https://core.telegram.org/bots/api#sendmessagedraft)
- [`sendPaidMedia`](https://core.telegram.org/bots/api#sendpaidmedia)
- [`sendPhoto`](https://core.telegram.org/bots/api#sendphoto)
- [`sendPoll`](https://core.telegram.org/bots/api#sendpoll)
- [`sendRichMessage`](https://core.telegram.org/bots/api#sendrichmessage)
- [`sendRichMessageDraft`](https://core.telegram.org/bots/api#sendrichmessagedraft)
- [`sendSticker`](https://core.telegram.org/bots/api#sendsticker)
- [`sendVenue`](https://core.telegram.org/bots/api#sendvenue)
- [`sendVideo`](https://core.telegram.org/bots/api#sendvideo)
- [`sendVideoNote`](https://core.telegram.org/bots/api#sendvideonote)
- [`sendVoice`](https://core.telegram.org/bots/api#sendvoice)
- [`setBusinessAccountBio`](https://core.telegram.org/bots/api#setbusinessaccountbio)
- [`setBusinessAccountGiftSettings`](https://core.telegram.org/bots/api#setbusinessaccountgiftsettings)
- [`setBusinessAccountName`](https://core.telegram.org/bots/api#setbusinessaccountname)
- [`setBusinessAccountProfilePhoto`](https://core.telegram.org/bots/api#setbusinessaccountprofilephoto)
- [`setBusinessAccountUsername`](https://core.telegram.org/bots/api#setbusinessaccountusername)
- [`setChatAdministratorCustomTitle`](https://core.telegram.org/bots/api#setchatadministratorcustomtitle)
- [`setChatDescription`](https://core.telegram.org/bots/api#setchatdescription)
- [`setChatMemberTag`](https://core.telegram.org/bots/api#setchatmembertag)
- [`setChatMenuButton`](https://core.telegram.org/bots/api#setchatmenubutton)
- [`setChatPermissions`](https://core.telegram.org/bots/api#setchatpermissions)
- [`setChatPhoto`](https://core.telegram.org/bots/api#setchatphoto)
- [`setChatStickerSet`](https://core.telegram.org/bots/api#setchatstickerset)
- [`setChatTitle`](https://core.telegram.org/bots/api#setchattitle)
- [`setCustomEmojiStickerSetThumbnail`](https://core.telegram.org/bots/api#setcustomemojistickersetthumbnail)
- [`setGameScore`](https://core.telegram.org/bots/api#setgamescore)
- [`setManagedBotAccessSettings`](https://core.telegram.org/bots/api#setmanagedbotaccesssettings)
- [`setMessageReaction`](https://core.telegram.org/bots/api#setmessagereaction)
- [`setMyCommands`](https://core.telegram.org/bots/api#setmycommands)
- [`setMyDefaultAdministratorRights`](https://core.telegram.org/bots/api#setmydefaultadministratorrights)
- [`setMyDescription`](https://core.telegram.org/bots/api#setmydescription)
- [`setMyName`](https://core.telegram.org/bots/api#setmyname)
- [`setMyProfilePhoto`](https://core.telegram.org/bots/api#setmyprofilephoto)
- [`setMyShortDescription`](https://core.telegram.org/bots/api#setmyshortdescription)
- [`setPassportDataErrors`](https://core.telegram.org/bots/api#setpassportdataerrors)
- [`setStickerEmojiList`](https://core.telegram.org/bots/api#setstickeremojilist)
- [`setStickerKeywords`](https://core.telegram.org/bots/api#setstickerkeywords)
- [`setStickerMaskPosition`](https://core.telegram.org/bots/api#setstickermaskposition)
- [`setStickerPositionInSet`](https://core.telegram.org/bots/api#setstickerpositioninset)
- [`setStickerSetThumbnail`](https://core.telegram.org/bots/api#setstickersetthumbnail)
- [`setStickerSetTitle`](https://core.telegram.org/bots/api#setstickersettitle)
- [`setUserEmojiStatus`](https://core.telegram.org/bots/api#setuseremojistatus)
- [`setWebhook`](https://core.telegram.org/bots/api#setwebhook)
- [`stopMessageLiveLocation`](https://core.telegram.org/bots/api#stopmessagelivelocation)
- [`stopPoll`](https://core.telegram.org/bots/api#stoppoll)
- [`transferBusinessAccountStars`](https://core.telegram.org/bots/api#transferbusinessaccountstars)
- [`transferGift`](https://core.telegram.org/bots/api#transfergift)
- [`unbanChatMember`](https://core.telegram.org/bots/api#unbanchatmember)
- [`unbanChatSenderChat`](https://core.telegram.org/bots/api#unbanchatsenderchat)
- [`unhideGeneralForumTopic`](https://core.telegram.org/bots/api#unhidegeneralforumtopic)
- [`unpinAllChatMessages`](https://core.telegram.org/bots/api#unpinallchatmessages)
- [`unpinAllForumTopicMessages`](https://core.telegram.org/bots/api#unpinallforumtopicmessages)
- [`unpinAllGeneralForumTopicMessages`](https://core.telegram.org/bots/api#unpinallgeneralforumtopicmessages)
- [`unpinChatMessage`](https://core.telegram.org/bots/api#unpinchatmessage)
- [`upgradeGift`](https://core.telegram.org/bots/api#upgradegift)
- [`uploadStickerFile`](https://core.telegram.org/bots/api#uploadstickerfile)
- [`verifyChat`](https://core.telegram.org/bots/api#verifychat)
- [`verifyUser`](https://core.telegram.org/bots/api#verifyuser)

## Julia method documentation

```@docs
addStickerToSet
answerCallbackQuery
answerChatJoinRequestQuery
answerGuestQuery
answerInlineQuery
answerPreCheckoutQuery
answerShippingQuery
answerWebAppQuery
approveChatJoinRequest
approveSuggestedPost
banChatMember
banChatSenderChat
close
closeForumTopic
closeGeneralForumTopic
convertGiftToStars
copyMessage
copyMessages
createChatInviteLink
createChatSubscriptionInviteLink
createForumTopic
createInvoiceLink
createNewStickerSet
declineChatJoinRequest
declineSuggestedPost
deleteAllMessageReactions
deleteBusinessMessages
deleteChatPhoto
deleteChatStickerSet
deleteEphemeralMessage
deleteForumTopic
deleteMessage
deleteMessageReaction
deleteMessages
deleteMyCommands
deleteStickerFromSet
deleteStickerSet
deleteStory
deleteWebhook
editChatInviteLink
editChatSubscriptionInviteLink
editEphemeralMessageCaption
editEphemeralMessageMedia
editEphemeralMessageReplyMarkup
editEphemeralMessageText
editForumTopic
editGeneralForumTopic
editMessageCaption
editMessageChecklist
editMessageLiveLocation
editMessageMedia
editMessageReplyMarkup
editMessageText
editStory
editUserStarSubscription
exportChatInviteLink
forwardMessage
forwardMessages
getAvailableGifts
getBusinessAccountGifts
getBusinessAccountStarBalance
getBusinessConnection
getChat
getChatAdministrators
getChatGifts
getChatMember
getChatMemberCount
getChatMenuButton
getCustomEmojiStickers
getFile
getForumTopicIconStickers
getGameHighScores
getManagedBotAccessSettings
getManagedBotToken
getMe
getMyCommands
getMyDefaultAdministratorRights
getMyDescription
getMyName
getMyShortDescription
getMyStarBalance
getStarTransactions
getStickerSet
getUpdates
getUserChatBoosts
getUserGifts
getUserPersonalChatMessages
getUserProfileAudios
getUserProfilePhotos
getWebhookInfo
giftPremiumSubscription
hideGeneralForumTopic
leaveChat
logOut
pinChatMessage
postStory
promoteChatMember
readBusinessMessage
refundStarPayment
removeBusinessAccountProfilePhoto
removeChatVerification
removeMyProfilePhoto
removeUserVerification
reopenForumTopic
reopenGeneralForumTopic
replaceManagedBotToken
replaceStickerInSet
repostStory
restrictChatMember
revokeChatInviteLink
savePreparedInlineMessage
savePreparedKeyboardButton
sendAnimation
sendAudio
sendChatAction
sendChatJoinRequestWebApp
sendChecklist
sendContact
sendDice
sendDocument
sendGame
sendGift
sendInvoice
sendLivePhoto
sendLocation
sendMediaGroup
sendMessage
sendMessageDraft
sendPaidMedia
sendPhoto
sendPoll
sendRichMessage
sendRichMessageDraft
sendSticker
sendVenue
sendVideo
sendVideoNote
sendVoice
setBusinessAccountBio
setBusinessAccountGiftSettings
setBusinessAccountName
setBusinessAccountProfilePhoto
setBusinessAccountUsername
setChatAdministratorCustomTitle
setChatDescription
setChatMemberTag
setChatMenuButton
setChatPermissions
setChatPhoto
setChatStickerSet
setChatTitle
setCustomEmojiStickerSetThumbnail
setGameScore
setManagedBotAccessSettings
setMessageReaction
setMyCommands
setMyDefaultAdministratorRights
setMyDescription
setMyName
setMyProfilePhoto
setMyShortDescription
setPassportDataErrors
setStickerEmojiList
setStickerKeywords
setStickerMaskPosition
setStickerPositionInSet
setStickerSetThumbnail
setStickerSetTitle
setUserEmojiStatus
setWebhook
stopMessageLiveLocation
stopPoll
transferBusinessAccountStars
transferGift
unbanChatMember
unbanChatSenderChat
unhideGeneralForumTopic
unpinAllChatMessages
unpinAllForumTopicMessages
unpinAllGeneralForumTopicMessages
unpinChatMessage
upgradeGift
uploadStickerFile
verifyChat
verifyUser
```
