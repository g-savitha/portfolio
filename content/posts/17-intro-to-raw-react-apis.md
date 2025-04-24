---
title: "React Fundamentals: Intro to Raw React APIs"
url: "/posts/raw-react-apis"
date: 2021-05-12T14:35:48+05:30
draft: true
description: "Intro to Raw React APIs"
hideToc: false
enableToc: true
enableTocContent: true
tags:
  - javascript
  - react
categories:
  - frontend
series:
  - Epic React
---

Hey, there :wave:

Welcome to the 2nd article of the [Epic React Series]({{< ref "/posts/12-epic-react-intro.md">}}) which is based on the workshop [EpicReact.dev](https://epicreact.dev/) by [Kent C. Dodds](https://kentcdodds.com/). If you haven't read previous article of the series, I recommend you to go and read it first before proceeding further.

- [JS Fundamentals required to get started with React]({{<ref "/posts/13-js-fundamentals-for-react.md">}})

In this post you are going to learn the very basics of react with HTML and javascript using raw React APIs. We wont be using any JSX( we will, in the upcoming posts). Many people tend to skip these concepts as working with raw react APIs is difficult to understand, but it is really important to understand these concepts, as you will see in the upcoming articles.

\*\* _All the examples used in this series are taken from [Epic React.dev](https://epicreact.dev/) workshop_

## Basic JS Hello World

Our Goal is to render the 'Hello world' onto page using javascript.

Currently our html file looks like this.

```html
<div id="root"></div>
```

What do we want?

```html
<div id="root">
  <div class="container">Hello World</div>
</div>
```

## Generate DOM Nodes

We can achieve our goal by using javascript's `document` API.

```js
//Get the root element from DOM
const root = document.querySelector("#root");
//Create a div element with classname and value inside of it
const element = document.createElement("div");
element.textContext = "Hello world";
element.className = "container";

//append element to root
root.append(element);
```

If we want to do the same thing using React

## Intro to RAW React APIs

First we need to import react scripts in our code, since javascript doesn't understand what React is. For now lets take the CDN scripts from [unpkg](https://unpkg.com/)

```html
<script src="https://unpkg.com/react@16.7.0/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16.7.0/umd/react-dom.production.min.js"></script>
```

Now, the above code using React can be written as

```js
//Gets root element from DOM
const rootElement = document.getElementById("root");
//Creates a div element for DOM
const element = React.createElement("div", {
  className: "container",
  childeren: "Hello world",
});
//appends element to root element
ReactDOM.render(element, rootElement);
```

Lets breakdown this code..

- We are getting root element from DOM using id(this didnt change, this is similar to previous code)
- In the next line we are creating a new DOM element using react's API `React.createElement`
  - For that element we are passing HTML element we want to create and properties that we want to set.
    - Note the `children` property, It takes the text we want to insert between html tags.
    - Eg: <div>Hello world</div>
    - `className` property is similar to DOM API it adds a new class to the element.
- Once we are done creating element, we are using `ReactDOM.render()` api to append our elements to the root element of the DOM.
  - ReactDOM takes two values, `elementThatWeWantToAppend` `elementThatGetsValueAppendedTo`
  - syntax: `ReactDOM.render(elementThatWeWantToAppend, elementThatGetsValueAppendedTo);`

Btw, did you notice how similar React APIs and DOM APIs are ?

## Nesting Elements

One thing i didnt tell you earlier is that we can set the chidren property as an array of elements.

So our hello world example can also be written as..

```js
React.createElement("div", { className: "container", children: "Hello world" });

//is same as

React.createElement("div", {
  className: "container",
  children: ["Hello", " ", "world"],
});
```

Now lets generate the below html snippet using react

```html
<body>
  <div id="root">
    <div class="container">
      <span>Hello</span>
      <span>World</span>
    </div>
  </div>
</body>
```

Using react

```js
const rootElement = document.getElementById("root");

const helloEle = React.createElement("span", {}, "Hello");
const worldEle = React.createElement("span", {}, "World");

const element = React.createElement("div", {
  className: "container",
  children: [helloEle, " ", worldEle],
});
```

`children` property is a special kind of property, you can have one element as argument or if you want multiple elements then you can provide with additional number of arguments.

The above code can also be written as..

```js
const rootElement = document.getElementById("root");

const helloEle = React.createElement("span", {}, "Hello");
//instead of putting empty object, you can also put null
const helloEle = React.createElement("span", null, "Hello");

const worldEle = React.createElement("span", {}, "World");

//or you can just create like this
const worldEle = React.createElement("span", { children: "world" });

const element = React.createElement(
  "div",
  {
    className: "container",
  },
  helloEle,
  " ",
  worldEle
);
console.log(element);

ReactDOM.render(element, rootElement);
```

That's all for now.

---

So now you saw how difficult it becomes to write the code when you use RAW APIs. In the next [article]({{<ref "/posts/18-understanding-jsx.md">}}) we will understand a simpler way to create elements using JSX (whose syntax looks similar to HTML) and understand how it works behind the scenes.

Until next time :wave:, Happy learning :tada: :computer:

