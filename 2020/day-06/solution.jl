input = read("input.txt", String)
groups = split(input, "\n\n")
answers = map(split, groups)
answersets = map(x -> Set(join(x)), answers)
println(sum(map(length, answersets)))

# ---

answersets = map(x -> intersect(x...), answers)
println(sum(map(length, answersets)))
