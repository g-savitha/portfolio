---
title: "Event Handling in JS"
url : "/posts/event-handling-js"
date: 2020-09-26T15:18:15+05:30
draft: false
description: "Types of events and how to use them"
tags: ["javascript", "DOM", "es6", "events"]
categories: ["javascript"]
sources: ["https://www.udemy.com/course/modern-javascript/"]
hideToc: false
enableToc: true
enableTocContent: true
---

## Intro to DOM Events

- **Events** - Responding to user inputs and actions
- **Types of events**:(some of the many)

  - clicks, drags, drops, hovers,scrolls, form submissions, key press, focus/blur
  - mousewheel, double click, copying, pasting, audio start, screen resize, printing etc.

- <mark>Note: </mark>All events follow a similar pattern

- _Pattern_:

| The thing | Event type  | Code to run            |
| --------- | ----------- | ---------------------- |
| button    | click       | change the color       |
| input     | hits return | get the search results |
| image     | mouseover   | display img caption    |

- for more info visit [MDN Event reference](https://developer.mozilla.org/en-US/docs/Web/Events)

## 2 ways not to add events

Lets explore 2 different syntaxes which we should not use.

- all events start with `on` word.
- `onEventName = doSomething`

1. First type actually involves _inline html scripting_, which is _not recommended_. It just clutters the markup.

```html
<button onmouseover="alert('You hovered over me!')">click me!</button>
<form>
  <input
    type="range"
    min="50"
    max="100"
    onclick="console.log('clicked the input')"
  />
</form>
```

2. We first select an element in Javascript and then do inline html scripting

{{< codes html js >}}
{{< code >}}

```html
<button id="clicker">CLicker!</button>;
```

{{< /code >}}
{{< code >}}

```js
const clicker = document.querySelector("#clicker");

clicker.onclick = function () {
  console.log("You clicked me");
};
clicker.ondblclick = function () {
  console.log("Double click");
};

clicker.onclick = function () {
  alert("hello");
};
//now we lost the previous data.
//Onclick is considered just like any other property
```

{{< /code >}}
{{< /codes>}}

- _**if you want to have multiple events to a single element use `addEventListener`**_

---

## addEventListener

Specify the _event type_ and a _callback_ to run

```js
const button = document.querySelector("h1");
button.addEventListener("click", () => {
  alert("You clicked");
});

button.addEventListener("click", () => {
  console.log("Output in console");
}); // we get both things as output for one event. one in console and other as alert
button.addEventListener("mouseover", function () {
  button.innerText = "Dont hover on me";
}); // we are permanently changing the innerText, the text doesnt go back to its prev state
// to get the text to its prev state. there is another event called `mouseout` use that.
button.addEventListener("mouseout", function () {
  button.innerText = "CLick me!";
}); // now text changes back to prev state
```

_*addEventListener()*_ is great, because it is just one method and it **will attach to any type of event listener you want**(click, double click, mouseover etc...)

- **Note:** if you see `button.onclick` property, it is _not attached to anything_. It _*returns null*_ as output

> **important:** _Dont use arrow functions as call backs_, because sometimes we want to access `this` inside the function and arrow functions doesnt do well with `this`

---

## Events on Multiple Elements

This is the important topic of event handling. We know how to add multiple events to a single element. how about _multiple elements having a single event?_ How do we take every button on page and add a click event?

1. select a group of items u want to add events to
2. loop over them and add eventlistener to each

<mark>Note:</mark> `this` _refers to individual object_ onto which we are listening over when adding multiple events

{{< codes html js >}}

{{< code >}}

```html
<body>
  <h1>Pick a color</h1>
  <section class="boxes" id="container"></section>
  <script src="app.js"></script>
</body>
```

{{< /code >}}

{{< code >}}

````js
    const colors = [
    "red",
    "yellow",
    "orange",
    "green",
    "blue",
    "purple",
    "indigo",
    "violet",
    ];
    const boxes = document.querySelector("#container");
    const heading = document.querySelector("h1");
    const pickAColor = function () {
    console.log(this);
    heading.style.color = this.style.backgroundColor;
    };

    for (let color of colors) {
    const box = document.createElement("div");
    box.style.backgroundColor = color;
    box.classList.add("box");
    boxes.appendChild(box);
    box.addEventListener("click", pickAColor);
    }
    ```

{{< /code >}}

{{< /codes >}}

<mark>Important</mark> : So when the function `pickAColor` is called, ie., when we click on a box, _we are never executing `pickAColor` ourselves_, its being called for us. **An Event object is passed to it**. _*Event object*_ is _automatically called every time we are not capturing it_

---

## Event Object

Contains _information_ _about_ a particular _event_

```javascript
const pickAColor = function (evt) {
  console.log(evt); //MouseEvent Object is returned
};
````

```javascript
document.body.addEventListener("keypress", function (e) {
  console.log(e);
}); //RT: KeyboardEvent
```

- **KeyboardEvent** - Conatins info about the key we pressed and othe useful info about keys

---

## Key Events

There are atleast 3 types of keyevents.

- `keyup`
- `keydown`
- `keypress`

### keydown

A Key has been pressed.

When u hold or press any key it is considered as keydown event.

- **Note:** keydown _runs for any potential keys_ whether they actually change the input or not

- _All key presses are considered as keydown events_.
  - eg: alt/option, cmd, ctrl, caps, all alphabets, space, shift, tab etc.
    {{< codes html js>}}
    {{< code >}}

```html
<input type="text" id="username" placeholder="username" type="text" />
```

{{< /code >}}
{{< code >}}

```js
const username = document.querySelector("#username");
//we would want event object, because it contain info about which key is pressed
username.addEventListener("keydown", function (e) {
  console.log("KEY DOWN");
});
```

{{< /code >}}
{{< /codes >}}

### keyup

A key has been released.

For all keys, first a keydown event is fired followed by a keyup.

- **Note:** keyup only occurs when u release a key

```js
const username = document.querySelector("#username");

username.addEventListener("keydown", function (e) {
  console.log("KEY DOWN");
});
username.addEventListener("keyup", function (e) {
  console.log("KEY UP");
});
```

### keypress

_A key that normally produces a character value_ has been pressed. If the key is not a modifier key, the keypress event is sent

> **Caution:** This event is obsolete and differs from browser to browser, better not to use it much

- When you type a key K in the input. The _order of key sequenes_ would be **Keydown, keypress, keyup**

- When you press something like shift we only get keydown and keyup

- Capital letter -> Shift + Letter -> KeyDown(2) , keypress, keyup(2) -> keydown and keyup for both shift and letter

- **Note:** _keypress only works when we have changing input_. like alphabets, doesnt work with arrows, caps, shift, tab, cmd etc. But when you hit _*return*_, it is _considered as a keypress_

- For more on events [WEBApi - MDN](https://developer.mozilla.org/en-US/docs/Web/Events)

### Example

Lets make a todo list

{{< codes html js>}}
{{< code >}}

```html
<h1>Shopping list</h1>
<input type="text" name="" id="addItem" placeholder="add items in your list" />
<ul id="items"></ul>
```

{{< /code >}}
{{< code >}}

```js
const input = document.querySelector("#addItem");
const ulItems = document.querySelector("#items");

input.addEventListener("keypress", function (e) {
  // doesnt allow spaces in the beginning
  if (e.which === 32 && !this.value.length) {
    e.preventDefault();
  }
  if (e.key === "Enter") {
    if (!this.value) return;
    const item = document.createElement("li");
    item.innerText = this.value;
    console.log(item);
    this.value = "";
    ulItems.appendChild(item);
  }
});
```

{{< /code >}}
{{< /codes >}}

---

## FormEvents & preventDefault

When we press submit, we get navigated to other page or the page gets refreshed if we dont specify any url in action.Lets say we want to stop the form from getting refreshed when we submit. **Capture the submit event and stop it from its default behaviour.**

Lets take this html snippet

```html
<form id="signup">
  <input type="text" placeholder="credit card" id="cc" />
  <label>
    I agree to T&C
    <input type="checkbox" id="terms" />
  </label>
  <select id="veggies">
    <option value="brinjal">Brinjal</option>
    <option value="tomato">Tomato</option>
    <option value="onion">Onion</option>
  </select>
  <button type="submit">Submit</button>
</form>
```

### preventDefault

**Default behaviour is prevented**

```js
const form = document.querySelector("#signup");
form.addEventListener("submit", function (e) {
  e.preventDefault(); //when this is executed default behaviour is prevented
});
```

Now this leaves us free to now extract data from the submit event. If we wanted all data at once and send it to an api using AJAX or using a client side request, we can do that. _We have flexibility to do something with the data and we can still capture the submit event_. What's nice about doing this way as opposed to capturing each input as it changes every single time is we dont need to attach a bunch of event listeners for every input, by adding a submit event listener there's just one event we are waiting for, we tell it not to behave, normally it behaves and then we can extract our data in that function.

```js
const creditCardInput = document.querySelector("#cc");
const termszcheckBox = document.querySelector("#terms");
const veggiesSelect = document.querySelector("#veggies");
const form = document.querySelector("#signup");
form.addEventListener("submit", function (e) {
  console.log("cc", creditCardInput.value); //cc 12343434535
  console.log("terms", termszcheckBox.checked); // terms true
  // we get the value from value attribute, eg: we get brinjal as output instead of Brinjal
  console.log("veggiesSelect", veggiesSelect.value); //veggiesSelect tomato
  e.preventDefault();
});
```

We are accessing data from the form. After accessing these values , we can generally send form data to DB or append something to page using form data. We can put preventDefault() at the top of the function, it still works the same

---

## input and change Events

### input

This **event is triggered whenever an input changes** .We can actually listen to all 3 above inputs(textbox, checkbox and select) at once using a single event type.

Our goal is to create a datastructure which _automatically updates whenever a user enters value in input_, instead of waitiing for user to submit(like from the above section)

```js
creditCardInput.addEventListener("input", (e) => {
  console.log("CC Changed", e); // the event is triggered whenever we type something in the input box
});
```

Storing value to an object as soon as user changes the input. These events trigger before user clicks submit.

```js
const formData = {};
creditCardInput.addEventListener("input", (e) => {
  console.log("CC Changed", e);
  //formData['cc'] = creditCardInput.value; -> hard coding. instead use event object properties to get value
  formData["cc"] = e.target.value;
});
veggiesSelect.addEventListener("input", (e) => {
  console.log("veggie change", e);
  formData["veggie"] = e.target.value;
});
termszcheckBox.addEventListener("input", (e) => {
  console.log("terms changed", e);
  formData["terms"] = e.target.checked;
});
```

Refactor the above code.
add a `name` attribute to each html input

{{< codes html js>}}
{{< code >}}

```html
<input type="text" placeholder="credit card" id="cc" name="creditcard" />
<label>
  I agree to T&C
  <input type="checkbox" id="terms" name="agreeToterms" />
</label>
<select id="veggies" name="selectedVeggie">
  <option value="brinjal">Brinjal</option>
  <option value="tomato">Tomato</option>
  <option value="onion">Onion</option>
</select>
```

{{< /code >}}
{{< code >}}

```js
for (let input of [creditCardInput, termszcheckBox, veggiesSelect]) {
  input.addEventListener("input", (e) => {
    if (e.target.type === "checkbox")
      formData[e.target.name] = e.target.checked;
    else formData[e.target.name] = e.target.value;
  });
}
// more sophisticated code
for (let input of [creditCardInput, termszcheckBox, veggiesSelect]) {
  input.addEventListener("input", ({ target }) => {
    // destructure event object since we only use target
    // destructure more coz we use only these 4 properties in target
    const [name, type, value, checked] = target;
    formData[name] = type === "checkbox" ? checked : value;
  });
}
```

{{< /code >}}
{{< /codes >}}

- _We can add multiple events under single event listener_ as long as we have `name` attribute.

### change

If we change the above event type to `change` it will still behave the same except for the textbox. _Textbox input change wont trigger until we lose focus over it_ or press return key after entering complete data or focus it, unlike input where it triggers event for every single key typed(every single letter changed in text box).

```js
for (let input of [creditCardInput, termszcheckBox, veggiesSelect]) {
  input.addEventListener("change", ({ target }) => {
    // destructure event object since we only use target
    // destructure more coz we use only these 4 properties in target
    const [name, type, value, checked] = target;
    formData[name] = type === "checkbox" ? checked : value;
  });
}
```

> This type of pattern (using name attribute) is pretty common especially if we get to something like **react** and some of the other frameworks or libraries out there. We use **name of an input as a key to store the value from that input** under, to create a nice object that contains all of our form data at once.

Hope you learnt something, until next time :wave:, happy learning :tada: :computer:

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.
