lines = readlines("input.txt")

expenses = map(x -> parse(Int, x), lines)
numexpenses = length(expenses)

for i in 1:numexpenses
    for j in 1:i
        if expenses[i] + expenses[j] == 2020
            println(expenses[i] * expenses[j])
        end
    end
end

# ---

for i in 1:numexpenses
    for j in 1:i
        for k in 1:j
            if expenses[i] + expenses[j] + expenses[k] == 2020
                println(expenses[i] * expenses[j] * expenses[k])
            end
        end
    end
end
