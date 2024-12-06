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

numbers = parse.(Int, readlines("arr.txt"))
quicksort!(numbers)