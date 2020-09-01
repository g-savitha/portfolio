---
title: "Recursion"
date: 2020-08-23T17:17:32+05:30
draft: false
tags: ["ds-algo", "programming", "competitive-programming"]
categories: [dsa, recursion]
sources: []
---

<!--

::Annotation Guide::
~~~~~~~~~~~~~~~~~~~~

* `em` is the modifier

1. em (_text_) - blue underline
2. strong (**text**) - yelow highlight
3. del (~~text~~) - red strike-through

4. em > em (_*text*_) - blue circle
5. em > strong (_**text**_) - lawngreen box
6. em > del (_~~text~~_) - red cross-off
-->

## Intro to recursion

What is recursion?

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

```
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
    - These problems are _inherently recursive_ in nature. - _Example_ : Rat in a maze, n-queens problem. (Its easy to write recursive solns than iterative for problems like this)
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
        return; //Base Cas
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
