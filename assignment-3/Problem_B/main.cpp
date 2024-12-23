#include <iostream>

extern "C" int binary_search(int* arr, int length, int k);

int main() {
	int length = 5;
	int* arr = new int[length] {1, 2, 3, 4, 5};	

	int val = binary_search(arr, length, 3);

	printf("%d\n", val);
	return 0;
}

