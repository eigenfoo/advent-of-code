lines = readlines("input.txt")[1]
program = split(lines, ",")
program = map(x -> parse(Int64, x), program)

program[1+1] = 12
program[2+1] = 2

i = 1
while true
    if program[i] == 1
        # Add
        program[program[i+3] + 1] = program[program[i+1] + 1] + program[program[i+2] + 1]
    elseif program[i] == 2
        # Multiply
        program[program[i+3] + 1] = program[program[i+1] + 1] * program[program[i+2] + 1]
    elseif program[i] == 99
        # Halt
        println("It's good!")
        break
    else
        println("It's not good!")
        throw(ErrorException)
    end
    
    println(program[1])
    global i += 4
end

println(program)
