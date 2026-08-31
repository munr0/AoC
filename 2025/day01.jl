# https://adventofcode.com/2025/day/1


function p1()
    pos = 50
    count = 0

    for line in eachline("2025/input/day01.txt")
        move = parse(Int, replace(line, "L" => "-", "R" => "+"))
        pos = mod(pos + move, 100)
        count += (pos == 0 ? 1 : 0)
    end

    println(count)
end

function p2()
    pos = 50
    count = 0

    for line in eachline("2025/input/day01.txt")
        move = parse(Int, replace(line, "L" => "-", "R" => "+"))
        for _ in 1:abs(move)
            pos += sign(move)
            pos = mod(pos, 100)
            if pos == 0
                count += 1
            end
        end
    end

    println(count)
end

p1()
p2()
