using Debugger

lines = readlines("input.txt")

function evaluate(expression)
    if '(' ∉ expression
        # No parentheses at all - evaluate from left to right
        symbols = split(expression)
        while length(symbols) > 1
            evaluated = (
                symbols[2] == "+" ? parse(Int, symbols[1]) + parse(Int, symbols[3]) :
                parse(Int, symbols[1]) * parse(Int, symbols[3])
            )
            symbols = symbols[4:end]
            pushfirst!(symbols, string(evaluated))
        end
        symbols[1]
    else
        # Find the first pair of parentheses and evaluate that first
        closeindex = findfirst(')', expression)
        openindex = findlast('(', expression[1:closeindex])
        evaluate(string(
            expression[1:openindex-1],
            evaluate(expression[openindex+1:closeindex-1]),
            expression[closeindex+1:end],
        ))
    end
end

map(line -> parse(Int, evaluate(line)), lines) |> sum |> println

# ---

function newevaluate(expression)
    if '(' ∉ expression
        # No parentheses at all - evaluate
        symbols = split(expression)
        indices = findall(==("+"), symbols)
        for index in sort(indices, rev = true)
            symbols = vcat(
                symbols[1:index-2],
                string(parse(Int, symbols[index-1]) + parse(Int, symbols[index+1])),
                symbols[index+2:end],
            )
        end
        string(eval(Meta.parse(string(symbols...))))
    else
        # Find the first pair of parentheses and evaluate that first
        closeindex = findfirst(')', expression)
        openindex = findlast('(', expression[1:closeindex])
        newevaluate(string(
            expression[1:openindex-1],
            newevaluate(expression[openindex+1:closeindex-1]),
            expression[closeindex+1:end],
        ))
    end
end

map(line -> parse(Int, newevaluate(line)), lines) |> sum |> println
