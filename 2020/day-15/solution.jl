numbers = [0, 1, 4, 13, 15, 12, 16]

begin
    while length(numbers) < 2020
        global numbers
        if count(isequal(numbers[end]), numbers[1:end-1]) == 0
            nextnumber = 0
        else
            nextnumber = length(numbers) - findlast(isequal(numbers[end]), numbers[1:end-1])
        end
        push!(numbers, nextnumber)
    end
    println(numbers[2020])
end

# ---

numbers = [0, 1, 4, 13, 15, 12, 16]

function play(numbers)
    i = length(numbers)
    n = numbers[end]
    lastspoken = Dict(j => i for (i, j) in enumerate(numbers))

    while i < 30000000
        if haskey(lastspoken, n)
            n_ = i - lastspoken[n]
            lastspoken[n] = i
            n = n_
        else
            lastspoken[n] = i
            n = 0
        end
        i += 1
    end
    n
end

println(play(numbers))
