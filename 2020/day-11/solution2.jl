lines = readlines("input.txt")
seats = reduce(vcat, permutedims.(collect.(lines)))
newseats = deepcopy(seats)
height, width = size(seats)
increments = [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)]

i = 0

function see_seat_in_direction(seats, row, column, lrincrement, udincrement, width, height)
    i = 1
    while true
        if !(
            (1 <= row + i * lrincrement <= height) &
            (1 <= column + i * udincrement <= width)
        )
            return false
        end

        seat = seats[row+i*lrincrement, column+i*udincrement]
        if seat == '#'
            return true
        elseif seat == 'L'
            return false
        end

        i += 1
    end
end


while true
    global seats
    global newseats
    global i
    global increments

    println("Running ", i)
    for row = 1:height
        for column = 1:width
            visibleseats = [
                see_seat_in_direction(seats, row, column, lr, ud, width, height)
                for (lr, ud) in increments
            ]
            numoccupied = count(visibleseats)
            if ((seats[row, column] == 'L') & (numoccupied == 0))
                newseats[row, column] = '#'
            elseif ((seats[row, column] == '#') & (numoccupied >= 5))
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
