function billion_loops()
    count = 0
    for i in 1:1000000000
        count += ((i & 0xFF) << (i & 3))
    end
    return count
end

print(billion_loops())