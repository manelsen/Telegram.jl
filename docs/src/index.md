# Telegram.jl

**The Ultimate Julia SDK for the Telegram Bot API.**

`Telegram.jl` provides a high-level, idiomatic, and modern interface for interacting with
Telegram. It is designed to offer the best possible Developer Experience (DX) while maintaining
high performance and strict adherence to security and traceability standards.

## ✨ Key Features

- **🚀 Modern API:** Full support for Telegram Bot API 7, 8, and 9 (including Stars, Business, and Reactions).
- **🛸 Zero Boilerplate:** Uses Julia's powerful metaprogramming and macros to simplify your code.
- **🛡️ Decision Support:** Built-in traceability (DS-001) and integrity (DS-003) for auditing and compliance.
- **⚡ High Performance:** Powered by `HTTP.jl` and `JSON3.jl` for fast, non-blocking asynchronous operations.
- **☁️ DX at its Peak:** Elegant, declarative bot development using `@bot_command`.

---

## 🚀 Quick Start

To begin your Telegram journey in Julia:

```julia
using Telegram, Telegram.API

# 1. Configure your client
client = TelegramClient("YOUR_BOT_TOKEN")
useglobally!(client)

# 2. Start your bot with zero boilerplate
run_bot() do msg
    @bot_command "/start" msg begin
        sendMessage(text="Welcome to the future of Telegram SDKs! 🚀")
    end

    @bot_command "/info" msg begin
        me = getMe()
        sendMessage(text="I am $(me.first_name) (@$(me.username))")
    end
end
```

---

## 🛠️ Installation

You can install `Telegram.jl` using the Julia package manager:

```julia
using Pkg; Pkg.add("Telegram")
```

Or by entering the Pkg REPL mode (type `]`) and running:

```bash
pkg> add Telegram
```

---

## 📖 Explore More

- [Usage Guide](usage.md): Deep dive into sending messages, media, and managing chats.
- [API Reference](reference.md): Full list of functions and types.
- [Developer Guide](developers.md): How to contribute and extend the SDK.
