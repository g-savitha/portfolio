---
title: 'Execution Context, Callbacks and Higher Order Functions'
date: 2022-12-14T14:14:58+05:30
draft: true
description: ''
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - HOF
categories:
  - javascript
image: https://miro.medium.com/max/1678/1*O_H6XRaDX9FaC4Q9viiRAA.png
---

Hello world :wave:,

Welcome to the 1st part of [Pillars of JS Series]({{< ref "/posts/js-hard-parts.md">}})

In this post, you are going to have a look at call stack, execution context, functions and higher order functions, without getting delayed lets get started :rocket:

If you aren't familiar with what a call stack is [check this out](https://developer.mozilla.org/en-US/docs/Glossary/Call_stack)

## Functions and Callbacks

Let's consider this example

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
When the code is interpreted, it executes as follows:

![m2](https://imgur.com/uGPWo4T)

1. A function labeled `copyArrayAndMultiplyBy2` with a value of function is created in the **global memory** (interpreter just has a memory of it, didn't execute it yet).
2. The array myArr is created in the global memory.
3. When result = `copyArrayAndMultiplyBy2(myArr)` is executed, an execution context is created as soon as it sees `()`, the arguments passed in become parameters. The interpreter goes to line 2, and `copyArrayAndMultiplyBy2` is simultaneously pushed onto the call stack.
4. Now we have access to [1,2,3] inside the local memory, next an empty array with label output is created.
5. A loop is executed, and a new result [2,4,6] is copied into output.
6. Once the value is returned, *the value goes back to the global memory*, and stores the value of [2,4,6] in the result. **As soon as the function is returned, the global execution context is deleted from the memory, and the call from the call stack is popped off.**

> PS: Remember `global()` in node.js or `window` object is always the first item on the callstack.

Now, suppose we want to write a similar function, `copyArrayAndDivideBy2`:

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

Did you observe something? this function **violates the D.R.Y (Don't Repeat Yourself) principle.**

Can we optimise this?

## Higher Order Functions (Pass Functionality as a Parameter)

We could generalize our function and pass in our specific instruction only when we run `copyArrAndManipulate` using **Higher Order Functions (HOF)**:

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
In this case, we pass in a specific instruction (the `multiplyBy2` function) to the `copyArrayAndManipulate` function. The `copyArrayAndManipulate` function takes care of executing the `multiplyBy2` instruction on each element of myArr and returns the manipulated array result.

How was this possible?

1. Functions in JavaScript are **first-class citizens**.
2. Any function that takes a function as a parameter or returns a function is known as a Higher Order Function (HOF).
3. HOFs and callbacks make the code simpler, readable, and **D.R.Y**

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.