# Advent of Code

For Julia solutions:

```sh
echo "AOC_SESSION=..." > .env   # see below
julia new.jl <day|all> [year]   # scaffold a day (or all 25) and fetch input
julia 2025/day01.jl             # run a day
```

## Getting a session cookie

Puzzle inputs are downloaded using your adventofcode.com login cookie:

1. Log into adventofcode.com in your browser.
2. Open DevTools → Application/Storage → Cookies → `https://adventofcode.com`.
3. Copy the `session` cookie value into `.env` as `AOC_SESSION=...`.

It expires after a while, at which point repeat the above.
