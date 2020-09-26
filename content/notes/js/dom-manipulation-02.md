---
title: "Manipulating the DOM"
date: 2020-09-26T13:03:28+05:30
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

# Properties and Methods of DOM

Lets look at some of the important properties and methods which we use regularly

## `innerText` & `textContent`

### `innerText`

- innerText gives the _data in between the tags_

```js
const h1 = document.querySelector("h1");
h1.innerText; //My Web page
const ul = document.querySelector("ul");
ul.innerText; //"First2nd3rd" All the nested content is concatenated and output came as one object
document.body.innerText; // we get all the text on the webpage, it doesnt matter it is nested or not
//change the value
h1.innerText = "Hello world"; // changes value to HW on html page
ul.innerText = "asjgsakdj"; // all of the lis are gone and replaced with this text
```

### `textContent`

- On surface looks same like innerText

```js
const h1 = document.querySelector("h1");
h1.textContent; //My Web page
```

lets change our html to without any proper formatting and add a script tag

```html
<p id="main">
  Lorem ipsum d sadkj saldkm olor sit amet consectetur, adipisicing elit.
  <strong style="display : none">Minus omnis similikjdsof que itaque!</strong>
  Quas, voluptatum quasi sapiente consectetur cupiditate vel omnis, dolore odit
  sequi, doloribus deleniti est ipsum quo numquam eius.
  <script>
    console.log("Hello");
  </script>
</p>
```

```js
const p = document.querySelector("#main");
p.innerText; // returns all the text inside main with formatting and no data from script and also it doesnt display the hidden text which is in strong tag
p.textContent; //returns data without formatting and also data inside script tag and hidden data inside strong tag
```

## `innerHTML`

innerHTML not only _retrieves text inside the tags_ but also _all the elements inside a particular tag_

```js
const form = document.querySelector("form");
form.innerHTML;
/**
 * "
      <input type="text" name="" id="" placeholder="text">
      <input type="password" name="" id="" placeholder="password">
      <input type="submit">
    "
 */
```

- We can **use innerHTML to change content inside tags**.

```js
form.innerHTML = "sadjgd"; // entire form gets replaced by this text
// we can also add html data using innerHTML
form.innerHTML = " <b>i am a bold tag</b>"; // bolds out the data
```

- `innerText`, `textContent` and `innerHTML` all _*return string*_ object

- **Note**: `innerHTML` actually _parses the text we pass in_ and checks whether we have html elements or text, based on that it manipulates the data and reflects on DOM.

### `innerText` vs `innerHTML`

```js
const h1 = document.querySelector("h1");
h1.innerText(); // My web page
h1.innerHTML(); //My web page
h1.innerHTML += "is cool"; //My web page is cool
h1.innerHTML += "<b> !!! </b>"; //My web page is cool !!!
h1.innerText += "<b> !!! </b>"; //My web page is cool !!! <b> !!! </b>
```

- `innerText` _doesnt parse the tags_, it doesnt ignore them and doesnt understand them as actual elements

---

## Important DOM properties

- **Value** : To get or set a value of an attribute.
- **checked** : When input type is checkbox, we use checked property to get the value of checkbox
- **placehloder** : We can change the text of a placeholder attribute.
- **href** : to get the link from the anchor tag
- **src** : to get the src of an image

```js
const inputs = document.querySelectorAll("input");
inputs[0].value; // value of an attribute, lets say attribute was text box, we get value inside text box
//lets assume inputs[1] is checkbox
inputs[1].value; // always gives output as one, whether it is checked or not
inputs[1].checked; //true or false
inputs[2].placeholder; //password
inputs[2].placeholder = "Enter your password";

const a = document.querySelector("a");
a.href; // http:// www.google.com

const img = document.querySelector("img");
img.src;
```

---

## Getting & Setting attributes

We have `getAttribute`() & `setAttribute`() to access and set other properties of DOM

```html
<input type="range" min="50" max="100" step="10" />
```

```js
const range = document.querySelector('input[type="range"]');
range.getAttribute("max"); //100
range.getAttribute("min"); //50
range.getAttribute("type"); //range
range.getAttribute("lol"); //null
range.setAttribute("min", "-100");
range.setAttribute("type", "radio");
```

---

## Finding parent /children/ siblings

Selecting an element based on current element

```html
<ul>
  <li id="special">First</li>
  <li>2nd</li>
  <li id="special">3rd</li>
</ul>
```

```js
const firstLI = document.querySelector("li");
firstLI.parentElement; //entire ul currently this li is in.
/**
 *    <ul>
      <li id="special">First</li>
      <li>2nd</li>
      <li id="special">3rd</li>
    </ul>
 */
firstLI.parentElement.parentElement; //entire body
firstLI.parentElement.parentElement.parentElement; //entire html
firstLI.parentElement.parentElement.parentElement.parentElement; //null

const ul = document.querySelector("ul");
ul.children; //HTMLCOllection(3) [li.special, li, li.special]
ul.children[0].innerText; //First

firstLI.nextElementSibling; //<li>2nd</li>
const thirdLI = firstLI.nextElementSibling.nextElementSibling;
thirdLI.previousElementSibling; //<li>2nd</li>
```

---

## Changing multiple elements

We know how to select multiple elements, using querySelectorAll(). To manipulate them, _iterate over the selected elements and change the property_

```javascript
const allLis = document.querySelectorAll("li");

for (let i = 0; i < allLis.length; i++) {
  allLis[i].innerText = "We are champions";
} // value of all lis is changed

for (const li of allLis) {
  li.innerHTML = "We are <b> Champions </b>";
}
```

---

## Altering Styles

- Changing CSS properties using DOM
- Every html element has a style property

- > **Important:** If we are using `style` property to read exisiting styles, it wont work unless styles are defined inline. which is not a good idea. But you can change the color using DOM

  ```js
  const h1 = document.querySelector("h1");
  h1.style.color; // we get empty string as our style is not inlined.
  // but you can change the style of it from DOM
  h1.style.color = "teal"; // the color of h1 is changed
  ```

- If we look at what it does, it adds inline styling to our element. **Inline styling has more priority than external stylesheet** when manipulating elements
- **Note:** All the styles in js are camel case

  ```js
  p.style.background - color; //throws an error, this is how we declare it in css (kabab case )
  p.style.backgroundColor = "black"; //allows us to access and change the bg color
  ```

Assigning each li a color..

```js
const allLis = document.querySelectorAll("li");
const colors = ["red", "yellow", "blue", "green", "css", "pink"];
allLis.forEach((li, i) => {
  const color = colors[i];
  li.style.color = color;
});
```

## `getComputedStyle()`

To get the styles we applied in a stylesheet (get the computed values of an element)

```js
const li = document.querySelector("li");
const styles = getComputedStyle(li); //RT : CSSSTyleDeclaration. a massive object contains all CSS properties in K,V pairs. values are set to default unless we have mentioned them explicitly in stylesheet .
```

---

## Manipulating classes

Apply _style to multiple elements using css classes_

```html
<ul id="todos">
  <li class="todo">Eat breakfast<button>x</button></li>
  <li class="todo">Feed the pet<button>x</button></li>
  <li class="todo">Drink water <button>x</button></li>
</ul>
```

```css
.todo {
  font-size: 30px;
  color: olive;
}

.done {
  color: gray;
  text-decoration: line-through;
  opacity: 50%;
}
```

```js
const todos = document.querySelector("#todos .todo");
todos.getAttribute("class");
todos.setAttribute("class", "done");
```

- This is **not the correct way** to do as _it modifies the inline styling of first element_, we cant get back to our prev state unless we manually set it again. We lost our todo class, we completely overridden it. This is one **down side of setAttribute().**

- _**This brings us to new property `classList`**_

### `classList`

- `classList` is an object representation. It _contains classes of an element we choose_ RT : DOMTokenList

```js
//removes existing style on classes
todos.classList.remove("done"); // using setAttribute we werent able to remove, now we can remove using classList
//adds style on to classes
todos.classList.add("done"); // add class
//adds if we dont have and removes if we have it. toggles between two
todos.classList.toggle("done");
```

---

## Creating Elements

- `document.createElement()` -> returns an object
- add text into the object (optional)
- append the object to the DOM. This **object is going to be appended as the last child of a parent**

```js
//create a h2 element and append it to dom

//create
const newh2 = document.createElement("h2"); // creates an object on DOM
newh2; // <h2></h2>
//add text
newh2.innerText = "I love pineapples";
newh2; //<h2>I love pineapples</h2>
//lets add style too
newh2.classList.add(".special");
//append it to DOM
//select a parent to attach
const section = document.querySelector("section");
section.appendChild(newh2); // this child is going to get appended at the end of the section  //<h2 class="special">I love pineapples</h2>

//On webpage
/* <section>
  <ul>
    <li>carrots</li>
    <li class="special">potatoes</li>
    <li>tomatoes</li>
  </ul>
  <h2 class="special">I love pineapples</h2>
</section>; */
```

```js
//Example 2:
const newLink = document.createElement("a");
newLink.href = "https://www.youtube.com/watch?v=8Ljgy3pLmmo";
newLink.innerText = "BTS - Dream Glow lyrics";
const firstP = document.querySelector("p");
firstP.appendChild(newLink);
```

### Append, prepend and insertBefore

#### `insertBefore`

insert an element before a particular element.

```js
parentEl.insertBefore(newEl, elBeforeWhichUwantToInsert);
//example.
//insert an li before the first li in an ul
const parentUl = document.querySelector("ul");
const newLi = document.createElement("li");
newLi.innerText = "I am a new list element";
const firstLI = document.querySelector("li.todo");
parentUl.insertBefore(newLi, firstLI);
// insert before last Li
const lastLi = const firstLI = document.querySelectorAll("li.todo")[2];
parentUl.insertBefore(newLi, lastLi);
```

#### `insertAdjacentElement`

```js
const i = document.createElement("i");
i.innerText = "I am italics";
const firstP = document.querySelector("p");
firstP.insertAdjacentElement("beforebegin", i);
/**
 * i am italics
 * I am P tag
 */

firstP.insertAdjacentElement("afterbegin", i);
/**
 * i am italicsI am P tag
 */

firstP.insertAdjacentElement("afterend", i);
/**
 * I am P tag
 * i am italics
 */
firstP.insertAdjacentElement("beforeend", i);

/**
 * I am P tagi am italics
 */
```

- For more info ref : [MDN doc]('https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentElement')

#### `append()` & `prepend()`

- _~~IE support~~_
- To insert multiple children at once

```js
firstP.append(i, newLi);
/**
 * I am P tagi am italics
 * i am a new li
 */
firstP.prepend(i, newLi);
/**
 * i am italics
 * i am a new li
 * I am P tag
 */
```

#### `removeChild()` and `remove`

Similar to appendChild() and append()

```js
const ul = document.querySelector("secion ul");
const removeEl = ul.querySelector(".special");
ul.removeChild(removeEl);

//for remove u dont need a parent el to remove
const h1 = document.querySelector("h1");
h1.remove();
```
