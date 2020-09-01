---
title: "React Forms"
date: 2020-08-30T17:51:50+05:30
draft: false
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

## Forms

- HTML form elements work differently than other DOM elements in React
  - Form elements naturally keep some internal state.
  - For example, this form in plain HTML accepts a single name:

```js
<form>
  <label for="fullname">Full Name:</label>
  <input name="fullname" />
  <button>Add!</button>
</form>
```

### Thinking About State

```js
<form>
  <label for="fullname">Full Name:</label>
  <input name="fullname" />
  <button>Add!</button>
</form>
```

It’s convenient to have a JS function that _handles the submission_ of the form and _has access to the data the user entered_.

The technique to get this is _**controlled components**_.

## Controlled Components

- In HTML, form elements such as `<input>`,` <textarea>`, and `<select>` typically _maintain their own state_ and _update it_ based _on user input_.
- _In React_, _mutable state_ is kept in the _*state*_ _of components_, and only **updated with setState()**.

How do we use React to control form input state?

### One Source of Truth

- We make the _**React state be the “single source of truth”**_
- _React controls_:
  - What is _shown_ _**(the value of the component)**_
  - What happens the _user types_ _**(this gets kept in state)**_

Input elements controlled in this way are called _“controlled components”._

### Example Form Component

```js
class NameForm extends Component {
  constructor(props) {
    super(props);
    // default fullName is an empty string
    this.state = { fullName: "" };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(evt) {
    // do something with form data
  }
  handleChange(evt) {
    // runs on every keystroke event
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label htmlFor="fullname">Full Name:</label>
        <input
          name="fullname"
          value={this.state.fullName}
          onChange={this.handleChange}
        />
        <button>Add!</button>
      </form>
    );
  }
}
```

## How the Controlled Form Works

- Since _*value*_ attribute is set on element, _**displayed value will always be `this.state.fullName`**_ — _making the React state the source of truth._
- Since _**`handleChange` runs on every keystroke to update the React state**_, the **displayed value will update as the user types.**
- With a controlled component, _every state mutation will have an associated handler function._ This makes it easy to modify or validate user input.

### handleChange Method

Here is the method that updates state based on input.

```js {hl_lines=[7]}
class NameForm extends Component {
  // ...

  handleChange(evt) {
    // runs on every keystroke
    this.setState({
      fullName: evt.target.value,
    });
  }

  // ...
}
```

## Handling Multiple Inputs

- ES2015 introduced a few object enhancements…
- This includes the ability to **create objects with dynamic keys** _based on JavaScript expressions_.
- The feature is called _computed property names_.

##### Computed Property Names

_ES5_

```js
var catData = {};
var microchip = 1432345421;
catData[microchip] = "Blue Steele";
```

_ES2015_

```js
let microchip = 1432345421;
let catData = {
  // propery computed inside the object literal
  [microchip]: "Blue Steele",
};
```

### Application To React Form Components

Instead of making a separate onChange handler for every single input, we can _**make one generic function for multiple inputs!**_

#### Handling Multiple Inputs

To handle multiple controlled inputs, add the _HTML_ _*name*_ _attribute to each JSX input element_ and _let handler function decide_ the _appropriate key in state to update_ based on _*event.target.name.*_

```js
class YourComponent extends Component {
  // ...

  handleChange(evt) {
    this.setState({
      [evt.target.name]: evt.target.value,
    });
  }

  // ...
}
```

Using this method, the **keys in state have to match the input `name` attributes exactly**.

_The state:_

```js
this.state = { firstName: "", lastName: "" };
```

_NameForm.js;_

```js {hl_lines=[3,14,22]}
class NameForm extends Component {
  handleChange(evt) {
    this.setState({ [evt.target.name]: evt.target.value });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label htmlFor="firstName">First:</label>
        <input
          id="firstName"
          name="firstName"
          value={this.state.firstName}
          onChange={this.handleChange}
        />

        <label htmlFor="lastName">Last:</label>
        <input
          id="lastName"
          name="lastName"
          value={this.state.lastName}
          onChange={this.handleChange}
        />
        <button>Add a new person!</button>
      </form>
    );
  }
} // end
```

## Design pattern: Passing Data Up to a Parent Component

In React we generally have downward data flow. _“Smart” parent_ components with _simpler child_ components.

- But it is common for form components to manage their own state…
- But the _smarter parent component usually has a_ _**doSomethingOnSubmit method**_ _to update its state_ **after the form submission**…
- So what happens is the _**parent will pass its doSomethingOnSubmit**_ method down _*as a prop*_ to the child.
- The _**child component**_ _*will call*_ this method which will then _**update the parent’s state**_.
- The _child_ is still appropriately “dumber”, all it knows is to _pass its data into a function it was given_.

### Shopping List Example

- _Parent Component:_ ShoppingList (manages a list of shopping items)
- _Child Component:_ NewListItemForm (a form to add a new shopping item to the list)

_ShoppingList.js_

```js {hl_lines=[13]}
class ShoppingList extends Component {
  /* Add new item object to cart. */
  addItem(item) {
    let newItem = { ...item, id: uuid() };
    this.setState((state) => ({
      items: [...state.items, newItem],
    }));
  }

  render() {
    return (
      <div className="ShoppingList">
        <NewListItemForm addItem={this.addItem} />
        {this.renderItems()}
      </div>
    );
  }
}
```

_NewListItemForm.js_

```js{hl_lines=[6]}
class NewListItemForm extends Component {
  // Send {name, quantity} to parent - & clear form.

  handleSubmit(evt) {
    evt.preventDefault();
    this.props.addItem(this.state); /*focus here*/
    this.setState({ name: "", qty: 0 });
  }
}
```

## Keys and UUIDs

### Using UUID for Unique Keys

- We’ve seen that _using an iteration index as a key prop_ is a **bad idea**
- No natural unique key? Use a library to create a _uuid_
- Universally unique identifier (UUID) is a way to _uniquely identify info_
- Install it using `npm install uuid`

#### Using the UUID Module

_ShoppingList.js_

```js
import uuid from "uuid/v4";
```

_ShoppingList.js_

```js {hl_lines=[6,7,13,22]}
class ShoppingList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      items: [
        { name: "Milk", qty: "2 gallons", id: uuid() },
        { name: "Bread", qty: "2 loaves", id: uuid() },
      ],
    };
    this.addItem = this.addItem.bind(this);
  }
  addItem(item) {
    let newItem = { ...item, id: uuid() };
    this.setState((st) => ({
      items: [...st.items, newItem],
    }));
  }
  renderItems() {
    return (
      <ul>
        {this.state.items.map((item) => (
          <li key={item.id}>
            {item.name}:{item.qty}
          </li>
        ))}
      </ul>
    );
  }
}
```

### Validation

- Useful for UI
- **Not an alternative to server side validation**
- [Formik](https://formik.org/docs/overview)
