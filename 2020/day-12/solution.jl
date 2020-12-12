lines = readlines("input.txt")
instructions = map(x -> (first(x), parse(Int, x[2:end])), lines)

xcoord, ycoord = 0, 0
orientation = 0
directions = Dict(0 => 'E', 90 => 'N', 180 => 'W', 270 => 'S')

for instruction in instructions
    global xcoord, ycoord, orientation, directions
    action, value = instruction

    if action == 'F'
        action = directions[orientation]
    end

    if action == 'N'
        ycoord += value
    elseif action == 'S'
        ycoord -= value
    elseif action == 'E'
        xcoord += value
    elseif action == 'W'
        xcoord -= value
    elseif action == 'L'
        orientation += value
    elseif action == 'R'
        orientation -= value
    end

    orientation = rem(orientation, 360, RoundDown)
end

println(abs(xcoord) + abs(ycoord))

# ---

function turnleft(x, y, turn)
    turn = rem(turn, 360, RoundDown)
    if turn == 0
        return x, y
    elseif turn == 90
        return -y, x
    elseif turn == 180
        return -x, -y
    elseif turn == 270
        return y, -x
    end
end

waypointxcoord, waypointycoord = 10, 1
shipxcoord, shipycoord = 0, 0

for instruction in instructions
    global (waypointxcoord, waypointycoord, shipxcoord, shipycoord)
    action, value = instruction

    if action == 'F'
        shipxcoord += value * waypointxcoord
        shipycoord += value * waypointycoord
    elseif action == 'N'
        waypointycoord += value
    elseif action == 'S'
        waypointycoord -= value
    elseif action == 'E'
        waypointxcoord += value
    elseif action == 'W'
        waypointxcoord -= value
    elseif action == 'L'
        waypointxcoord, waypointycoord = turnleft(waypointxcoord, waypointycoord, value)
    elseif action == 'R'
        waypointxcoord, waypointycoord = turnleft(waypointxcoord, waypointycoord, -value)
    end
end

println(abs(shipxcoord) + abs(shipycoord))
