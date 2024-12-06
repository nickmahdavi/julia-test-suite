def quicksort(arr, low=0, high=None):
    if high is None:
        high = len(arr) - 1
        
    if low < high:
        pivot_pos = partition(arr, low, high)
        quicksort(arr, low, pivot_pos - 1)
        quicksort(arr, pivot_pos + 1, high)
    return arr

def partition(arr, low, high):
    pivot = arr[high]
    i = low - 1
    
    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
            
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1

def billion_loops():
    count = 0
    for _ in range(1000000000):
        count += 1
    return count