---
title: "React Fundamentals: Understanding JSX"
url: "/posts/understanding-jsx"
date: 2021-05-19T12:47:25+05:30
draft: true
description: "JSX basics and its usage"
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - react
categories:
  - react
series:
  - Epic React
---

Hey, there :wave:

Welcome to the 3rd article of the [Epic React Series]({{< ref "/posts/12-epic-react-intro.md">}}) which is based on the workshop [EpicReact.dev](https://epicreact.dev/) by [Kent C. Dodds](https://kentcdodds.com/). If you haven't read the previous article of this series, I recommend you to go read it first before proceeding further.

1. [JS Fundamentals for React]({{<ref "/posts/13-js-fundamentals-for-react.md">}})
2. [Intro to Raw React APIs]({{<ref "/posts/17-intro-to-raw-react-apis.md">}})

In the previous article we understood about raw react APIs, especially `React.createElement()` and `ReactDOM.render()`. In this article, lets understand what is JSX and its significance.

\*\* _All the examples used in this series are taken from [Epic React.dev](https://epicreact.dev/) workshop_

Let's get started... shall we?

Using JSX, it is much easier to understand when reading the code, compared to raw react APIs. It’s a simple HTML-like syntactic sugar on top of the raw React APIs

```jsx
const ui = <h1 id="greeting">Hey there</h1>;

// ↓ ↓ ↓ ↓ compiles to ↓ ↓ ↓ ↓

const ui = React.createElement("h1", { id: "greeting", children: "Hey there" });
```

Since JSX is not understood by javascript compiler, we need a special compiler called [Babel](https://babeljs.io/) which converts the JSX code to JS, so that our JS compiler can undestand.

- If you would like to see how JSX gets compiled to JS, check out this [Babel REPL](https://babeljs.io/repl#?browsers=defaults%2C%20not%20ie%2011%2C%20not%20ie_mob%2011&build=&builtIns=App&corejs=3.6&spec=false&loose=false&code_lz=MYewdgzgLgBArgSxgXhgHgCYIG4D40QAOAhmLgBICmANtSGgPRGm7rNkDqIATtRo-3wMseAFBA&debug=false&forceAllTransforms=false&shippedProposals=false&circleciRepo=&evaluate=false&fileSize=false&timeTravel=false&sourceType=module&lineWrap=true&presets=react&prettier=true&targets=&version=7.14.3&externalPlugins=)

- Generally we’ll compile all of our code at build-time before pushing it to the production. We will not follow the approach of using babel, that we are following in this article, you will understand how to do that in the future articles.
- Since JS doesnt know which part of code needs to compiled by Babel, we need to specify it by wrapping the JSX code in between `<script type="text/babel"> and </script>` to avoid errors. By looking at `type=text/babel` JS understands which piece of code needs to be compiled by Babel.

To add Babel to your application through CDN:

```html
<script src="https://unpkg.com/@babel/standalone@7.9.3/babel.js"></script>
```

Lets take our example from previous article and convert it to jsx

```jsx
const rootElement = document.getElementById("root");

const helloEle = React.createElement("span", {}, "Hello");
const worldEle = React.createElement("span", {}, "World");

const element = React.createElement("div", {
  className: "container",
  children: [helloEle, " ", worldEle],
});

//using JSX
const element = (
  <div id="root">
    <div className="container">
      <span>Hello</span>
      <span>World</span>
    </div>
  </div>
);
```

You can notice how easier it is to use JSX rather than `React.createElement()`.

Recommended Read:

- [React Docs : Introducing JSX](https://reactjs.org/docs/introducing-jsx.html)

## Props in JSX

```jsx
const element = React.createElement("div", {className:"container"}, children:"Hello world")

//using JSX
const element = <div className="container">Hello world</div>
// we can also write it as
const element = <div className="container" children="Hello world" />
```

- Notice that JSX allows us to have a self closing `div` unlike html and also we use `className` instead of `class`.
- JSX props are camelCased.

### With multiple props

```jsx
const element = React.createElement("div", {className:"container", id:"hw"}, children:"Hello world")
//using jsx
const element = <div className="container" id="hw">Hello world</div>
```

## Interpolation in JSX

> “Interpolation” is defined as "the insertion of something of a different nature into something else."

We have already seen interpolation before, using string template literals.

```js
const greeting = "Sup";
const subject = "World";
const message = `${greeting} ${subject}`;
```

### How does this work in JSX?

```jsx
const className = "container";
const children = "Hello World";
const element = <div className="hmmm">how do I make this work?</div>;
```

Our goal here is to extract the className ("container") and children ("Hello World") from the above example to variables and interpolate them in the JSX.

```jsx
//without interpolation
const element = <div className="container">Hello world</div>;

//using interpolation
const name = "container";
const text = "Hello world";
const element = <div className={name}>{text}</div>;
```

- Notice how we are interpolating data into JSX by wrapping them between curly braces`{}`

Babel compiles this down to

```js
const element = React.createElement("div", { className: name }, text);
```

Recommended Reads:

- [Embedding expressions in JSX](https://reactjs.org/docs/introducing-jsx.html#embedding-expressions-in-jsx)
- [Specifying attributes with JSX](https://reactjs.org/docs/introducing-jsx.html#specifying-attributes-with-jsx)

## Spreading the props

Apply props to this code:

```js
const children = "Hello World";
const className = "container";
const props = { children, className };
const element = <div />; // how do I apply props to this div?
```

without JSX

```js
const element = React.createElement("div", props);
```

lets say we want to add an id prop, we can add extra props to the element using spread

```js
const element = React.createElement("div", { id: "hw" }, ...props);
```

Using JSX

```jsx
const element = <div {...props} />;
```

If we add an extra prop

```jsx
const element = <div id="hw" {...props} />;
//babel converts this to

const element = React.createElement("div", _extends({ id: "hw" }, props));
```

Babel add an extra helper function called `_extends()` which is basically `Object.assign()`, which is kind of a what object spread syntax does, its kind of syntactic sugar on top of `Object.assign()`.

- [MDN: Object.assign()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign)

- **Note:** The order of inserting props matters. The props which are added later overrides the previous values.

```jsx
const props = { className: "container", id: "hw" };
const element = <div className="default" {...props} />; //className would be container and id is hw

//if we add className after the props

const element = <div {...props} className="default" />; // className would be default and id is hw
```

Recommended Read:

- [Spread Attributes](https://reactjs.org/docs/jsx-in-depth.html#spread-attributes)

That's all for now, in the next article you'll learn how to create custom components.

Until next time :wave:, Happy learning! :tada: :computer:

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others.