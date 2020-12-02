lines = readlines("input.txt")

expenses = map(x -> parse(Int, x), lines)
numexpenses = length(expenses)

for i = 1:numexpenses
    for j = 1:i
        if expenses[i] + expenses[j] == 2020
            println(expenses[i] * expenses[j])
        end
    end
end

# ---

for i = 1:numexpenses
    for j = 1:i
        for k = 1:j
            if expenses[i] + expenses[j] + expenses[k] == 2020
                println(expenses[i] * expenses[j] * expenses[k])
            end
        end
    end
end
