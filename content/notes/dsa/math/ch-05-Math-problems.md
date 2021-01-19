---
title: 'Problems on Math'
date: 2021-01-15T13:02:06+05:30
draft: false
tags: ["math", "ds-algo", "programming", "competitive-programming"]
categories: [dsa, math]
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

## Find number of digits in a number

> Given an integral number N. The task is to find the count of digits present in this number. Lets say n = 2020, number of digits in 2020 = 4 and digits are 2,0,2,0

_A simple solution is.._

- Check if number n != 0
- increment count of digits by 1 if n !=0
- reduce number by dividing it with 10
- repeat above steps, until n is reduced to 0

```cpp
//iterative
int countDigits(long n){
    int count = 0;
    while(n > 0){
        n = n/10;
        ++count;
    }
    return count;
} // TC: O(digitsCount), SC: O(1)

//recursive
int countDigits(long n){
    if(n==0) return 1;
    return 1+ countDigits(n/10);
} // TC: O(digitsCount), SC: O(digitsCount)
```

_Another approach_ :

Convert number to string and find string length

```java
    public static int countDigits(long n) {
        String num = Long.toString(n);
        return num.length();
    }//TC: O(1), SC:O(1)
```

_A better solution.._

Use Logarithmic approach to solve this problem. This can be easily obtained by using a formula

> number of digits in N = log10(N) + 1. log(123) = 2.08 => 2.08+1 = 3.08 floor(3.08) is 3.

```java
    public static long countDigits(long n) {
        if (n == 0)
            return 0;
        return (int) Math.floor(Math.log10(n) + 1);
    } //TC: O(1), SC:O(1)
```

## Palindrome Number

> check whether a given number is palindrome or not. Eg: n = 106601 -> true, n = 84348 -> true, n = 8 -> true. n= 21 -> false, n = 1789 -> false.

```cpp
bool isPalindrome(int n){
    int rev = 0;
    int temp = n;
    while(temp!=0){
        int lastDigit = temp%10;
        rev = rev * 10 + lastDigit;
        temp/=10;
    }
    return(rev==n);
} // TC: O(n)
```

---

## Few problems to solve
- [Absolute Value](https://practice.geeksforgeeks.org/problems/absolute-value/1/?track=DSASP-Mathematics&batchId=154)
- [Convert celsius to farenhiet](https://practice.geeksforgeeks.org/problems/convert-celsius-to-fahrenheit/1/?track=DSASP-Mathematics&batchId=154)
- 