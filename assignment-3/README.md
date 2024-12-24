# Assignment 3

This assignment is only completed by single person and only covers `Problem 1` (**Selection Sort** and **Binary Search**).

Google drive link for presentation : `IMPORTANT !!!`

# Environment
Before going into problems, It is important to consider `environment`. I created my own emulator to run `armv7` code in `AMD64` processor in ubuntu.
This is done because, debugging `armv7` code is cumbersome and requires careful designing. 
Also, it helps to work real time hardware and software rather than `cpulator`, allows to bind assembly `arm` code to another programming languages.

First, `Docker Image` is needed to run `armv7` version OS kernel. Then, `QEMU` (Quick emulator) for translating `AMD64` assembly code to `armv7`.
After initializing, it is safe to run `docker image` and store the inside data in `volume`. 

Lines of codes:
- sudo apt install qemu-user-static         (Install qemu to linux)
- sudo apt install docker.io                (Install docker to linux)

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes  
This code allows to change the architecture of docker container to`armv7` architecture using qemu

- docker pull arm32v7/ubuntu
This line pulls `armv7/ubuntu` versioned image from docker.hub, If it doesn't work, then run the following command directly, since it checks whether there is that `image` or not, so it can install

sudo docker run -it --platform linux/arm/v7 --name my_arm_v7  arm32v7/ubuntu 
Run the docker image under the name of `my_arm_v7` container name.

This is initializing process. After done your work, it is safer to use `exit` command.
In order to use this container again, it is recommended to use start the container with `created name` such as:

sudo docker start -ai my_arm_v7

Here is the environment. You can use `apt install update` to update softwares to latest version. You can check the cpu architecture by using `lscpu` command in terminal.

Also, you can test my files in that linux container by installing `build-essential` (for installing C++ and assembly) and safely run code.

# Problem 1 (Section A)
## Algorithm (Selection Sort)

`Pseudocode:`
SelectionSort(A[0..n-1])
// Sorts a given array by selection sort
// Input: An array A[0..n-1] of orderable elements
// Output: Array[0..n-1] of orderable elements


## Architectural approach
At first, I divided my code in two parts : 
- C++ 
- Assembly

The raw `selection sort` was written assembly and in order to pass argument and get back the result, I used `C++`.
At first, In `Problem_A` directory, `main.cpp` is created. To call assembly function, I added `externable` function keyword before function name.
Basically this allows the `linker` to search that object file and fill the `implementation` based on that object file. 
Also, it accepts, `C` language type function definition (Where the mangling is closed and typical <type> <argument> notation format)

In the `main` function, I added simple test case with corresponding length. Then passed it to `selection_sort`. It returns pointer that points to first element of array (basically sorted form). Then iterate to see if it is sorted or not.

In order to `link` files correctly. This steps must be taken into account.
- as -o selection_sort.o selection_sort.s
- g++ -c -o main.o main.cpp
- g++ -o main selection_sort.o main.o -z noexecstack

First, **assembly code** is translated into `object` file (Machine code). Then, **C++** code is translated into `object` file too (but without linking).
At last, the object files are linked to generate `executable` file (In this case, `main`). Also, the `-z noexecstack` is added so that generated `exe` doesn't execute code from stack. It is for security risk measures because in assembly, there is no measures taken into account, so adding it solves the warning of `GNU:noexecstack`

In order to avoid writing every single time of these steps, I used `Makefile`. The makefile is just `template` for executing bunch of statements in one go. 
I added to specific steps in the following:
- make (Builds all files in one single line)
- make clean (In order to clean object files and `exe`)

## Algorithmic approach (Assembly file)
Assembly function (the implementation of algorithm) resides in `selection_sort.s`. Here, let's go step-by-step:
First, `global function` (main) is chosen. Then, it is type are given as `function`. This is because, in linking process, it should recognize that it is callable function.

In `selection_sort` branch, at first, The `registers` and `Link Register` is stored in stack (via push). This is done because when the caller calls callee, it stores some calling conventions, so changing it will result unexpected behaviors.
These registers are `R4-R7`. General purpose registers are also stored through `R8-R12`.

The link register also stored, so at the end of the program, we will use to go back to `C++` code by assigning `PC = LR`.

When arguments passed through assembly file, it stores it from `R0-R3'. If we have more arguments, then rest of them are stored in stack.
In this case, there is only two arguments, so it is safe to only work with R0 and R1.

R4 = array pointer (R0)
R5 = array length  (R1)
R6 = 0 index assignment (i = 0)

Then, outer loop comes, here, it checks if index value i (R6 register) less than array length.
If yes, then branch to `end_selection_sort`, otherwise continue.

R7 = R6 (min_index is set to i)
R8 = R4 (Base address pointer of array)
R8 is moved to `min_index` place (ptr_min_ind = array[min_ind])

R9 = R6  (j = i)
R10 = R8 (ptr_j = ptr_i)

Then, inner loop comes in.
In each iteration, at first,  `j` value is incremented by `1`. Then, check if j less than `array length`. If yes, continue, otherwise, go to `update_array_value` branch.

R11 = &R8 (pointer dereference to get value inside of pointer to get &ptr_min_i)
R12 = &(R10 + 4) (apply pre-increment to r10 pointer by +4, basically move one index forward, and dereference it to get value inside pointer)

Then, &ptr_j < &ptr_min_i condition cehcked, If true, than branch to `update_min`.

After going one iteration in `j` loop, it goes back to inner_loop until j >= array length.

In `update_min`, when `BLT` condition met for &ptr_j < &ptr_min_i, it goes to this branch. Assign `min_ind` to j and change the R8 (pointer) to the position of new `min_ind`.
Basically, ptr_min_i = array[min_ind]

In `update_array_value`, when j >= array length condition met, it goes to this branch. 

Since, j loop is completed, it is safe to use `R9` register.
R9 = ptr_i
Then load the value to R12 register (basically R12 = &ptr_i)

Same operation for, R11 = &ptr_min_ind

Then, inverse the places of `i` with `min_ind` by storing R12 to R8 and R11 to R9.

Basically, 
*ptr_min_i = array[i]
*ptr_i = array[min_ind]

Then, increment i by 1 then branch to `outer_loop`.

This loop will go until i >= array length. Then, it will go to end_selection_sort. 
For the return statement, in armv7, it is considered as R0 register. Assigning base pointer to R0 for return purposes.
Here, the registers are stored and program counter set to link register to go back to caller function. 
