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
    int temp = arr[i + 1];
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

int main() {
    FILE *fp = fopen("arr.txt", "r");
    int *arr = malloc(1000000 * sizeof(int));
    int count = 0;
    
    char line[32];
    while (fgets(line, sizeof(line), fp) && count < 1000000) {
        arr[count++] = atoi(line);
    }

    fclose(fp);
    quicksort(arr, 0, count - 1);

    free(arr);
    return 0;
}