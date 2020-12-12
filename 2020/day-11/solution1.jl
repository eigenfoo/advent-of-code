lines = readlines("input.txt")
seats = reduce(vcat, permutedims.(collect.(lines)))
newseats = deepcopy(seats)
height, width = size(seats)

i = 0

while true
    global seats
    global newseats
    global i

    println("Running ", i)
    for row = 1:height
        for column = 1:width
            neighbors = seats[
                max(1, row - 1):min(row + 1, height),
                max(1, column - 1):min(column + 1, width),
            ]
            numoccupied =
                (count(x -> x == '#', neighbors) - count(x -> x == '#', seats[row, column]))
            if ((seats[row, column] == 'L') & (numoccupied == 0))
                newseats[row, column] = '#'
            elseif ((seats[row, column] == '#') & (numoccupied >= 4))
                newseats[row, column] = 'L'
            end
        end
    end

    if seats == newseats
        break
    end

    seats = deepcopy(newseats)
    i += 1
end

println(count(x -> x == '#', seats))
