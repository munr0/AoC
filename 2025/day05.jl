
# https://adventofcode.com/2025/day/5


const INPUT = "2025/input/day05.txt"

""" Clean up overlapping ranges. """
function condense_range_list(list::Vector{Tuple{Int,Int}})
    sorted = sort(list)
    out = Tuple{Int,Int}[]
    for (lo, hi) in sorted
        if !isempty(out) && lo <= out[end][2] + 1
            out[end] = (out[end][1], max(out[end][2], hi))
        else
            push!(out, (lo, hi))
        end
    end
    return out
end

function p1()
    lines = readlines(INPUT)
    sep = findfirst(isempty, lines)

    raw_ranges = [Tuple(parse.(Int, split(line, '-'))) for line in lines[1:(sep-1)]]
    ids = parse.(Int, lines[(sep+1):end])

    tidy_ranges = condense_range_list(raw_ranges)

    count = 0

    for id in ids
        idx = searchsortedlast(tidy_ranges, id, by=first)
        is_fresh = idx > 0 && id <= tidy_ranges[idx][2]
        count += is_fresh ? 1 : 0
    end

    println(count)
end

function p2()
    lines = readlines(INPUT)
    sep = findfirst(isempty, lines)

    raw_ranges = [Tuple(parse.(Int, split(line, '-'))) for line in lines[1:(sep-1)]]

    tidy_ranges = condense_range_list(raw_ranges)

    fresh_ct = sum(map(t -> t[2] - t[1] + 1, tidy_ranges))

    println(fresh_ct)
end

p1()
p2()
