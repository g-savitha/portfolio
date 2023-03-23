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

Lets have a look at this example

```js
function copyArrayAndAdd2(arr) {
  const output = [];
  for (let i = 0; i < arr.length; i++) {
    output.push(arr[i] + 2);
  }
  return output;
}

const myArr = [1, 3, 5];
const res = copyArrayAndAdd2(myArr); // [3,5,7]
```

Whenever JS interpreter looks at this code, it first creates a **Global memory**.

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.