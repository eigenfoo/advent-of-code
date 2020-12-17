using Debugger
using DataStructures

lines = readlines("input.txt")

firstnewline = findfirst(lines .== "")
lastnewline = findlast(lines .== "")

rules = lines[1:firstnewline-1]
myticket = lines[firstnewline+2]
nearbytickets = lines[lastnewline+2:end]

rules = map(rule -> match(r"([\w\s]*): (\d+)-(\d+) or (\d+)-(\d+)", rule).captures, rules)
rules = Dict(
    name => [(parse(Int, a), parse(Int, b)), (parse(Int, c), parse(Int, d))]
    for (name, a, b, c, d) in rules
)

ranges = vcat(values(rules)...)
validnumbers = Set(vcat([collect(range[1]:range[2]) for range in ranges]...))

ticketnumbers = transpose(hcat([
    map(x -> parse(Int, x), split(nearbyticket, ',')) for nearbyticket in nearbytickets
]...))

invalidnumbermask = map(!∈(validnumbers), ticketnumbers)
println(sum(ticketnumbers[invalidnumbermask]))

# ---

invalidticketmask = reshape(any(invalidnumbermask, dims = 2), :)
validticketnumbers = ticketnumbers[.!invalidticketmask, :]

rules = Dict(
    name => Set(vcat([collect(tuple[1]:tuple[2]) for tuple in value]...)) for (name, value) in rules
)

possiblefields = DataStructures.DefaultDict(() -> String[])
for (i, col) in enumerate(eachcol(validticketnumbers))
    global rules, possiblefields
    for (name, validnumbers) in rules
        if issubset(Set(col), validnumbers)
            push!(possiblefields[i], name)
        end
    end
end

fields = Dict()
while !all(map(==(0) ∘ length, values(possiblefields)))
    global possiblefields, fields
    singletonindices = [index for (index, names) in possiblefields if length(names) == 1]
    singletonnames = [possiblefields[index][1] for index in singletonindices]
    for (index, name) in zip(singletonindices, singletonnames)
        fields[name] = index
    end
    possiblefields =
        Dict(k => filter(x -> x ∉ singletonnames, v) for (k, v) in possiblefields)
end

myticket = map(x -> parse(Int, x), split(myticket, ','))
departurekeys = [key for key in keys(fields) if startswith(key, "departure")]
println(prod([myticket[fields[key]] for key in departurekeys]))
