function partition!(arr, low, high)
    pivot = arr[high]
    i = low - 1
    
    for j in low:high-1
        if arr[j] <= pivot
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
        end
    end
    
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1
end


function quicksort!(arr, low=1, high=length(arr))
    if low < high
        pivot_pos = partition!(arr, low, high)
        quicksort!(arr, low, pivot_pos - 1)
        quicksort!(arr, pivot_pos + 1, high)
    end
    arr
end

function billion_loops()
    count = 0
    for i in 1:1000000000
        count += 1
    end
    return count
end

function mandelbrot(width=1000, height=1000, max_iter=1000)
    result = zeros(Int, height, width)
    for y in 1:height
        for x in 1:width
            c = complex(2.0*x/width - 1.5, 2.0*y/height - 1.0)
            z = complex(0, 0)
            for n in 1:max_iter
                z = z^2 + c
                if abs2(z) > 4
                    result[y,x] = n
                    break
                end
            end
        end
    end
    return result
end