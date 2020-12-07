using LightGraphs, SimpleWeightedGraphs

lines = readlines("input.txt")

graph = SimpleWeightedGraphs.SimpleWeightedDiGraph()
vertexindex = 1
bagnames_to_indices = Dict()

for line in lines
    if occursin("no other", line)
        continue
    end

    splut = split(line)

    firstbag = join(splut[1:2], ' ')
    if firstbag ∉ keys(bagnames_to_indices)
        bagnames_to_indices[firstbag] = vertexindex
        LightGraphs.add_vertex!(graph)
        global vertexindex += 1
    end

    wordindex = 5
    while wordindex < length(splut)
        numbags = parse(Int, splut[wordindex])
        bagname = join(splut[wordindex+1:wordindex+2], ' ')
        if bagname ∉ keys(bagnames_to_indices)
            bagnames_to_indices[bagname] = vertexindex
            LightGraphs.add_vertex!(graph)
            global vertexindex += 1
        end

        LightGraphs.add_edge!(
            graph,
            bagnames_to_indices[firstbag],
            bagnames_to_indices[bagname],
            numbags,
        )
        wordindex += 4
    end
end

shinygold_bag_index = bagnames_to_indices["shiny gold"]
println(
    count(vertex -> has_path(graph, vertex, shinygold_bag_index), vertices(graph)) - 1,  # Account for shiny gold bag itself
)

# ---

queue = [(shinygold_bag_index, 1)]  # Vertex, multipler
totbags = 0

while length(queue) != 0
    bagindex, multiplier = popfirst!(queue)
    neighbors_ = neighbors(graph, bagindex)
    for neighbor in neighbors_
        # Oddly indexed by [to, from] and not [from, to]
        global totbags += multiplier * graph.weights[neighbor, bagindex]
        push!(queue, (neighbor, multiplier * graph.weights[neighbor, bagindex]))
    end
end

println(totbags)
