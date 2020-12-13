using Debugger

lines = readlines("input.txt")
earliest = parse(Int, lines[1])
schedule = split(lines[2], ',')
buses = map(x -> parse(Int, x), schedule[schedule.!="x"])

timedelta = 0
while true
    global earliest, buses, timedelta
    time = earliest + timedelta
    if any([time % bus == 0 for bus in buses])
        bus = findfirst([time % bus == 0 for bus in buses])
        println(buses[bus] * (time - earliest))
        break
    end
    timedelta += 1
end

# ---

waittimes = findall(schedule .!= "x")
waittimes .-= 1

time = 0
increment = 1
for (bus, waittime) in zip(buses, waittimes)
    global time, increment
    while ((time + waittime) % bus) != 0
        time += increment
    end
    increment *= bus
end
println(time)
