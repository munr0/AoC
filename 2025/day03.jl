# https://adventofcode.com/2025/day/3


function p1()
    tot_joltage = 0

    for line::String in eachline("2025/input/day03.txt")
        bank = parse.(Int, collect(line))

        (d1, idx) = findmax(bank[1:(end-1)])
        remaining = bank[(idx+1):end]
        d2 = maximum(remaining)

        peak_joltage = evalpoly(10, (d2, d1))
        tot_joltage += peak_joltage
    end

    println(tot_joltage)
end

function p2()
    N = 12
    tot_joltage = 0

    for line::String in eachline("2025/input/day03.txt")
        bank = parse.(Int, collect(line))

        batts = zeros(Int, N)

        for i in 1:N
            (batts[i], idx) = findmax(bank[1:(end-(N-i))])
            bank = bank[(idx+1):end]
        end

        peak_joltage = evalpoly(10, reverse(batts))
        tot_joltage += peak_joltage
    end

    println(tot_joltage)
end

p1()
p2()
