map = readlines("input.txt")
mapwidth = length(map[1])

down = 1
right = 3

row = 1
column = 1
numtrees = 0

while row <= length(map)
    if column > mapwidth
        global column -= mapwidth
    end

    if map[row][column] == '#'
        global numtrees += 1
    end
    global row += down
    global column += right
end

println(numtrees)

# ---

counttrees = function (down, right)
    row = 1
    column = 1
    numtrees = 0

    while row <= length(map)
        if column > mapwidth
            column -= mapwidth
        end

        if map[row][column] == '#'
            numtrees += 1
        end
        row += down
        column += right
    end
    numtrees
end

cumprod = 1
for (right, down) in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    global cumprod *= counttrees(down, right)
end

println(cumprod)
