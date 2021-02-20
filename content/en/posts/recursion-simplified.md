---
title: "Recursion Simplified"
date: 2021-01-31T11:16:15+05:30
draft: false
hideToc: false
enableToc: true
enableTocContent: true
pinned: true
tags: [dsa, recursion]
categories: [dsa]
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
      - _Example_ : [Rat in a maze](https://www.geeksforgeeks.org/rat-in-a-maze-backtracking-2/), [n-queens problem](https://www.geeksforgeeks.org/n-queen-problem-backtracking-3/). (Its easy to write recursive solns than iterative for problems like this)
  - **Divide and conquer**
    - _Examples:_ [Binary search](https://www.geeksforgeeks.org/binary-search/), [quicksort](https://www.geeksforgeeks.org/quick-sort/) and [mergesort](https://www.geeksforgeeks.org/merge-sort/)
- Many problems which are _inherently recursive_ (Easy to write recursive than iterative)

  - **Towers of Hanoi**
  - **DFS based travels**
    - Of _Graphs_
    - [Inorder, preorder postorder traversals of tree](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/)
    - Searching for a file in your pc - solid example of DFS

- _Cons of recursion_

  - (Auxillary) space complexity increases
  - Function call overhead.

- _Pros:_
  - Easy implementation

## Examples

{{< codes cpp cpp cpp >}}
{{< code >}}

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

{{< /code >}}
{{< code >}}

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

{{< /code >}}
{{< code >}}

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

{{< /code >}}
{{< /codes >}}

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

### Print 1 to N using recursion

```java
private static void fn(int n) {
    if (n == 0)
        return;
    fn(n - 1);
    System.out.println(n);
}//TC; O(n) AS: O(n+1)
```

### Print N to 1 using recursion

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
  - The above function takes less time on modern compilers because of tail recursion

## Tail Recursion

To understand tail recursion, lets take a closer look at these 2 functions.

{{< codes java java >}}
{{< code >}}

```java
//prints from n to 1
void fn1() {
    if(n==0) return;
    System.out.println(n);
    fn1(n-1);
}
//this function takes lesser time
```

{{< /code >}}
{{< code >}}

```java
//prints from 1 to n
void fn2(){
    if(n==0) return;
    fn2(n-1);
    System.out.println(n);
}
```

{{< /code >}}
{{< /codes >}}

Can you guess the reason why would 1st function take lesser time to compile on modern compilers?

If you look at the call stack of `fn1()`

{{< img src="/images/blog-img/callstack.png" alt="callstack" width="400px" position="center" >}}

When `fn1(0)` finishes, control returns back to `fn1(1)`, `fn1(1)` doesnt have anything to do it finishes immediately. This is where tail recursion comes into picture.

A function is called **Tail recursive** when the parent function has nothing to do when the child finishes the call.

This is not the case with `fn2(3)`. When `fn2(0)` returns to its parent `fn2(1)`, it still has got work to do (print the output).

In very simple words

> A function is called **tail recursive**, when the last thing that happens in the function is recursive call and nothing happens after that.

### What are the pros of this?

The point is your caller doesn't have to save the state, generally what happens in recursive calls is, caller's state is saved then called function is called and once the called function is finished then the caller resumes its function from the same point. We dont need to resume the execution here at all, there's no point in resuming the execution and thats what the optimisation modern compilers do.

When modern compilers see tail recursive functions they replace the above code with

```java {hl_lines = [3,7,8]}
void fn1() {
    //compiler adds this label
    start:
        if(n==0) return;
        System.out.println(n);
        // and replaces the line fn1(n-1) with below statements
        n= n-1 ;
        goto start;
}
```

These changes that modern compilers make are called **Tail call elimination**

Now, the question arises is when given a non tail recursive code, can we convert it tail recursive?

Lets have a look at the below examples.

{{< codes java java >}}
{{< code >}}

```java
//prints from 1 to n
void fn2(){
    if(n==0) return;
    fn2(n-1);
    System.out.println(n);
}
```

{{< /code >}}

{{< code >}}

```java
//Tail recursive version of the code
//initially pass k = 1
void fn2(int n, int k){
    if(n==0) return;
    System.out.println(k);
    fn2(n-1,k+1);
}
```

{{< /code >}}
{{< /codes >}}

Can we convert every non tail recursive to tail recursive by adding few parameters?

**No.** Consider [merge sort](https://www.geeksforgeeks.org/merge-sort/) and [quick sort](https://www.geeksforgeeks.org/quick-sort/), if you take a closer look at these two algorithms, quick sort is tail recursive and merge sort is not. This is one of the reasons, quick sort is fast.

In case of [tree traversals (Inorder,preorder and postorder)](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/), you can notice that preorder traversal and inorder traversal are tail recursive, but post order traversal is not, thats why when you are given a problem and if you can choose any of the traversals, you should prefer either inorder or preorder over the postorder.

### Is this tail recursive?

```java
int factorial(int n){
    if(n==0 || n== 1) return 1;
    return n * factorial(n-1);
}
```

**No.** The reason is recursion is not the last thing that happens in this function. When you call `factorial(n-1)` you need to know the result of that function and multiply it with `n` and then it need to return. Parent call doesn't finish immediately after the child call, its going to use the result of child call and then multiply the result with `n` after that its going to return.

#### Equivalent tail recursive code

```java
//initially pass k = 1
int factorial(int n, int k){
    if(n==0 || n== 1) return k;
    return factorial(n-1,k*n);
}
```

---

Few problems on recursion worth looking at:

[Rod cutting](https://www.geeksforgeeks.org/cutting-a-rod-dp-13/)
[Generate subsets of an array](https://www.geeksforgeeks.org/backtracking-to-find-all-subsets/)
[Josephus Problem](https://www.geeksforgeeks.org/josephus-problem-set-1-a-on-solution/)
[Print all permutations of a string](https://www.geeksforgeeks.org/write-a-c-program-to-print-all-permutations-of-a-given-string/)
[Subset sum problem](https://www.geeksforgeeks.org/subset-sum-problem-dp-25/)

Until next time, happy coding! :tada: :computer:
