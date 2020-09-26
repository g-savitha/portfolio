---
title: "Intro to DOM Manipulation"
date: 2020-09-26T12:27:19+05:30
draft: false
tags: ["javascript", "DOM", "es6"]
categories: ["javascript"]
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

# Introduction

DOM is a _JS representation of a webpage_. (JS `window` object on to the webpage). In brief, its a branch of objects (Browser turns out webpage into bunch of objects.)that you can interact with, via JS.

![dom-image](https://miro.medium.com/max/1120/1*h5XbI4n8eIKnmaeWPRmKOQ.png)

- **Note** : _Content inside the tags_ is the _*property*_ of object

## Document Object

DOM is a representation of a document object made with **a bunch of objects** & they are **assembled into a tree**.

### Document (root of the tree)

_Document object is our entry point_ into the world of DOM. It contains representations of all the content on a page, plus tons of useful methods and properties.

- _To see underlying document object_:

```js
console.dir(document); //shows the methods and properties of the doc object
```

If you simply type document in the console. it prints it out the html structure(not very useful)

```js
document.all; //contains every single ele on the page -> every single ele is turned into an object.
//in turn those objects have tons of properties and methods
document.img; //contains all images on the page
```

## Methods for selecting DOM Objects

Lets work on this html file

```html
<body>
  <script src="app.js"></script>
  <h1 class="header">My Web page</h1>
  <p>Lorem ipsum dolor sit amet consectetur.</p>
  <p class="special">dfdjfndlkf</p>
  <p id="main">Lorem ipsum dolor sit amet consectetur.</p>
  <form action="">
    <input type="text" placeholder="text" />
    <input type="password" placeholder="password" />
    <input type="submit" />
  </form>
  <ul>
    <li class="special">First</li>
    <li>2nd</li>
    <li class="special">3rd</li>
  </ul>
  <img
    src="https://images.unsplash.com/photo-1573920111312-04f1b25c6b85?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
    alt="bear"
    id="bear-photo"
  />
  <section>
    <ul>
      <li>carrots</li>
      <li class="special">potatoes</li>
      <li>tomatoes</li>
    </ul>
  </section>
</body>
```

### `getElementById()`

It takes an ID and finds the matching element that contains the ID on it and it `returns that object`

Syntax:

```js
document.getElementByID();
```

> We are _only_ supposed to have _one ID per page_ or one of each ID. If have multiple IDs with same name, we get only the first one as matching output. If we dont have a matching id `null` is returned

- _**Every tag in html is an HTML element.**_

```js
`
<p>` proto :HTMLParagraphElement , `<img />` proto: HTMLImageElement</p>
```

### `getElementsByTagName()`

Select an element by its type. like all `<h1>s & all <p>s` on the page

Syntax:

```js
document.getElementsByTagName(); // RT: HTMLCollection
//example:
document.getElementsByTagName("input"); // RT: HTMLCollection(3) [input,input,input]
//and each input is :HTMLInputElement
```

> **Note** : _RT looks like an array, but its not_. Elements returned are stored in a list. Even though we have one element, it is still retuned as a list. We can access elements of it by indices and we can iterate over it like arrays. but _we cant apply array methods over it_

```js
const inputs = document.getElementsByTagName("input"); //  RT: HTMLCollection(3) [input,input,input]
inputs[0]; // 1st input html element
//<input type="text" name="" id="" placeholder="text" />

inputs.length; //3
inputs[3]; //undefined coz we only have 3
inputs.pop(); //error
inputs.push(); //error
inputs.includes(); //error
for (let input of inputs) console.log(input); //html elements (but remember they are objects)
```

We only have access to objects methods...

To turn it to an array use `spread[...]` operator...

```js
const arr = [...inputs]; //arr has input elements as arr elements
```

```js
//to get values of inputs by iterating
for (let ip of inputs) console.log(ip.value); //the values which u entered in the input
```

### `getElementsByClassName()`

Gets elements by class name. RT : list

```js
document.getElementsByClassName("header"); //HTMLCOllection [h1.header]
document.getElementsByClassName("special"); //HTMLCOllection [li.special,li.special,li.special]
```

Lets say we want to _get only classes of special_ which are there in `ul`

```js
document.getElementsByTagName("ul "); // this gives an entire list
//take only first one
const ul = document.getElementsByTagName("ul")[0];
//ul is an object now. it has its own classNames and tagNames methods now
ul.getElementsByClassName("special"); // now we get only elements under ul with special as class name
ul.getElementsByTagName("li"); // we get 3 lis coz we have 3 lis inside [li.special,li,li.special]
```

> **important** : `getElementById()` doesnt work this way _coz ids are supposed to be unique_ across the entire document. We dont have access to ul.getElementById()

### `querySelector()` & `querySelectorAll()`

- A new all in one method to select _a single element_
- **Pass in a CSS selector**

```js
//same like getElementsByTagName but this returns only first element, there comes querySelectorAll() to get all elements
document.querySelector("h1"); //finds first h1 element
document.querySelector("#red"); //finds first element with id as red
document.querySelector(".big"); //finds first element with class as big
document.querySelector(".special"); //paragraph elemtnt
//lets say u wanted first element with special as class name
document.querySelector("li.special");
document.querySelector("section li.special"); //potatoes
document.querySelector("section ul li.special"); //potatoes
//selecting base on attributes
document.querySelector('input[type="password"]'); // password input
```

#### `querySelectorAll()`

same idea, but _returns a a collection_ of matching elements

```js
document.querySelectorAll(".special"); //RT : NodeList [p.special], [li.special], [li.special], [li.special]
document.querySelectorAll("input"); //RT: NodeList [input,input,input]
```

> **important** : Note that We are getting _return type as NodeList_ we got HTMLCollection for getElementsByTagName() & getElementsByClassName(). NodeList is another array like obj

- **Note**: _query selector is bit less performant_ _compared to getElement methods_
