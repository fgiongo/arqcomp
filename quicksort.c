#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int quicksort_non_desc_test
(void (*sort)(int *, int, int), int *arr, int length){
	int iterations = 10000;
	struct timespec ts;

	for (int i = 0; i < iterations; ++i){

		clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
		srand((unsigned int) ts.tv_nsec);
		for (int j = 0; j < length; ++j){
			arr[j] = rand() % 100;
		}

		sort(arr, 0, length);
		for (int j = 1; j < length; ++j){
			if (arr[j] < arr[j-1]){
				return 0;
			}
		}
	}
	return 1;
}

void quicksort_non_desc(int *arr, int arr_start, int arr_end){
	int start, end, pivot, tmp;

	if ((arr_end - arr_start) <= 1){
		return;
	}

	/* Pivot sera' sempre a primeira posicao */
	start = arr_start;
	end = arr_end - 1;
	pivot = start;
	start++;

	while (start < end){
		if (arr[start] < arr[pivot]){
			start++;
			continue;
		}

		if (arr[end] >= arr[pivot]){
			end--;
			continue;
		}

		/* Se chegamos aqui,
		 * precisamos fazer uma troca. */
		tmp = arr[start];
		arr[start] = arr[end];
		arr[end] = tmp;
	}

	/* Agora start == end, precisamos
	 * retornar o pivot para a posicao correta.
	 * Queremos usar start e end como os
	 * indices para a recusao. Existem duas
	 * de uma posicao >= que o pivot, ou de uma
	 * < que o pivot. */
	if (arr[end] >= arr[pivot]){
		end--;
	} else {
		start++;
	}

	/* Colocando pivot na sua posicao correta. */
	tmp = arr[end];
	arr[end] = arr[pivot];
	arr[pivot] = tmp;

	/* Chamadas recursivas */
	quicksort_non_desc(arr, arr_start, end);
	quicksort_non_desc(arr, start, arr_end);
	return;
}

int main (int argc, char *argv[] ){
	int length;
	int *list;

	if (argc == 1){
		fputs("Missing argument: list size\n", stderr);
		return 1;
	}

	length = atoi(argv[1]);
	if (length > 100){
		fputs("List size too large. Maximum size: 100\n", stderr);
		return 1;
	}

	list = (int *) malloc(sizeof(int) * length);
	
	if (quicksort_non_desc_test(quicksort_non_desc, list, length)){
		fputs("Test Passed!\n", stdout);
	} else {
		fputs("Test Failed :(\n", stdout);
	}

	return 0;
}

