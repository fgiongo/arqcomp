void quicksort_non_desc(int *arr, int arr_start, int arr_end){
	int start, end, pivot, tmp;

	if ((arr_end - arr_start) <= 1){
		return;
	}

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

		tmp = arr[start];
		arr[start] = arr[end];
		arr[end] = tmp;
	}

	if (arr[end] >= arr[pivot]){
		end--;
	} else {
		start++;
	}

	tmp = arr[end];
	arr[end] = arr[pivot];
	arr[pivot] = tmp;

	quicksort_non_desc(arr, arr_start, end);
	quicksort_non_desc(arr, start, arr_end);
	return;
}
