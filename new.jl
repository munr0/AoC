# Scaffold AoC day(s). Downloads input if AOC_SESSION is set in .env.
# Usage: julia new.jl <day|all> [year]

using Downloads, Dates

if isfile(".env")
    for line in eachline(".env")
        k, v = split(line, "=", limit=2)
        ENV[k] = v
    end
end

if isempty(ARGS)
    println("Usage: julia new.jl <day|all> [year]")
    exit(1)
end

year = length(ARGS) >= 2 ? parse(Int, ARGS[2]) : Dates.year(Dates.now())
session = get(ENV, "AOC_SESSION", "")

function scaffold(day, year, session)
    pad = lpad(day, 2, '0')
    mkpath("$year/input")

    inputfile = "$year/input/day$pad.txt"
    if !isfile(inputfile) && !isempty(session)
        try
            Downloads.download("https://adventofcode.com/$year/day/$day/input", inputfile;
                headers=["Cookie" => "session=$session"])
            println("Downloaded $inputfile")
        catch e
            rm(inputfile, force=true)
            status = e isa Downloads.RequestError && !isnothing(e.response) ? e.response.status : nothing
            if status == 404
                return :locked
            end
            println("Failed to download input: $e")
            return :error
        end
    end

    dayfile = "$year/day$pad.jl"
    if !isfile(dayfile)
        write(
            dayfile,
            """
# https://adventofcode.com/$year/day/$day


function p1()
end

function p2()
end

p1()
p2()
"""
        )
        println("Created $dayfile")
    end
    return :ok
end

if ARGS[1] == "all"
    for day in 1:25
        if scaffold(day, year, session) == :locked
            println("Day $day, $year isn't unlocked yet, stopping.")
            break
        end
    end
else
    day = parse(Int, ARGS[1])
    if scaffold(day, year, session) == :locked
        println("Day $day, $year doesn't exist or isn't unlocked yet.")
        exit(1)
    end
end
