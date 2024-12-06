function billion_loops()
    count = 0
    for i in 1:1000000000
        count += 1
    end
    return count
end

counter = billion_loops()