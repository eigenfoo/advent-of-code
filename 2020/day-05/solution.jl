lines = readlines("input.txt")

function parseseat(line)
    fbdict = Dict('F' => '0', 'B' => '1')
    lrdict = Dict('L' => '0', 'R' => '1')

    binarizedrow = map(char -> fbdict[char], line[1:7])
    binarizedcolumn = map(char -> lrdict[char], line[8:end])

    return parse(Int, binarizedrow, base = 2), parse(Int, binarizedcolumn, base = 2)
end

seats = map(parseseat, lines)
seatids = map(tuple -> ((row, col) = tuple; 8 * row + col), seats)
maxseatid = maximum(seatids)
println(maxseatid)

# ---

allseatids = Set(1:maxseatid)
println(setdiff(allseatids, seatids))  # Remove front and back seats by eye lol
