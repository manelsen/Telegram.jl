# Repository Guidelines

> AI assistant documentation for working with Telegram.jl

## Project Overview

Telegram.jl is a Julia SDK for the [Telegram Bot API](https://core.telegram.org/bots/api). It provides:
- Complete Telegram Bot API coverage (v7.0–v9.4+)
- HTTP client abstraction with customizable query functions
- Custom TelegramLogger for logging to Telegram channels
- Bot runtime with long-polling message handling
- Decision Support features (traceability, integrity, temporal ordering)

**Package Identity**
- **Name**: Telegram
- **UUID**: `1da6f4ae-116c-4c38-8ee9-19974ff3601d`
- **Version**: 1.1.5
- **Author**: Andrey Oskin
- **License**: MIT
- **Julia Version**: ≥ 1.3

---

## Architecture & Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         User Code                                │
│   run_bot(handlers) | sendMessage(...) | TelegramLogger          │
└─────────────────────────┬───────────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────────┐
│  src/Telegram.jl (Main Module)                                   │
│  - Exports public API                                           │
│  - Imports all versioned modules (v70–v94)                      │
│  - DEFAULT_OPTS (global TelegramClient)                          │
└──────────┬─────────────────┬──────────────────┬─────────────────┘
           │                 │                  │
┌──────────▼────┐  ┌─────────▼────┐  ┌──────────▼─────┐
│  src/api.jl   │  │src/client.jl │  │  src/bot.jl    │
│  Metaprogram  │  │ TelegramClient│  │  run_bot()    │
│  @eval API    │  │   query()     │  │  Long polling │
│  generation   │  │  HTTP calls   │  │  Handlers     │
└───────────────┘  └───────┬───────┘  └────────┬──────┘
                            │                   │
              ┌─────────────▼───────────────────▼───────┐
              │           src/telegram_api.jl           │
              │     TELEGRAM_API (method registry)      │
              │     Docstrings + method metadata         │
              └───────────────────┬─────────────────────┘
                                  │
              ┌───────────────────▼───────────────────────┐
              │           src/api_versions/               │
              │  v70.jl  v72.jl  ...  v90.jl  ...  v94.jl│
              │  Versioned API method extensions         │
              └───────────────────────────────────────────┘
```

### Key Architectural Patterns

1. **Client Pattern**: `TelegramClient` holds all configuration (token, chat_id, parse_mode, endpoint, custom query_func)
2. **Global Default**: `DEFAULT_OPTS` constant; `useglobally!()` sets it; all API functions accept optional client
3. **Metaprogramming**: API methods generated at compile-time from `TELEGRAM_API` registry using `@eval`
4. **Versioned API**: Each Telegram Bot API version (v70–v94) has its own module exporting new methods
5. **HTTP Abstraction**: `query()` supports custom `query_func` for testing/mocking
6. **Logger Integration**: `TelegramLogger` implements Julia's `AbstractLogger` interface

---

## Key Directories

| Directory | Purpose |
|-----------|---------|
| `src/` | Main source code |
| `src/api_versions/` | Versioned Telegram Bot API modules (v70–v94) |
| `test/` | Test suite with numbered test files |
| `test/fixtures/` | JSON fixtures for offline testing |
| `docs/` | Documentation (Documenter.jl) |
| `docs/src/` | Markdown source files |
| `extras/` | API code generation tools |

---

## Source Files

| File | Purpose |
|------|---------|
| `src/Telegram.jl` | Main module entry point, exports public API |
| `src/client.jl` | `TelegramClient` struct, `query()`, HTTP communication |
| `src/api.jl` | API method generation via metaprogramming |
| `src/telegram_api.jl` | `TELEGRAM_API` constant with all method definitions (auto-generated) |
| `src/bot.jl` | `run_bot()` for long-polling bot execution |
| `src/logging.jl` | `TelegramLogger` implementing `AbstractLogger` |
| `src/decision_support.jl` | Traceability, integrity, temporal ordering utilities |

---

## Development Commands

### Package Management
```bash
# Activate package environment
julia --project=.

# Install dependencies
julia --project=. -e 'using Pkg; Pkg.instantiate()'

# Update dependencies
julia --project=. -e 'using Pkg; Pkg.update()'
```

### Testing
```bash
# Run all tests
julia --project=. -e 'using Pkg; Pkg.test()'

# Run specific test file
julia --project=. test/test02_api.jl

# Run tests with specific pattern
julia --project=. -e 'include("test/runtests.jl")' test07  # runs test07*.jl

# Run from REPL
using Pkg
Pkg.test(test_args=["test07"])
```

### Documentation
```bash
# Build documentation locally
julia --project=docs -e 'using Pkg; Pkg.instantiate()'
julia --project=docs docs/make.jl

# Output in docs/build/
```

### Code Generation
```bash
# Regenerate API from Telegram documentation
julia --project=extras extras/make.jl

# This updates:
# - src/telegram_api.jl
# - docs/src/reference.md
```

---

## Code Conventions

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Modules | PascalCase | `Telegram`, `DecisionSupport` |
| Types/Structs | PascalCase | `TelegramClient`, `TelegramLogger` |
| Functions | snake_case | `send_message`, `get_updates` |
| Constants | UPPER_SNAKE | `DEFAULT_OPTS`, `TELEGRAM_API` |
| Variables | snake_case | `chat_id`, `parse_mode` |

### Struct Patterns

**Immutable configuration structs:**
```julia
# src/client.jl
struct TelegramOpts
    token::String
    chat_id::Union{String, Int}
    parse_mode::Union{String, Nothing}
    endpoint::String
    query_func::Function
    traceability::Bool
end
```

**Mutable client struct:**
```julia
mutable struct TelegramClient
    token::String
    chat_id::Union{String, Int}
    parse_mode::Union{String, Nothing}
    endpoint::String
    query_func::Function
    traceability::Bool
end
```

### Error Handling

Uses standard Julia exceptions with descriptive messages:
```julia
# Client errors
if isnothing(token)
    error("Bot token is required. Set TELEGRAM_TOKEN environment variable.")
end

# API errors propagate as HTTP errors from query()
# Custom query_func can handle/transform errors
```

### Docstring Format

Methods in `telegram_api.jl` use triple-quoted docstrings with Telegram documentation:
```julia
const TELEGRAM_API = [
    # ... (generated by extras/tg_scrape.jl)
    
    ("sendMessage", """
        Use this method to send text messages. On success, the sent Message is returned.
        
        # Arguments
        - `chat_id`::Union{Int, String} : Unique identifier for the target chat
        - `text`::String : Text of the message to be sent
        ...
        """),
    # ...
]
```

### API Method Generation

Methods are generated in `src/api.jl` using `@eval`:
```julia
for (method, docstring) in TELEGRAM_API
    @eval begin
        @doc $docstring function $(Symbol(method))(args...; kwargs...)
            apiquery(args...; method=$method, kwargs...)
        end
    end
end
```

### Decision Support Standards

Module `src/decision_support.jl` implements DS-001 through DS-005:

| Standard | Purpose |
|----------|---------|
| DS-001 | Traceability: request_id, operation_id |
| DS-002 | Reproducibility: deterministic JSON ordering |
| DS-003 | Integrity: HTTPS validation, SHA256 checksums |
| DS-004 | Temporal: UTC timestamps, ISO8601 formatting |
| DS-005 | Contracts: schema versioning |

---

## Testing Patterns

### Test Structure

Tests use Julia's standard `Test` module with numbered files:
```
test/
├── runtests.jl         # Main runner, auto-discovers test files
├── TestHelpers.jl      # Shared utilities
├── test01_basic.jl     # Basic API tests
├── test02_api.jl       # API method tests
├── test03_bot.jl       # Bot lifecycle tests
├── test04_logging.jl   # Logging tests
├── test05_fault_injection.jl  # Fault injection (incomplete)
├── test06_modifier.jl  # Decision support tests
├── test07_fixtures.jl  # Fixture-based offline tests
├── test08_integration.jl  # Integration tests
└── fixtures/           # JSON fixtures
```

### Test Helpers

**MockClient** — programmatic mocking:
```julia
using Telegram
using TestHelpers

client = MockClient() do method, params
    if method == "getMe"
        return success_response("ok", get_me_response())
    end
    error_response(404, "Not Found")
end
```

**FixtureClient** — JSON file-based offline testing:
```julia
using TestHelpers

client = FixtureClient()  # Loads from test/fixtures/
result = sendMessage(client, chat_id=123, text="Hello")

### Fixture Collection & Anonymization

Fixtures are real Telegram API responses collected from a live bot and anonymized before storage:

```bash
# 1. Set credentials in .env
TELEGRAM_BOT_TOKEN=your_token
TELEGRAM_BOT_CHAT_ID=your_chat_id

# 2. Collect real fixtures (interactive - requires user interaction)
julia --project=extras extras/capture_fixtures.jl

# 3. Anonymize all fixtures in test/fixtures/
julia --project=extras extras/anonymize_fixtures.jl
```

**Scripts location**: `extras/`
- `capture_fixtures.jl` — Connects to real bot, captures API responses, saves to JSON

### Script Interativo (Recomendado)

O script `extras/interactive_collect.jl` guia você passo-a-passo através de 5 etapas:

| Etapa | Descrição |
|-------|-----------|
| 1 | **Metadados** - Coleta info do bot (sem interação) |
| 2 | **Mensagens** - Você envia mensagens de texto |
| 3 | **Mídia** - Você envia fotos, documentos, áudio |
| 4 | **Interativo** - Você cria polls, reações, localizações |
| 5 | **Livre** - 2min para capturar qualquer tipo de update |

```bash
julia --project=extras extras/interactive_collect.jl
```

O script:
1. Valida credenciais (`TELEGRAM_BOT_TOKEN`)
2. Detecta chat_id automaticamente
3. Para cada etapa, explica o que fazer no Telegram
4. Anonimiza dados automaticamente antes de salvar
5. Mostra resumo ao final com todos os arquivos coletados

**Anonymization mapping**:
| Field | Replacement |
|-------|------------|
| id, chat_id, user_id | `12345678` |
| first_name | `AnonymizedUser` |
| username | `anonymized_bot` |
| text, caption | `Anonymized message content` |
| file_id, file_unique_id | `FILE_*_ANONYMIZED_REDACTED` |
| phone_number | `+5511999999999` |
| latitude, longitude | `0.0` |

### Test Naming

Tests organized with `@testset` and tagged identifiers:
```julia
@testset "SURF-API-sendMessage" begin
    @testset "success" begin
        # ...
    end
end
```

---

## Runtime & Tooling

| Aspect | Value |
|--------|-------|
| **Runtime** | Julia ≥ 1.3 |
| **Package Manager** | Pkg (Julia's built-in) |
| **HTTP Client** | HTTP.jl (0.8–0.9, 1.x) |
| **JSON** | JSON3.jl |
| **Documentation** | Documenter.jl (custom fork: Arkoniak/Documenter.jl) |

### Key Dependencies

```toml
[compat]
julia = "1.3"
HTTP = "0.8, 0.9, 1"
JSON3 = "1"

[extras]
Test = ""

[targets]
test = ["Test"]
```

---

## CI/CD

### GitHub Actions Workflows

| Workflow | Purpose |
|----------|---------|
| `ci.yml` | Matrix testing (Julia 1.3, nightly × Ubuntu, macOS, Windows) |
| `CompatHelper.yml` | Daily dependency compatibility updates |
| `TagBot.yml` | Automated version tagging for registry |

### Testing Matrix

```yaml
strategy:
  matrix:
    julia-version: ['1.3', 'nightly']
    os: [ubuntu-latest, macos-latest, windows-latest]
    arch: [x64]
```

### Coverage

- Integrated with Codecov via `CODECOV_TOKEN` secret
- Coverage uploaded after CI runs

---

## Documentation

### Structure

```
docs/
├── make.jl           # Documenter.jl build script
└── src/
    ├── index.md      # Quick start
    ├── usage.md      # Usage guide
    ├── reference.md  # Auto-generated API reference
    └── developers.md # Developer guide
```

### Auto-Generation

API reference (`docs/src/reference.md`) is auto-generated from Telegram documentation:
```bash
julia --project=extras extras/make.jl
```

The script `extras/tg_scrape.jl` fetches from `https://core.telegram.org/bots/api` and generates:
- `src/telegram_api.jl` — method registry
- `docs/src/reference.md` — markdown documentation

---

## Important Entry Points

| Entry Point | Description |
|-------------|-------------|
| `src/Telegram.jl` | Package entry, `using Telegram` |
| `test/runtests.jl` | Test entry, `Pkg.test()` |
| `docs/make.jl` | Doc build entry |
| `extras/make.jl` | API regeneration entry |

### Quick Start

```julia
using Telegram

# Set credentials
Telegram.token!("YOUR_BOT_TOKEN")
Telegram.chatid!(123456789)

# Send message
sendMessage(text="Hello, world!")

# Or with explicit client
client = TelegramClient(token="TOKEN", chat_id=123456789)
sendMessage(client, text="Hello!")

# Run bot
run_bot() do update
    msg = update.message
    chat_id = msg.chat.id
    sendMessage(chat_id=chat_id, text="You said: $(msg.text)")
end
```
