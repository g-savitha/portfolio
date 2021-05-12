---
title: "Promises Explained"
date: 2021-05-12T05:30:10+05:30
draft: false
description: "Promises : A pattern to write async code in JS"
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - async
categories:
  - javascript
image: https://www.freecodecamp.org/news/content/images/2020/06/Ekran-Resmi-2020-06-06-12.21.27.png
---

Promises are one of the important concepts in javascript one should be familiar with.

**Pre-requisite:** Before going into promises you need to understand what is asynchronous code, how it works, what are callbacks and why are promises introduced.

Checkout [Asynchronous Code in JavaScript]({{< ref "/posts/async-code-in-js.md">}})

Once you understand that, without making any further delay lets get started..

## Intro to Promises

> A promise is an object representing the eventual completion(usually which takes time) or failure of an asynchronous operation.

Promises allow us to write an asynchronous code that is much easier to read and understand. Its much flatter, its not so nested.

If you have checked out [this post]({{< ref "/posts/async-code-in-js.md">}}) you might be familiar with the Callback example we used.

The same code after using promises, looks like this...

```js
moveXPromise(btn, 100, 000)
  .then(() => moveXPromise(btn, 100, 1000))
  .then(() => moveXPromise(btn, 200, 1000))
  .then(() => moveXPromise(btn, 300, 1000))
  .then(() => moveXPromise(btn, 500, 1000))
  .then(() => moveXPromise(btn, 500, 1000))
  .catch((position) => {
    alert("Cannot move further");
  });
```

I remember promises as `A pattern to write async code.`

When we work with promises there are only 2 different things we need to understand

1. How you create a promise. How you could create a function that returns a promise.
2. How you consume and interact with the promises (which we do all the time, even if we are not writing promises ourselves. we might make a req from a library or using a library like axioms )

So promise is a way of promising a value that you may not have at the moment. Its a guarantee or supposed guarantee of an eventual value.

If you are making a HTTP request it could take time and may never return the value. It might be a failure or success and you might get some data backfrom an API but it takes time. So the object that is returned in the meantime is a promise and we attach a callback to it.

> Note:
> A promise is a returned object to which you attach callbacks, instead of passing callbacks into a function.

### Creating a Promise

Syntax:

```js
const createPromise = new Promise((resolve, reject) => {});
```

`resolve` and `reject` are actually functions. At any point inside of the function, if we call `resolve` , promise will be resolved. If we call `reject`, promise will be rejected

```js
const willGetYouADog = new Promise((resolve, reject) => {});
/*[[PromiseStatus]] : "pending"
[[PromiseValue]] : undefined*/
```

- _pending status is what we see frequently when a promise is first started_

> Note:
> If you dont resolve or reject a promise, its status will be pending and its value will be undefined
> PromiseStatus : "pending"
> PromiseValue : undefined

If you simply call reject

```js
const willGetYouADog = new Promise((resolve, reject) => {
  reject();
});
//We get an error that we didnt catch (in console), Error : Uncaught in promise
//[[Promise Status]]  : rejected
//[[Promise Value]] : undefined

// Instead if we resolve:

const willGetYouADog = new Promise((resolve, reject) => {
  resolve();
});
//No error
//[[Promise Status]]  : resolved
//[[Promise Value]] : undefined
```

Lets write a logic for a promise, which randomly resolves or rejects a promise.

```js
const willGetYouADog = new Promise((resolve, reject) => {
  const rand = Math.random();
  if (rand < 0.5) resolve();
  else reject();
});
```

This is the first part of how we create a promise. The extremely important part is how we interact with the promise when it is rejected and when it is resolved. This is where we use `.then()` & `.catch()` methods.

### Interacting with promises

When a promise is resolved it automatically runs `.then()` and when a promise is rejected it automatically runs `.catch()`

```js
const willGetYouADog = new Promise((resolve, reject) => {
  const rand = Math.random();
  if (rand < 0.5) resolve();
  else reject();
});
willGetYouADog.then(() => {
  console.log("Yay we got a dog!");
});
willGetYouADog.catch(() => {
  console.log("No dog :(");
});
```

If we do neither, status remains pending until its resolved or rejected

### Returning Promises from functions

```js
const makeADogPromise = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const rand = Math.random();
      if (rand < 0.5) resolve();
      else reject();
    }, 5000);
  });
};

//we can actually chain the methods instead of creating another promise by calling makeADogPromise.catch()
// if we create 2 seperate promises we may not resolve or we may not reject. We can have different values
//but instead if we chain, we get around that problem
// we will not be wasting any extra space by creating a new variable
//(d = make .. d.then() , d.catch()) by chaining and also we wont be creating an extra reference to a promise again.
//only one of the other will run if we do  chaining
makeADogPromise
  .then(() => {
    console.log("Yay we got a dog!");
  })
  .catch(() => {
    console.log("No dog :(");
  });
```

Returning a promise from functions is a very common pattern.

Example:

```js
axios.get("/reddit.com").then().catch();
```

Axios is returning a promise by executing the get() function

## Resolving or rejecting with values

When you resolve or reject a promise you can reject or resolve with a value and **you have access to that value in callback that you pass into `then` or `catch`**

An example to check if a url exists in the object and pass the data and status code based on the user's request

```js
const fakeRequest = (url) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const pages = {
        "/users": [
          { id: 1, username: "bob" },
          { id: 5, username: "clarke" },
        ],
        "/about": "This is about page",
      };
      const data = pages[url];
      if (data) resolve({ status: 200, data: data });
      else reject({ status: 404 });
    }, 3000);
  });
};
//runs then()
fakeRequest("/users")
  .then((res) => {
    console.log("Status code", res.status);
    console.log("Data", res.data);
    console.log("Request worked");
  })
  .catch((res) => {
    console.log(res.status);
    console.log("Request failed");
  });
// runs catch(), coz we dont have /dogs url
fakeRequest("/dogs")
  .then((res) => {
    console.log("Status code", res.status);
    console.log("Data", res.data);
    console.log("Request worked");
  })
  .catch((res) => {
    console.log(res.status);
    console.log("Request failed");
  });
```

## Promise Chaining

{{< codes js js>}}
{{< code >}}

```js
const fakeRequest = (url) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const pages = {
        "/users": [
          { id: 1, username: "Bilbo" },
          { id: 5, username: "Esmerelda" },
        ],
        "/users/1": {
          id: 1,
          username: "Bilbo",
          upvotes: 360,
          city: "Lisbon",
          topPostId: 454321,
        },
        "/users/5": {
          id: 5,
          username: "Esmerelda",
          upvotes: 571,
          city: "Honolulu",
        },
        "/posts/454321": {
          id: 454321,
          title: "Ladies & Gentlemen, may I introduce my pet pig, Hamlet",
        },
        "/about": "This is the about page!",
      };
      const data = pages[url];
      if (data) {
        resolve({ status: 200, data }); //resolve with a value!
      } else {
        reject({ status: 404 }); //reject with a value!
      }
    }, 1000);
  });
};
```

{{< /code >}}
{{< code >}}

```js
fakeRequest("/users").then((res) => {
  const id = res.data[0].id;
  //make another request with id, we cant do do it outside of this scope, coz we dont have access to id outside
  //nest it here
  fakeRequest(`/users/${id}`).then((res) => {
    //access the post
    const postId = res.data.topPostId;
    //make a request to that post -> this is a 3rd request that is dependent upon 2nd and 2nd is dependent upon 1st
    fakeRequest(`/posts/${postId}`).then((res) => {
      console.log(res);
    });
  });
});
```

{{< /code >}}
{{< /codes >}}

This doesnt look much better than what we saw in callback hell and also we dont have catches yet, if we have catches for each `.then()` it would look more messier. We have much better way for rewriting all of this

What we can do is **in the callback of `.then()` return a new promise**, we can call callback of .then() of next request immediately in the same level, we dont need to nest our .then(). We can continue to chain .then() as long as we return promises in each callback.

Syntax:

```js
.then(()=>{
  return promise;
})
.then(()=>{
  return promise;
  })
.then(()=>{
  return promise;
})

```

> Note:
> The second .then() runs only if first .then() is resolved, third .then() runs only if second is resolved.

After nesting...

```js
fakeRequest("/users")
  .then((res) => {
    console.log(res);
    const id = res.data[0].id;
    return fakeRequest(`/users/${id}`);
  })
  .then((res) => {
    console.log(res);
    const postId = res.data.topPostId;
    return fakeRequest(`/posts/${postId}`);
  })
  .then((res) => {
    console.log(res);
  })
  .catch((err) => {
    console.log("OH NO!", err);
  });
```

So here is the magical part, **We only need one `.catch()`.** If any of the promise is screwed up, the catch will run immediately, we dont need to write catch for each promise. Its like a catch all :tada:

```js
// ************************************************
// ATTEMPT 2 (deliberate error to illustrate CATCH)
// ************************************************
fakeRequest("/users")
  .then((res) => {
    console.log(res);
    const id = res.data[0].id;
    return fakeRequest(`/useALSKDJrs/${id}`); //INVALID URL, CATCH WILL RUN!
  })
  .then((res) => {
    console.log(res);
    const postId = res.data.topPostId;
    return fakeRequest(`/posts/${postId}`);
  })
  .then((res) => {
    console.log(res);
  })
  .catch((err) => {
    console.log("OH NO!", err);
  });
```

> Note:
> If we screw up any promise in between, the promises after it wont be executed.

Here in the above example 1st promise is ran, second is screwed up .. so only resolved output of 1st one is shown

Using chaining, we can have multiple asynchronous actions that we want to happen one after the other(not simultaneously).

## Example

Let's refactor our previous call back hell example with promises.

```js
const moveX = (element, amount, delay) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const bodyBoundary = document.body.clientWidth;
      const elRight = element.getBoundingClientRect().right;
      const currLeft = element.getBoundingClientRect().left;
      if (elRight + amount > bodyBoundary) {
        reject(bodyBoundary, elRight, amount);
      } else {
        element.style.transform = `translateX(${currLeft + amount}px)`;
        resolve();
      }
    }, delay);
  });
};

moveX(btn, 300, 1000)
  .then(() => {
    return moveX(btn, 300, 1000);
  })
  .then(() => {
    return moveX(btn, 300, 1000);
  })
  .then(() => {
    return moveX(btn, 300, 1000);
  })
  .then(() => {
    return moveX(btn, 300, 1000);
  })
  .catch(() => {
    console.log("Out of space, cannot move");
  });
```

We can still shorten this up using implicit returns of arrow functions

```js
moveXPromise(btn, 100, 000)
  .then(() => moveXPromise(btn, 300, 1000))
  .then(() => moveXPromise(btn, 300, 1000))
  .then(() => moveXPromise(btn, 300, 1000))
  .then(() => moveXPromise(btn, 300, 1000))
  .then(() => moveXPromise(btn, 300, 1000))
  .catch(({ bodyBoundary, elRight, amount }) => {
    console.log(`Body is ${bodyBoundary} px width`);
    console.log(`Element is at ${elRight} px, ${amount} px is too large`);
  });
```

Is there any other better way other than promises? Checkout [Async and Await]({{<ref "/posts/async-await.md">}})
