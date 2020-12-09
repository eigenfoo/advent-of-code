lines = readlines("input.txt")

visited = BitArray(undef, length(lines))
visited .= false

accumulator = 0
lineindex = 1

while true
    if visited[lineindex]
        break
    else
        visited[lineindex] = true
    end

    instruction, value = split(lines[lineindex])
    if instruction == "acc"
        global accumulator += parse(Int, value)
        global lineindex += 1
    elseif instruction == "jmp"
        global lineindex += parse(Int, value)
    elseif instruction == "nop"
        global lineindex += 1
    end
end

println(accumulator)

# ---

function terminates(modifiedlines)
    visited = BitArray(undef, length(lines))
    visited .= false

    terminated = false
    accumulator = 0
    lineindex = 1

    while true
        if lineindex == length(modifiedlines)
            terminated = true
            break
        elseif visited[lineindex]
            break
        else
            visited[lineindex] = true
        end

        instruction, value = split(modifiedlines[lineindex])
        if instruction == "acc"
            accumulator += parse(Int, value)
            lineindex += 1
        elseif instruction == "jmp"
            lineindex += parse(Int, value)
        elseif instruction == "nop"
            lineindex += 1
        end
    end

    return terminated, accumulator
end

function modify(lineindex, lines)
    modifiedlines = deepcopy(lines)
    instruction, value = split(modifiedlines[lineindex])
    if instruction == "jmp"
        modifiedlines[lineindex] = join(["nop ", value])
    elseif instruction == "nop"
        modifiedlines[lineindex] = join(["jmp ", value])
    end

    return modifiedlines
end

for lineindex = 1:length(lines)
    instruction, _ = split(lines[lineindex])
    if instruction ∉ ["nop", "jmp"]
        continue
    end

    modifiedlines = modify(lineindex, lines)
    terminated, accumulator = terminates(modifiedlines)

    if terminated
        println(accumulator)
    end
end
