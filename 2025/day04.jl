# https://adventofcode.com/2025/day/4


function rolls_adjacent(grid::Array{Bool}, pos::Tuple{Int,Int})::Int
    # check for rolls in eight surrounding cells
    surrounding = 0

    (h, w) = size(grid)
    (r, c) = pos

    for di in -1:1
        for dj in -1:1
            (di, dj) == (0, 0) && continue
            i, j = r + di, c + dj
            if i>0 && i<=h && j>0 && j<=w
                if grid[i, j]
                    surrounding += 1
                end
            end
        end
    end
    return surrounding
end

function p1()
    lines = readlines("2025/input/day04.txt")
    grid = stack([cell == '@' for cell in l] for l in lines; dims=1)

    rolls_forkliftable = 0

    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            if grid[i, j] && rolls_adjacent(grid, (i, j)) < 4
                rolls_forkliftable += 1
            end
        end
    end

    println(rolls_forkliftable)
end

function p2()
    lines = readlines("2025/input/day04.txt")
    grid = stack([c == '@' for c in l] for l in lines; dims=1)
    initial = count(grid)

    was_removed = true  # do...while loop

    while was_removed == true
        was_removed = false
        for i in 1:size(grid)[1]
            for j in 1:size(grid)[2]
                if grid[i, j] && rolls_adjacent(grid, (i, j)) < 4
                    grid[i, j] = false
                    was_removed = true
                end
            end
        end
    end

    remaining = count(grid)
    removed = initial - remaining
    println(removed)
end

p1()
p2()
