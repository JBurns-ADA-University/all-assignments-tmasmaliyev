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
sudo apt install qemu-user-static         (Install qemu to linux)
sudo apt install docker.io                (Install docker to linux)

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes  ( This code allows to change the architecture of docker container to`armv7` architecture using qemu)

docker pull arm32v7/ubuntu   (This line pulls `armv7/ubuntu` versioned image from docker.hub, If it doesn't work, then run the following command directly, since it checks whether there is that `image` or not, so it can install)
sudo docker run -it --platform linux/arm/v7 --name my_arm_v7  arm32v7/ubuntu (Run the docker image under the name of `my_arm_v7` container name.

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




