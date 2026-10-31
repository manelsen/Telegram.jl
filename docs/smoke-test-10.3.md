# Bot API 10.3 validation — 2026-10-31

Environment: Windows, Julia 1.12.5, HTTP 2.14.1, JSON3 1.14.4.
Baseline: `c06950eefa7e98feacb34dcc9fd9b54f69012f2b`.

## Finding and fix

`setMyProfilePhoto`, `setBusinessAccountProfilePhoto`, `addStickerToSet`, and
`replaceStickerInSet` accept structured objects under `photo` or `sticker`.
Those names also trigger multipart encoding. The baseline passed these objects
directly to `HTTP.Form`, producing Julia dictionary text rather than JSON.

The fix JSON-encodes dictionaries and named tuples in these fields, while keeping
the existing file upload dispatch. Regression tests cover dictionaries, JSON3
objects, named tuples, and a simultaneous file attachment for all four methods.
No real profile or sticker set was changed to test this fix.

## Results

| Check | Result |
| --- | --- |
| Baseline repository suite | 2,564 passed; six existing broken tests |
| Extended baseline HTTP transport check | 1,483 passed; four failures exposing the defect |
| Repository suite with fix | 2,600 passed; same six existing broken tests |
| Extended HTTP transport check with fix | 1,487 passed across 185 methods and 932 parameters |
| Additional ephemeral object/upload transport checks | Five passed on a local server |
| Live API battery on baseline | 22 cases passed, including two expected HTTP 400 errors |

The live tests covered HTML/MarkdownV2, Unicode, replies, disabled buttons,
`force_reply`, document/photo uploads, `getFile`, albums using existing file IDs,
single-option poll previews, text/rich drafts, `can_stop`, `keep_on_stop`, compact
tables, expandable quotations, rich buttons, embedded documents, rich HTML and
Markdown, `tg://document?id=` references with new uploads, and editing messages
created by the test. User-provided screenshots additionally confirmed rendering
of formatting, attachments, albums, the poll, and structured message elements.
Screenshots do not establish button interaction or quotation expansion behavior.

Comparison with the [official Bot API documentation](https://core.telegram.org/bots/api)
found the same 185 methods, 932 method parameters, 400 types, and 1,888 type fields,
with no missing/extra names or required-field mismatches. The pinned schema uses
Boolean for 94 literal True fields and a different array-union notation for one
field; descriptions retain the relevant constraints.

## Reproduce local validation

From the repository root, with dependencies installed:

```sh
julia --startup-file=no --project=. test/runtests.jl
julia --startup-file=no --project=. extras/verify_api_transport.jl
```

The extended script uses synthetic data and a loopback HTTP server. It checks
method routing and serialization, not semantic acceptance of every method by
Telegram. It does not require a real token or send requests to Telegram.

## Coverage limits

No claim of complete live coverage is made. Group ephemeral messages/callbacks,
generation-stop events, administrative permissions, communities, gifts/payments,
managed bots, Business contexts, live photos, and profile/sticker mutations still
need suitable dedicated contexts. Rich-message tests checked successful API
responses and selected response fields, not every UI behavior on every client.

Live tests used short authorized update reads without advancing the offset or
changing `allowed_updates`. No messages were deleted and no webhook was changed.
Only messages created by the battery were edited. Credentials, private chat IDs,
file IDs, conversation logs, and screenshots are intentionally absent here.
