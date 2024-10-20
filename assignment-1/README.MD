# Problem Statement:

A company collects variable length sales data over `5 days` in the following format:
day_n = [ v1, v2, v3, ..., 0 ]

Because each day can contain variable length data, a 0 is used to indicate the end of the array data for a particular day. In total, each program should store `5 separate arrays`.


##  Tasks are labeled respectively with the problem statement:
1.	Total sales for the whole `5` days 
2.	Average sales per day (to be averaged over the whole `5` days)
3.	The maximum amount sold in the whole `5` days
4.	The minimum amount sold in the whole `5` days

##  The tasks are created on the `Task` folder in the following .asm codes each corresponding to its problem statement:
-   1.asm
-   2.asm
-   3.asm
-   4.asm


## Task Limitations that I took into account:
-   Unsigned integers
-	Integer division `(no floating point)`
- 	Conditional execution
-	STR to maintain results in memory `(not registers)`
-	Demonstrated use of the branch with link and the stack 

# Approach & Solution

## In order to avoid 1 assembly `(.asm)` file containing full solution with complex architecture, I approached creating multiple files for better interpretability.

## My detailed solution for each problem statement contains in the `solution.pdf` file.
