# https://adventofcode.com/2025/day/2


function p1()
    first_digits(x::Int, n::Int) = x ÷ 10^(ndigits(x) - n)
    invalids = []

    text = readchomp("2025/input/day02.txt")
    ranges = [Tuple(parse.(Int, split(pair, '-'))) for pair in split(text, ',')]

    for i in 1:size(ranges)[1]
        lower, upper = ranges[i]

        lLen = ndigits(lower)
        uLen = ndigits(upper)

        sub_ranges = [lower]
        if lLen != uLen
            for i in lLen:(uLen-1)
                push!(sub_ranges, 10^i-1)
                push!(sub_ranges, 10^i)
            end
        end
        push!(sub_ranges, upper)

        filter!(x -> iseven(ndigits(x)), sub_ranges)    # implicit that pattern requires even digits

        for i in 1:2:(length(sub_ranges))
            halfDigs = ndigits(sub_ranges[i]) ÷ 2

            for seq in first_digits(sub_ranges[i], halfDigs):first_digits(sub_ranges[i+1], halfDigs)
                candidate = seq + seq * 10^halfDigs
                if candidate >= sub_ranges[i] && candidate <= sub_ranges[i+1]
                    push!(invalids, candidate)
                end
            end
        end
    end

    println(sum(invalids))
end


function p2()
    first_digits(x::Int, n::Int) = x ÷ 10^(ndigits(x) - n)
    invalids = []

    text = readchomp("2025/input/day02.txt")
    ranges = [Tuple(parse.(Int, split(pair, '-'))) for pair in split(text, ',')]

    for i in 1:size(ranges)[1]
        lower, upper = ranges[i]

        lLen = ndigits(lower)
        uLen = ndigits(upper)

        sub_ranges = [lower]
        if lLen != uLen
            for i in lLen:(uLen-1)
                push!(sub_ranges, 10^i-1)
                push!(sub_ranges, 10^i)
            end
        end
        push!(sub_ranges, upper)

        for i in 1:2:(length(sub_ranges))
            digs = ndigits(sub_ranges[i])
            factors = [j for j in 2:digs if digs % j == 0]
            found = Set{Int}()  # count 111111, etc only once

            for factor in factors
                seq_digs = digs÷factor
                for seq in first_digits(sub_ranges[i], seq_digs):first_digits(sub_ranges[i+1], seq_digs)
                    candidate = sum(seq * 10^(seq_digs*k) for k in 0:(factor-1))
                    if candidate >= sub_ranges[i] && candidate <= sub_ranges[i+1]
                        push!(found, candidate)
                    end
                end
            end
            append!(invalids, found)
        end
    end
    println(sum(invalids))
end

p1()
p2()
