---
title: 'Execution Context Demystified'
date: 2023-03-25T14:14:58+05:30
draft: false
description: 'Functions, callbacks and execution context'
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - HOF
  - Higher Order Functions
  - execution context
  - demystified
categories:
  - javascript
series:
  - JS Hard Parts
---

Greetings! :wave:,

Welcome to the first part of the [JS Hard Parts: Demystified]({{< ref "/posts/js-hard-parts.md">}}) series. In this post, we will delve into the concepts of callbacks, execution context, functions, and higher-order functions. So let's get started without any delay :rocket:

Before we proceed, I assume that you already have knowledge of writing loops, functions, and [call stack](https://developer.mozilla.org/en-US/docs/Glossary/Call_stack) 

## Functions, callbacks and execution context

Let's take an example to understand the concepts better. We have a function called `copyArrayAndMultiplyBy2` that accepts an array, multiplies each element of the array by 2, and returns the new array.

```js
function copyArrayAndMultiplyBy2(arr){
	const output = [];
	for(let i = 0; i < arr.length; i++){
		output.push(arr[i]*2)
	}
	return output
}
const myArr = [1,2,3];
const result = copyArrayAndMultiplyBy2(myArr);
``` 
When this code is interpreted, it executes as follows:

{{< img src="/images/blog-img/cm.jpeg" alt="copyAndMultiplyBy2" width="400px" position="center" >}}


1. A function labeled `copyArrayAndMultiplyBy2` with a value of function is created in the **global memory** (interpreter just has a memory of it, didn't execute it yet).
2. The array myArr is created in the global memory.
3. When result = `copyArrayAndMultiplyBy2(myArr)` is executed, **an execution context is created as soon as it sees `()`**, *the arguments passed in become parameters*. The interpreter goes to line 2, and `copyArrayAndMultiplyBy2` is simultaneously pushed onto the call stack.
4. Now we have access to [1,2,3] inside the local memory, next an empty array with label output is created.
5. A loop is executed, and a new result [2,4,6] is copied into output.
6. Once the value is returned, *the value goes back to the global memory*, and stores the value of [2,4,6] in the result. **As soon as the function is returned, the global execution context is deleted from the memory, and the call from the call stack is popped off.**

> PS: Remember `global()` in node.js or `window` object in javascript is always the first item on the callstack.

Now, let's suppose we want to divide each element by 2 in the array. We write a similar function, `copyArrayAndDivideBy2` with some modification in the logic:

```js
function copyArrayAndDivideBy2(arr){
	const output = [];
	for(let i = 0; i < arr.length; i++){
		output.push(arr[i]/2)
	}
	return output
}
const myArr = [1,2,3];
const result = copyArrayAndDivideBy2(myArr);
```

This is how it is interpreted :

{{< img src="/images/blog-img/cd.jpeg" alt="copyAndDivideBy2" width="400px" position="center" >}}

Did you observe something? this function **violates the D.R.Y (Don't Repeat Yourself) principle.**

Can we optimise this?

## Higher Order Functions (Pass Functionality as a Parameter)

We could generalize our function and **pass in our specific instruction**(pass in the functionality (*a.k.a **Callback function***)) only when we run `copyArrAndManipulate` using **Higher Order Functions (HOF)**:

```js
function copyArrayAndManipulate(arr, instruction){
	const output = [];
	for(let i = 0; i < arr.length; i++){
		output.push(instruction(arr[i]))
	}
	return output
}

function multiplyBy2(input){
	return input * 2
}

const myArr = [1,2,3];
const result = copyArrayAndManipulate(myArr, multiplyBy2);
```
In this case, we pass in a specific instruction (the `multiplyBy2` callback function) to the `copyArrayAndManipulate` function. The `copyArrayAndManipulate` function takes care of executing the `multiplyBy2` instruction on each element of myArr and returns the manipulated array result.

{{< img src="/images/blog-img/cm1.jpeg" alt="copyAndManipulate" width="400px" position="center" >}}



Interpreter executes this as follows:

{{< img src="/images/blog-img/cm2.jpeg" alt="copyAndManipulate" width="400px" position="center" >}}

Does this function `copyArrayAndManipulate` remind you of anything?. Yes, it's the polyfill of `Arrays.map()` 

How is this possible?

Functions in JavaScript are **first-class citizens**, which means that they are treated like any other value, such as a string, number, or object. This means that functions can be passed as arguments to other functions, returned as values from functions (*a.k.a. **HOF** *), and stored in variables or data structures just like any other value.

This property of functions being first-class citizens is a **key aspect of the functional programming paradigm**, which emphasizes the use of higher-order functions and treating functions as values that can be manipulated and composed to create more complex functionality.

HOFs and callbacks make the code simpler, readable, and **D.R.Y**

### Examples:
1. Declarative readable code - `map()`, `filter()`, `reduce()`
2. Asynchronous JS - Callbacks are core aspect of async JS and are underhood of promises, async/await
   

Until next time, Happy coding! :tada: :computer:

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.