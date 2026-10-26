using Telegram
using Documenter

makedocs(;
    modules=[Telegram],
    authors="Andrey Oskin",
    repo="https://github.com/manelsen/Telegram.jl/blob/{commit}{path}#L{line}",
    sitename="Telegram.jl",
    # Existing generated API references are incomplete; keep these diagnostics
    # visible without failing unrelated security and compatibility CI checks.
    warnonly=[:docs_block, :missing_docs, :cross_references],
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://manelsen.github.io/Telegram.jl",
        repolink="https://github.com/manelsen/Telegram.jl",
        # The generated API reference is ~276 KiB; retain the large-page warning.
        size_threshold=350 * 1024,
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API Reference" => "reference.md",
        "Usage" => "usage.md",
        "Developer guide" => "developers.md"
    ],
)

# Building docs in CI never grants deployment authority by itself.
if get(ENV, "DEPLOY_DOCS", "false") == "true"
    deploydocs(;
        repo="github.com/manelsen/Telegram.jl",
    )
end
