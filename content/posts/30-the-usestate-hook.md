---
title: "Unpacking the useState hook"
url: "/posts/the-usestate-hook"
date: 2023-06-18T09:47:20+05:30
draft: false
description: 'Unpacking the useState hook'
hideToc: false
enableToc: true
pinned: false
enableTocContent: true
tags:
 - react
 - hooks
categories:
  - react
---

## Intro

**What is a hook?**

A hook is a special function, which lets you to "*hook into*" React internals. `useState()` is one of the hooks.

`useState` takes an initial value and returns an array of 2 items:
1. The current value of a state
2. A function to set the value of a state.

```jsx
//syntax
const [state, setState] = useState(initialValue)
```

The name of `state and setState` variables can be anything. 

```jsx
// 🚫 Not recommended
const [namaste, kaiseHo] = useState("🙏🏻")

//namaste is the state variable
//kaiseHo is the function to set the state `namaste`
```

that being said, it is recommended to follow the convention of `x, setX`.

```jsx
// ✅ Recommended Approach
const [namaste, setNamaste] = useState("🙏🏻")
```

**Initial Value:**

React state variables are given an initial value.
```jsx
const [count,setCount] = useState(1);
console.log(count); //1
```

We can also supply a *function* as an initial value. React will call this at the very first render to calculate the initial value

```jsx
const [count,setCount] = useState(()=>1+1);
console.log(count); //2
```

This secondary form is used rarely, like when we need to do an expensive operation to calculate an initial value. 

Eg: Reading from localStorage

```jsx
const [count, setCount] = useState(() => {
  return window.localStorage.getItem('saved-count');
});
```

If you observe carefully, here we are passing a function to `useState()`(We are not calling `window.localStorage` directly in `useState`). 
```jsx
//🚫  
const [count,setCount] = useState(window.localStorage.getItem('saved-count'))
```
It's upto React to decide what to do with it. By passing a function we are not calling `window.localStorage` on every render. On the very first render, React will call this function to get an initial value, it ignores for subsequent renders.

So lets get back to the state, we know that our state can be changed using a setter function. 

**How does this work actually?**

That brings us to a concept called **Core React Loop**

## Core React Loop
Let's continue with the previous example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      value: {count}
    </button>
  );
}
```

Behind the scenes, this gets converted to JS

```js
function Counter() {
  const [count, setCount] = React.useState(0);

  return React.createElement(
    'button',
    { onClick: () => setCount(count + 1) },
    'value :',
    count
  );
}
```

When this code is run, `React.createElement`produces a React element which is a POJO, which looks like this:

```js
{
  type: 'button',
  key: null,
  ref: null,
  props: {
    onClick: () => setCount(count + 1),
  },
  children: 'value: 0',
  _owner: null,
  _store: { validated: false }
}
```

Let's visualise this js object as the following HTML snippet:

```html
<button>value: 0</button>
```

Our React element, that JS object, is describing the DOM structure. React takes that description and turns into a real DOM node. Here its creating a `<button>` and appending it to the page. It also attaches all our event handlers (here its not shown in the snippet for the sake of brevity, but React does it).

Now, **What happens when we click the button?**

`setCount()` will be called and the count will be updated to 1 from 0. **Whenever a state variable is updated it triggers a re-render**. React once again calls the Counter function, creating a brand new React element, a new description of UI we want.

New DOM structure after re-render
```html
<button>value: 1</button>
```

(HTML is shown here to demonstrate the things easily, in reality React deals with JS objects that describes this markup)

**Each render is like taking a snapshot**

React has two snapshots now:
```html
<!--1st snapshot: Before the update -->
<button>value: 0</button>
```
```html
<!-- 2nd snapshot: After the update -->
<button>value: 1</button>
```

When a user clicks a button, the 2nd snapshot was generated. React has to figure out *how to update DOM* now, so that it matches last snapshot. It's like React has to play a *spot the difference* game between 2 snapshots, to figure out the differences between two.

This process is known as ***reconcillation***. React uses this algorithm to check the differences between two snapshots.

Now, once React has figured out the differences between two snapshots, it has to ***Commit*** those changes. It updates the DOM with only the things that have been changed.

{{< img src="/images/blog-img/react-core-loop.jpeg" alt="react-core-loop-image" width="400px" position="center" >}}

### Rendering vs Painting

Let's look at this example

```jsx
function CheckAgeLimit({ age }) {
  if (age < 18) {
    return (
      <p>Not old enough!</p>
    );
  }

  return (
    <p>Adult!</p>
  );
}
```

We check for age limit here, and one of the two paragraphs is returned based on the input.

Let's suppose we re-render this component

Before snapshot:
```js
age: 16

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "Not old enough!",
}
```
After snapshot:
```js
age: 17

{
  type: 'p',
  key: null,
  ref: null,
  props: {},
  children: "Not old enough!",
}
```

Nothing has changed in the UI, so *no DOM Manipulation*.

When we say re-rendering, we're checking if anything is changed between the snapshots. If there is any difference, React will need to update the DOM. When React updates the DOM, browser needs to ***re-paint*** it.

Refer Official React docs to learn about [Render and Commit](https://react.dev/learn/render-and-commit) in depth.


## Asynchronous State updates

What do you think will be the output of the following code?

```jsx
const App = () => {
  const [count, setCount] = useState(0);
  return (
    <>
      <p>
        {count}
      </p>
      <button
        onClick={() => {
          setCount(count + 1);
          console.log(count)
        }}
      >
        Click me!
      </button>
    </>
  );
}
```

If you have guessed the output as 1. You're wrong. The output is 0. Wait, what????

Here's the catch: **State setters aren't immediate**

When we call `setCount()`, state doesn't gets updated immediately, it waits for an existing process to complete(processing the click here) and then it updates the value and triggers a re-render.

**Updating a state variable is asynchronous**. It's a scheduled update, it affects the state for the next render.

Here's the fix for the above code:

```jsx
const App = () => {
  const [count, setCount] = useState(0);

  return (
    <>
      <p>
       {count}
      </p>
      <button
        onClick={() => {
          const nextCount = count + 1;
          setCount(nextCount);

          console.log(nextCount)
        }}
      >
        Click me!
      </button>
    </>
  );
}
```

Now we have access to the new value right away. We store the updated value, so that we can have access whenever we want to.

Can't updating a state variable be simple?

{{< img src="/images/blog-img/state-meme.png" alt="updating-a-state-meme" width="400px" position="center" >}}


## What's all this fuss about?
The above image, represents the state in [Svelte](https://svelte.dev/). 

Why does we have to go through all this pain of writing a syntax to declare and update a state, why can't we do it in a simpler way like we do in Svelte?

The reason is Svelte puts a curtain on all the complexity behind.

Let's try to do it Svelte's way:

```jsx
const App = () => {
 let count = 0;

  return (
    <>
      <p>
       {count}
      </p>
      <button
        onClick={() => {
         count = count + 1;
        }}
      >
        Click me!
      </button>
    </>
  );
}
```

It doesn't work! 

Let's look at javascript for a second

```js
function counter(){
  let count = 0;
  count = count + 1;
}
counter() // 1
counter() // 1
counter() // 1
```
no matter how many times, we call, we get the same output everytime. Why? JS Engine signals garbage collector, saying we're not doing anything with this function, just wipe it out. We can move the count variable outside and update it., but that's not what we're looking at.

Components in JS are eventually functions,

If we render our app:

```jsx
ReactDOM.render(<App />)
//gets converted to 
ReactDOM.render(React.createElement())
//that eventually gets converted to POJO
ReactDOM.render({type : App, props: {}...})
```

When we invoke this function everytime we are triggering a new render. Inside React we are calling `App()` again and again. The problem here is everytime we re-render the component we are resetting the value to 0. 

What if I move the count to outside the component?

How do you know, if its a state then if it isn't in the component? How are we going to have multiple instances of this component? So it needs to be defined within a component, so that every instance can have its own dynamic state.

So how are we able to persist the state variable then? Is it because of closures? 

It is easy to get tricked into the assumption of using closures behind the scenes, but in reality it's not the closures.

If you look at the definition of closures according to Kyle Simpson:

> "Closure is when a function is able to remember and access its lexical scope even when that function is executing outside its lexical scope."

Or as Will Sentance calls it as a "backpack".  The function puts the values from the same scope inside the backpack, even after you pass the function off to things like onClick. Function can pull the values out whenever it needs them. By extension, though, this also means that you can't have closure without a function definition.

If you observe this piece of code carefully

```jsx
const [value, setValue] = useState(0);
```

there ain't any function definitions involved. We are just calling the function, but we're not creating or defining one. So there's *no chance of Closures to happen*.

What's happening then?

Here comes the interesting part, React has an *internal place* where it stores all the values and those values are accessed via `useState()` hook. That brings us to a concept called ***Component Instances***

## Component instances?

Whenever we render a component for the first time, we “mount” the component. Mounting a component involves two steps:
   1. We evaluate the returned JSX and pass it onto React, so that React can create the corresponding DOM elements.
   2. We create a ***component instance***, **a long-lived object that knows all the contextual information about this particular instance of the component.**

So the state, is stored in that particular instance. Whenever we write `React.useState()` this code "hooks into" the instance, setting and getting the state from the instance. Whenever we unmount a component, we lose the state because our component instance gets destroyed. 

That's all folks!

Hope that was not convoluted and crazy! Until next time, happy coding :computer: :tada:

