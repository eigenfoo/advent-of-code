lines = readlines("input.txt")

regex = r"(\d*)-(\d*) (\w): (\w*)"
linecaptures = map(s -> match(regex, s).captures, lines)

numvalid = 0
numinvalid = 0

for captures in linecaptures
    mincount = parse(Int, captures[1])
    maxcount = parse(Int, captures[2])
    requiredcharacter = first(captures[3])
    password = captures[4]
    count = length(split(password, requiredcharacter)) - 1

    if mincount <= count <= maxcount
        global numvalid += 1
    else
        global numinvalid += 1
    end
end

println("Valid passwords: ", numvalid)
println("Invalid passwords: ", numinvalid)

# ---

numvalid = 0
numinvalid = 0

for captures in linecaptures
    minindex = parse(Int, captures[1])
    maxindex = parse(Int, captures[2])
    requiredcharacter = first(captures[3])
    password = captures[4]

    if xor(password[minindex] == requiredcharacter, password[maxindex] == requiredcharacter)
        global numvalid += 1
    else
        global numinvalid += 1
    end
end

println()
println("Valid passwords: ", numvalid)
println("Invalid passwords: ", numinvalid)
