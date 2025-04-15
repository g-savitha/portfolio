---
title: "How to write base cases"
url : "/posts/recursion-base-cases"
date: 2021-02-20T15:46:57+05:30
draft: false
description: "Helps you in writing base cases for recursion"
hideToc: false
enableToc: true
enableTocContent: true
tags: [dsa, recursion]
categories: [dsa]
---

This post requires knowledge of [Recursion]({{< ref "/posts/8-recursion-simplified.md" >}}). If you are new here, its recommended to have a look at that post first.

Many times, when it comes to recursion, we can guess the recursive solution but it becomes difficult to understand how to write proper base cases so that everything is handled and we do not get stack overflow(incase of java) or segmentation fault(incase of cpp) errors.

## What are base cases?

**Base cases are those inputs, for which we cannot further break down the problem into smaller sub problems.**

Let's consider these examples:

### Finding factorial of a number. (n>=0)

```cpp
int factorial(int n){

    //recursive solution
    return n * factorial(n-1);
}
```

If you see recursive tree for `factorial(2)` and `factorial(3)`
{{< codes tree tree>}}
{{< code >}}

```tree
factorial(2)
|__factorial(1)
    |__factorial(0)
```

{{< /code >}}
{{< code >}}

```tree
factorial(3)
|__factorial(2)
    |__factorial(1)
        |__factorial(0)
```

{{< /code >}}
{{< /codes >}}

After `factorial(0)` we cannot break it further. So `0` is the smallest possible value for the problem. Also, every recursive call ends up calling 0, no matter with whichever number you begin with. So we write the base case here as `n==0`.

```cpp {hl_lines = [3]}
int factorial(int n){
    //base case
    if(n==0) return 1;
    //recursive solution
    return n * factorial(n-1);
}
```

Imagine if you have written a wrong base case, lets say you have written a base case as `n==1` and there's test case with n=0.

```tree
factorial(0)
|__factorial(-1)
    |__factorial(-2)
        |__factorial(-3)
        |__ ...
            |__ .. (and so on. it never ends, you end up with stackoverflow or segmentation fault error)
```

### Finding nth Fibonacci number (n>=0)

```cpp
int fib(int n){

    //recursive solution
    return fib(n-1) + fib(n-2);
}
```

Now what do we write as base case?

Remember the same thing, Base cases are those inputs for which we cannot further divide the problem into smaller sub problems.

{{< codes tree tree>}}
{{< code >}}

```tree
fib(2)
|__fib(1)
    |__fib(0)
```

{{< /code >}}
{{< code >}}

```tree
fib(3)
|__fib(2)
|  |__fib(1)
|     |__fib(0)
|__fib(1)
```

{{< /code >}}
{{< /codes >}}

Now what are the cases where we cannot divide the problem further?

Do we handle everything if we just write `n==0` as a base case? Is there any other case which we can include other than `n==0` ?

The case is `n==1`. If you simply write `n==0` as base case what will happen to recursive calls, when someone calls for `n==1`?

When you skip `n==1` as base case, our function will simply call for `fib(0) and fib(-1)` and `fib(-1)` is not a valid case for input (since n>=0). Also, `fib(-1)` further calls `fib(-2)` and the stack goes on.. which leads to stackoverflow or segmentation fault error.

In this example we need to handle two base cases(n==0 & n==1)

```cpp {hl_lines = [3,4]}
int fib(int n){
    //base cases
    if(n==0) return 0;
    if(n==1) return 1;
    //recursive solution
    return fib(n-1) + fib(n-2);
}
```

You can optimise the above code with only one base case

```cpp {hl_lines = [3]}
int fib(int n){
    //base case
    if(n<=1) return n;
    //recursive solution
    return fib(n-1) + fib(n-2);
}
```

Hopefully that was helpful to some extent. Until next time, Happy coding! :tada: :computer:

