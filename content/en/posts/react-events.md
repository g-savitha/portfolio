---
title: "Event handling in React"
date: 2023-06-17T22:33:33+05:30
draft: false
description: 'Event Handling in React'
hideToc: false
enableToc: false
pinned: false
enableTocContent: true
tags:
 - react
 - jsx
 - event handling
categories:
  - react
---

## Intro

In javascript, this is how we have handle events:

```js
const btn = document.querySelector(".submit-btn");
function doSomething(){
  //Perform desired actions
}
btn.addEventListener('click',doSomething())
```
Here we are listening to a `click` event when a button with class name `.submit-btn` is called. A function is passed *as a reference* to handle that event.

Alternatively, we can embed the event handler directly in HTML:

```html
<button class="submit-btn" onclick ="doSomething()">Submit</button>
```

**React follows this pattern**. We pass an event handler as a prop to JSX.


```jsx
const App = () =>{
const doSomething = () =>{
  //Perform desired actions
}
return (
  <button onClick = {doSomething}>Submit</button>
);
}
```

Even if you add events using `addEventListener()` it still gives the same output, but ***this is a recommended way to handle events in react***(Sometimes we use `addEventListener` for window-level events).

Here are few good reasons why:

1. **Automatic cleanup** : If we use `addEventListener` we have to remove it using `removeEventListener` to avoid ***memory leaks***. When we use `onX` props pattern, React automatically cleans up the event listeners for us.
2. **Improved Performance** : When we give control to React for managing the event listeners, it can optimise things for us like batching multiple listeners at once to reduce the memory consumption.
3. **No DOM Interaction** : In order to use `addEventListener` we have to go and interact with DOM directly, which we need to avoid in React. React prefers us to stay within its abstraction and does all the DOM manipulation on our behalf.

## Functions as a reference

We pass functions as a reference in JSX, if we don't, the function gets called immediately(which we dont want to happen). When we pass function as a reference, React calls whenever it wants to. 

Here in this example, React should call the function only when a click event is occured.

```jsx
// ✅ Correct approach:
<button onClick={doSomething} />

// 🚫 Incorrect approach:
<button onClick={doSomething()} />
```

If we translate this JSX into JS, here's how it looks:

```js
// ✅ Correct:
React.createElement('button', {onClick:doSomething}); // react calls this function

//🚫 Incorrect:
React.createElement('button', {onClick:doSomething()}); // function gets called immediately
```

But what if I want to pass some arguments?

## Passing arguments

If we want to pass the arguments, we can't do it this way:

```jsx
//🚫 Incorrect: Calls the function without argument
<button onClick={doSomething} />
```

If we pass the arguments, the function gets called immediately:

```jsx
//🚫 Incorrect: Calls the function immediately
<button onClick={doSomething(args)} />
```

How can we pass the arguments then?

*wrap it in an anonymous wrapper function*:

```jsx
// ✅ Correct:
<button onClick={()=>doSomething(args)} />
```

Here we're creating an *arrow function* and passing it to React, ensuring the function gets called when a button is clicked.

### Is there any other way?

Yes, using  the `bind` method:

```jsx
// ✅ Correct:
<button onClick={doSomething.bind(null,args)} />
```

This is a much less conventional way in React community. People mostly prefer to use the previously suggested method.

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.

