#include <iostream>
#include <stdio.h>

extern "C" int* selection_sort(int *arr, int length);

int main() {
	int length = 5;
	int *arr = new int[length] {5, 3, -4, 2, 6};

	int *res = selection_sort(arr, length);

	for (int i = 0; i < length; i++) {
		printf("%d ", res[i]);
	}
	printf("\n");

	return 0;
}
