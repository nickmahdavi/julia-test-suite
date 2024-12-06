#include <vector>
#include <algorithm>

void quicksort(std::vector<int>& arr, int low = -1, int high = -1) {
    if (low == -1) low = 0;
    if (high == -1) high = arr.size() - 1;
    
    if (low < high) {
        // Partition and get pivot position
        int pivot_pos = partition(arr, low, high);
        // Recursively sort left and right portions
        quicksort(arr, low, pivot_pos - 1);
        quicksort(arr, pivot_pos + 1, high);
    }
}

int partition(std::vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    
    std::swap(arr[i + 1], arr[high]);
    return i + 1;
}

int billion_loops() {
    long long count = 0;
    for (long long i = 0; i < 1000000000; i++) {
        count++;
    }
    return count;
}