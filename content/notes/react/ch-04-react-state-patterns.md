---
title: "React State Patterns"
date: 2020-08-24T15:52:45+05:30
draft: true
tags: [react, javascript, es6]
categories: [react]
sources: ["https://www.udemy.com/course/modern-react-bootcamp/"]
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

# Setting State Using State

We know that `setState()` is asynchronous…

So: it’s risky to assume previous call has finished when you call it. Also, _React will sometimes batch (squash together) calls to `setState` together_ into one for performance reasons. If a call to `setState()` depends on current state, the safest thing is to use the alternate “callback form”.

## setState Callback Form

`this.setState(callback)`

Instead of passing an object, **pass it a callback** with the _*current state*_ as a _*parameter*_. The _callback_ should _return an object_ representing the _new state_.

```js
this.setState((curState) => ({ count: curState.count + 1 }));
```

### Abstracting State Updates

The fact that you can pass a function to `this.setState` lends itself nicely to a more advanced pattern called **functional setState**.

Basically you can describe your state updates abstractly as separate functions. But why would you do this?

```js
// elsewhere in the code
function incrementCounter(prevState) {
  return { count: prevState.count + 1 };
}
// somewhere in the component
this.setState(incrementCounter);
```

Because testing your state changes is as simple as testing a plain function:

```js
expect(incrementCounter({ count: 0 })).toEqual({ count: 1 });
```

> This pattern also comes up all the time in Redux!

Here is a nice opinionated article on the subject of using [functional setState](https://medium.freecodecamp.org/functional-setstate-is-the-future-of-react-374f30401b6b)

## Mutable Data Structures in State

### Mutable Data Structures

We know how to set state to primitives: mainly numbers and strings. But component state also commonly includes objects, arrays, and arrays of objects.

```js
this.state = {
  // store an array of todo objects
  todos: [
    { task: "do the dishes", done: false, id: 1 },
    { task: "vacuum the floor", done: true, id: 2 },
  ],
};
```

> You have to be extra careful modifying your array of objects!

```js
completeTodo(id) {
  const theTodo = this.state.todos.find(t => t.id === id);
  theTodo.done = true; // NOOOOO -> WRONG WAY

  this.setState({
    todos: this.state.todos // bad -> VERY BAD WAY TO SET LIKE THIS
  });
}
```

Why? It’s a long story…

_Mutating nested data structures_ in your state _can cause problems w/ React_. (A lot of the time it’ll be fine, but that doesn’t matter. Just don’t do it!)

### Immutable State Updates

A much better way is to _**make a new copy of the data structure**_ in question. We can _**use any pure function**_ to do this…

```js
completeTodo(id) {

  // Array.prototype.map returns a new array
  const newTodos = this.state.todos.map(todo => {
    if (todo.id === id) {
      // make a copy of the todo object with done -> true
      return { ...todo, done: true };
    }
    return todo;  // old todos can pass through
  });

  this.setState({
    todos: newTodos // setState to the new array
  });
}
```

Pure functions such as _*`.map`*_, _*`.filter`*_, and _*`.reduce`*_ are your friends. So is the _*`…`*_ spread operator.

There is a _slight efficiency cost_ due to the _O(N) space/time required to make a copy_, but it’s almost always worth it to ensure that your app doesn’t have extremely difficult to detect bugs due to mischevious side effects.

### Immutable State Summary

- While it sounds like an oxymoron, immutable state just means that there is an _*old state object*_ and a _*new state object*_ that are both _snapshots in time_.
- The _safest way_ to update state is to _**make a copy of it**_, and _then call this.setState_ with the _new copy_.
- This pattern is a good habit to get into for React apps and required for using Redux.

## Designing State

Designing the state of a React application (or any modern web app) is a challenging skill! It takes practice and time! However, there are some easy best-practices that we can talk about in this section to give you a jump-start.

### Minimize Your State

In React, you want to try to _**put as little data in state**_ as possible.

Litmus test

- does x change? If not, _~~x should not be part of state~~_. It should be a _*prop*_.
- is _x already captured_ by some other value y _in state or props_? **Derive it from there instead**.

### Bad Example of State Design

Let’s pretend we’re modelling a Person…

```js
this.state = {
  firstName: "Matt",
  lastName: "Lane",
  birthday: "1955-01-08T07:37:59.711Z",
  age: 64,
  mood: "irate",
};
```

- Does Matt’s first name or last name ever change? Not often I hope…
- Does Matt’s birthday ever change? How is that even possible!
- Matt’s _age_ does _change_, however if we had `this.props.birthday` we could easily derive it from that.
- Therefore, the only property here that is _truly stateful_ is arguably _mood_ (although Matt might dispute this 😉).

### Fixed Example of State Design

```js
console.log(this.props);
{
  firstName: 'Matt',
  lastName: 'Lane',
  birthday: '1955-01-08T07:37:59.711Z',
  age: 64
}

console.log(this.state);
{
  mood: 'insane'
}
```

### State Should Live On the Parent

Its better to support "downward data flow" philosophy of React. In general, it makes more sense for a **parent component to manage state** and have a bunch of “dumb” stateless child display components. This _makes debugging easier_, because the _state is centralized_. It’s easier to predict where to find state:

_Is the current component stateless?_ _Find out what is rendering it_. There’s the _*state*_.

#### Todo Example:

```js
class TodoList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      todos: [
        { task: "do the dishes", done: false, id: 1 },
        { task: "vacuum the floor", done: true, id: 2 },
      ],
    };
  }
  /* ... lots of other methods ... */
  render() {
    return (
      <ul>
        {this.state.todos.map((t) => (
          <Todo {...t} />
        ))}
      </ul>
    );
  }
}
```

**TodoList** is a smart parent with _lots of methods_, while the individual **Todo** items are _just `<li>` tags_ with some text and styling.
