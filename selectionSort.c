#include <stdio.h>

void selectionSort(int array[], int size) {
    int i, j, min_index, temp;
    for (i = 0; i < size-1; i++) {
        /*Find the minimum element in the unsorted part of the array*/
        min_index = i;
        for (j = i+1; j < size; j++) {
            if (array[j] < array[min_index]) {
                min_index = j;
            }
        }

        /*Swap the found minimum element with the first element*/
        temp = array[min_index];
        array[min_index] = array[i];
        array[i] = temp;
    }
}

int main() {
    int i;
    int array[] = {64, 25, 12, 22, 11};
    int size_of_array = sizeof(array)/sizeof(array[0]);

    selectionSort(array, size_of_array);

    printf("Sorted array: ");
    for (i=0; i < size_of_array; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    return 0;
}
