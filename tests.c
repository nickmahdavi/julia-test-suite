#include <stdio.h>
#include <stdlib.h>

int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    
    int temp = arr[i];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1;
}

void quicksort(int arr[], int low, int high) {
    if (low < high) {
        int pivot_pos = partition(arr, low, high);
        quicksort(arr, low, pivot_pos - 1);
        quicksort(arr, pivot_pos + 1, high);
    }
}

#include <stdio.h>

int billion_loops() {
    long long count = 0;
    for (long long i = 0; i < 1000000000; i++) {
        count++;
    }
    return count;
}

int main() {
    billion_loops();
    return 0;
}