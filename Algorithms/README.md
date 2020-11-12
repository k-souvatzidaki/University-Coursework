# Algorithms
For the Algorithms course I studied some *algorithm writing techniques* such as **greedy algorithms, divide and conquer and dynamic programming**, and implemented several exercises in **Java**.

## Main 
Each folder contains a **set of exercises**, the **.txt** dataset files, and a **Check.java** file, that being a hard-coded main program that prints all the exercises output given the datasets as input. The **Utilities.java** files contain methods to read files.

## Divide and Conquer
In **BinarySearch.java** I used the **binary search** algorithm to find the first and last position of a value in a sorted array of integers. In **ArraylistQuicksort.java** I implemented the **Quicksort** sorting algorithm on an ArrayList.

## Dynamic Programming
In **ShortestPath.java** , given a **set of nodes in a row** (a *Directed Acyclic Graph*), with a value **X** on each node, and implying we can **jump from one node to the next X nodes**, the dynamic algorithm finds the minimum number of jumps needed to go from the first node to the last. The algorithm in **CaloriesFatsMenu.java** is a variation of the **Knapsack problem**. Given a set of **foods, each one having an amount of calories and an amount of fats**, and a **maximum number of calories C** , the algorithm finds the **set of foods with an amount of calories closest to C (but not more than that), that has the minimum amount of fats**.

## Graph Problems
In **ShortestCycle.java**, given a graph of philosophers, and the names of 2 philosophers, the algorithm uses **BFS** search to find the shortest cycle containing the 2 philosophers. In **VertexCover.java** I implemented a **brute force algorithm, and a greedy algorithm**, both to find the **vertex cover** of a graph (= the subset of vertices that cover all the edges). The graphs are implemented as HashMaps of Arraylists. 
     
*Spring 2018-19*
