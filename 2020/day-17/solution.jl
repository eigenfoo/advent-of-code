lines = readlines("input.txt")
slice = hcat(map(collect, lines)...)
slice = slice .== '#'

numcycles = 6
space = zeros(Bool, 2 * numcycles .+ size(slice)..., 2 * numcycles + 1)
space[7:14, 7:14, 7] = slice  # FIXME: hard coded lol

function neighborsandself(x, y, z, xmax, ymax, zmax)
    [
        max(1, x - 1):min(x + 1, xmax),
        max(1, y - 1):min(y + 1, ymax),
        max(1, z - 1):min(z + 1, zmax),
    ]
end

for _ = 1:numcycles
    global space
    newspace = zeros(Bool, size(space)...)
    for indices in CartesianIndices(space)
        indices = Tuple(indices)
        grid = neighborsandself(indices..., size(space)...)

        if (space[indices...] == false) & (sum(space[grid...]) == 3)
            newspace[indices...] = true
        elseif (space[indices...] == true) & (3 <= sum(space[grid...]) <= 4)
            newspace[indices...] = true
        end

    end
    space = newspace
end

println(sum(space))

# ---

space = zeros(Bool, 2 * numcycles .+ size(slice)..., 2 * numcycles + 1, 2 * numcycles + 1)
space[7:14, 7:14, 7, 7] = slice  # FIXME: hard coded lol

function neighborsandself4d(x, y, z, w, xmax, ymax, zmax, wmax)
    [
        max(1, x - 1):min(x + 1, xmax),
        max(1, y - 1):min(y + 1, ymax),
        max(1, z - 1):min(z + 1, zmax),
        max(1, w - 1):min(w + 1, wmax),
    ]
end

for _ = 1:numcycles
    global space
    newspace = zeros(Bool, size(space)...)
    for indices in CartesianIndices(space)
        indices = Tuple(indices)
        grid = neighborsandself4d(indices..., size(space)...)

        if (space[indices...] == false) & (sum(space[grid...]) == 3)
            newspace[indices...] = true
        elseif (space[indices...] == true) & (3 <= sum(space[grid...]) <= 4)
            newspace[indices...] = true
        end

    end
    space = newspace
end

println(sum(space))
