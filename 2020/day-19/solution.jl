lines = readlines("input.txt")
newline = findfirst(==(""), lines)
rules = lines[1:newline-1]
messages = lines[newline+1:end]
rulesdict = Dict(split(rule)[1][1:end-1] => split(rule)[2:end] for rule in rules)

rule = rulesdict["0"]
index = findfirst(map(x -> tryparse(Int, x) !== nothing, rule))
while index !== nothing
    global rule, index, rulesdict
    rule = vcat(
        rule[1:index-1],
        vcat("(?:", rulesdict[rule[index]]..., ")"),
        rule[index+1:end],
    )
    index = findfirst(map(x -> tryparse(Int, x) !== nothing, rule))
end

rule = string("^", rule..., "\$")
rule = replace(rule, "\"" => "")
rule = Regex(rule)

println(count(x -> match(rule, x) !== nothing, messages))

# ---

rule = rulesdict["0"]
index = findfirst(map(x -> tryparse(Int, x) !== nothing, rule))
while index !== nothing
    global rule, index, rulesdict
    if rule[index] == "8"
        # Rule 42, but allowed to repeat 1 or more times. This is just + in regex.
        rule = vcat(rule[1:index-1], vcat("(?:", "42", ")+"), rule[index+1:end])
    elseif rule[index] == "11"
        # Rules 42 and 31, but sandwiched to arbitrary depth. This calls for recursive regex.
        # Note that the "extra" set of parentheses is so that (?-1) refers to this outer group.
        # https://www.regular-expressions.info/subroutine.html
        rule = vcat(
            rule[1:index-1],
            vcat("(?:(", "42", "31", "|", "42", "(?-1)", "31", "))"),
            rule[index+1:end],
        )
    else
        rule = vcat(
            rule[1:index-1],
            vcat("(?:", rulesdict[rule[index]]..., ")"),
            rule[index+1:end],
        )
    end
    index = findfirst(map(x -> tryparse(Int, x) !== nothing, rule))
end

rule = string("^", rule..., "\$")
rule = replace(rule, "\"" => "")
rule = Regex(rule)

println(count(x -> match(rule, x) !== nothing, messages))
