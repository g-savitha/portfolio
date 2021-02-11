---
title: 'Recursion Simplified'
date: 2021-01-31T11:16:15+05:30
draft: true
meta:
  image: # url to image. Important for blog listing and seo
  description: # overrides .Summary
featured: false # feature a post in homepage
tableofcontents: true # whether to generate ToC
tags: [dsa]
categories: []
---

<!--  Start Typing... -->


## What is recursion?


_Recursion_ : A function calling itself directly or indirectly.

_Directly:_

```cpp
void fun1(){
    //somecode ...
    fun1();
    //some other code...
}
```

_Indirectly:_ Not a very common approach (Mostly direct recursive approach is used)

fun1() -> fun2() -> fun1()

```cpp
void fun1(){
    //somecode ...
    fun2();
    //some other code...
}
void fun2(){
    //somecode ...
    fun1();
    //some other code...
}


```

- If you _dont add a base case_, _recursion never stops_ and we might end up with _stackoverflow_(in case of java) or _segmentation fault_ error(in case of cpp).
- There should be **one stopping condition atleast**. Such stopping conditions are called _*Base cases*_

_Example:_

```cpp
void fun1(int n)
{
    //Base Case
    if (n == 0)
        return;
    cout << "Function 1" << endl;
    fun1(n - 1);
}
int main(int argc, char const *argv[])
{
    /* code */
    fun1(2);
    return 0;
}

```

### Typical structure of a recursion

(Assuming: You are not using global vars or some other tricks to stop recursion ).

```plaintext
returntype function(parameters){
    Base cases
    //some other code.....
    Recursive call (i.e., call to function()) with atleast one change in parameters
    //some other code...
}
```

## Applications of recursion

Any problem which can be solved iteratively can also be solved using recursively and vice-versa. They both have same expressive power.

Now the question is if we can write equivalent iterative code for every recursive code or vice versa, **where do we use recursion?**

- Many algorithm techniques are based on recursion.
  - **Dynamic programming**
    - In DP, generally _first solution is to write a recursive solution_. If we see overlapping subproblems (apply memoization or tabulation), we use DP to optimise it.
    - _Example:_ Finding diff between two files (solved using LCS approach)
  - **Backtracking**
    - These problems are _inherently recursive_ in nature.
      - _Example_ : Rat in a maze, n-queens problem. (Its easy to write recursive solns than iterative for problems like this)
  - **Divide and conquer**
    - _Examples:_ Binary search, quicksort and mergesort
- Many problems which are _inherently recursive_ (Easy to write recursive than iterative)

  - **Towers of Hanoi**
  - **DFS based travels**
    - Of _Graphs_
    - Inorder, preorder postorder traversals of _tree_
    - Searching for a file in your pc - solid example of DFS

- _Cons of recursion_

  - (Auxillary) space complexity increases
  - Function call overhead.

- _Pros:_
  - Easy implementation

## Examples

```cpp
void fun1(int n)
{

    if (n == 0)
        return; //Base Case
    cout << n << endl;
    fun1(n - 1);
    cout << n << endl;
}
int main(int argc, char const *argv[])
{
    /* code */
    fun1(3);
    return 0;
}
//Output : 321123
```

```cpp
void fun1(int n)
{

    if (n == 0)
        return; //Base Case
    fun1(n - 1);
    cout << n << endl;
    fun1(n - 1);
}
int main(int argc, char const *argv[])
{
    /* code */
    fun1(3);
    return 0;
}
//Output : 1213121
```

```cpp
int fn(int n)
{
    if (n == 1)
        return 0;
    else
        return 1 + fn(n / 2);
}
//TC: O(floor(logn base2))
//SC: O(n/2)
//fn(16) -> O/p: 4 => (1+f(8)) ->(1+1+f(4)) ->(1+1+1+f(2)) -> (1+1+1+1+f(1))
//fn(20) -> o/p: 4 =>(1+f(10)) -> (1+1+f(5)) -> (1+1+1+f(2)) -> (1+1+1+1+f(1))
//fn(19) -> o/p:4 => (1+f(9)) -> (1+1+f(4)) -> ->(1+1+1+f(2)) -> (1+1+1+1+f(1))

//output remains same until we get to next power of 2.
```

### Binary representation of a number(n > 0) using recursion

```cpp
int fn(int n)
{
    if (n == 0)
        return;
    fn(n / 2);
    cout << n % 2 << endl;
}
```

### print 1 to N using recursion

```java
private static void fn(int n) {
    if (n == 0)
        return;
    fn(n - 1);
    System.out.println(n);
}//TC; O(n) AS: O(n+1)
```

### print N to 1 using recursion

```java
private static void fn(int n) {
    if (n == 0)
        return;
    System.out.println(n);
        n(n - 1);
}// TC: theta(n)
//SC: (Auxillary space) : O(n)
```

- **Note:** We can reduce the auxillary space using _*tail recursion*_.
  - The above fn takes less time on modern compilers because of tail recursion

## Tail Recursion

