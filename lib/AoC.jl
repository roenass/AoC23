function readblocks()
    split(read(stdin, String), r"\n\n")
end

function readlines(b)
   lines=split(chomp(b), '\n')
end

function readgrid(b)
    lines=readlines(b);
    rows=length(lines); cols=length(lines[1])
    G=Matrix{Union{Nothing,Char}}(nothing, rows, cols)
    for i ∈ 1:rows
        chars = collect(lines[i])
        for j ∈ 1:cols G[i,j] = chars[j]   end
    end
    return G
end

function row(G, r)
    G[r,:]
end

function printgrid(G)
    for r ∈ 1:length(G[:,1])   println(join(row(G, r)))    end
end

function col(G, c)
    G[:,c]
end