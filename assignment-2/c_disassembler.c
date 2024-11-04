#include <stdio.h>

int countIterations(int initial_R1, int R0) {
    int R1 = initial_R1;  // Equivalent to the initial value of R1
    int R3 = initial_R1;  // R3 holds the initial value of R1
    int R2 = 0;           // Initialize R2 to zero

    // Loop until R1 > R0
    while (R1 <= R0) {
        R2++;             // Increment R2
        R1 += R3;         // Add R3 (initial value of R1) to R1
    }

    return R2;            // Final value of R2, stored in R0 in assembly
}

int main() {
    int initial_R1 = 5;   // Example value for initial R1
    int R0 = 20;          // Example value for R0

    int result = countIterations(initial_R1, R0);
    printf("Number of iterations: %d\n", result);

    return 0;
}
