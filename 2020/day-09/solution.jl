using Combinatorics

lines = readlines("input.txt")
numbers = map(x -> parse(Int, x), lines)

invalidnumber = 0
for index = 51:length(numbers)
    pairs = combinations(numbers[index-50:index-1], 2)
    pairsums = [x + y for (x, y) in pairs]

    if numbers[index] ∉ pairsums
        global invalidnumber = numbers[index]
        println(numbers[index])
        break
    end
end

# ---

for i = 1:length(numbers)
    for j = i+1:length(numbers)
        if sum(numbers[i:j]) == invalidnumber
            min = minimum(numbers[i:j])
            max = maximum(numbers[i:j])
            println(min + max)
        end
    end
end
