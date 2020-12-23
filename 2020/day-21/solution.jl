lines = readlines("input.txt")

possibilities = Dict()
allingredients = Set()
for line in lines
    global possibilities, allingredients
    openindex = findfirst('(', line)
    ingredients = Set(split(line[1:openindex-1]))
    allingredients = ∪(allingredients, ingredients)
    allergens = Set(split(line[openindex+10:end-1], ", "))

    for allergen in allergens
        if allergen in keys(possibilities)
            possibilities[allergen] = ∩(possibilities[allergen], ingredients)
        else
            possibilities[allergen] = ingredients
        end
    end
end

notallergens = setdiff(allingredients, ∪(values(possibilities)...))
println(sum(line -> count(ingredient -> ingredient ∈ notallergens, split(line)), lines))

# ---

knownallergens = [key for (key, value) in possibilities if length(value) == 1]
knowningredients =
    Set([collect(possibilities[knownallergen])[1] for knownallergen in knownallergens])
dangerousingredients = Dict()
while length(knownallergens) !== 0
    global knownallergens, knowningredients, dangerousingredients, possibilities
    for knownallergen in knownallergens
        dangerousingredients[knownallergen] = collect(possibilities[knownallergen])[1]
    end
    for allergen in keys(possibilities)
        possibilities[allergen] = setdiff(possibilities[allergen], knowningredients)
    end
    knownallergens = [key for (key, value) in possibilities if length(value) == 1]
    knowningredients =
        Set([collect(possibilities[knownallergen])[1] for knownallergen in knownallergens])
end

println(join(map(x -> x[2], sort(collect(dangerousingredients))), ','))
