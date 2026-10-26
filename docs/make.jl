using Telegram
using Documenter

makedocs(;
    modules=[Telegram],
    authors="Andrey Oskin",
    repo="https://github.com/manelsen/Telegram.jl/blob/{commit}{path}#L{line}",
    sitename="Telegram.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://manelsen.github.io/Telegram.jl",
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
