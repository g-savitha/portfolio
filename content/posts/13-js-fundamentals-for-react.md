---
title: "JS fundamentals for  React"
url: "/posts/js-fundamentals-for-react"
date: 2021-05-10T13:38:45+05:30
draft: false
description: "These are the JS basics you should be familiar with before getting started with react"
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

In this article lets look at the basics of JS one should know before getting started with React. Feel free to skip the topics you already know.

## Logical operators

These operators are also known as `short-circuit evaluation` operators

### Logical && (AND)

- Let's say you have two [expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators) `x` and `y`
  ```js
  x && y;
  ```
  - This operation will be executed if both `x and y` are [truthy](https://developer.mozilla.org/en-US/docs/Glossary/truthy).
  - If either of the expressions is [falsy](https://developer.mozilla.org/en-US/docs/Glossary/falsy) operation wont be executed.
  - This operator is known as `short-circuit evaluation` operator because, if the first expression or operation `x` is falsy, operation wont be continued further, and it returns false

### Logical || (OR)

- Let's say you have two [expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators) `x` and `y`
  ```js
  x || y;
  ```
  - This operation is executed if either of the expressions is [truthy]((https://developer.mozilla.org/en-US/docs/Glossary/truthy)
  - Short circuiting happens here as well:
    - If the first expression evaluates to true, operation wont be continued further and the output is returned as true.

## Ternary Operator

- This is a shorthand expression of `if-else`.

  Without ternary:

  ```js
  if (condition) {
    doSomething();
  } else {
    doSomethingElse();
  }
  ```

  Using ternary:

  ```js
  condition ? doSomething() : doSomethingElse();
  ```

- If `condition` is true, evaluate `doSomething()` else evaluate `doSomethingElse()`

## Template Literals

- Template literals are like the super power to Strings. You can use multi line strings and interpolate string features in them.
- This feature is newly introduced in ES6.
- Lets look at few examples

  ```js
  const name = "Savitha";
  //without template literals
  console.log("Hello, my name is " + name);
  //with template literals
  console.log(`Hello, my name is ${name}`);
  ```

- Not only that, you can also interpolate inline calculations and function calls with in your expression easily.

  ```js
  const name = "Savitha";
  const getRandomIndex = (max) => Math.floor(Math.random() * Math.floor(max));
  const numbers = [1, 3, 5, 7, 9];
  const getNum = (index) => numbers[index];

  //without template Literals
  console.log(
    "Hello, my name is " +
      name +
      "\n" +
      "and my Id is" +
      getNum(getRandomIndex(numbers.length))
  );
  //using template literals
  console.log(`Hello, my name is ${name} 
  and my id is ${getNum(getRandomIndex(numbers.length))}`);
  ```

- Notice that in the last line after `${name}` a new line is added ie., it uses multiline feature
- [MDN: Template Literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals)

## Shorthand property names

- This feature is very common and you see this alot.

  ```js
  const name = "Savitha";
  const id = 85;
  const place = "India";

  //Without shorthand property names
  const userDetails = {
    name: name,
    id: id,
    location: place,
  };

  //using shorthand property

  const userDetails = {
    name,
    id,
    place,
  };
  ```

- [MDN: Object Initializer New Notations](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#new_notations_in_ecmascript_2015)

## Destructuring

- Destructuring is one of my favourite features of ES6 Javascript. I love how declarative it is, I always use Arrays and Objects destructuring wherever it is necessary

### Object Destructuring

- The concept is very simple, with the use of below syntax, we can extract properties of object into variables.

  ```js
  const food = {
  fruit: ["apple","banana","pineapple","orange", "watermelon"],
  vegetable: ["potato","brinjal","tomato", "beans"],
  };
  //without object destructuring;
  const fruit = food.fruit,
  const vegetable = food.vegetable;
  //with object destructuring
  const { fruit, vegetable } = food;
  console.log(fruit);
  console.log(vegetable);
  ```

- **Note:** that object properties and destructured variables should have same name

- In the context of React, object destructuring is frequently used with function parameters.

  ```js
  const info = { name: "Savitha", id: "React" };
  function printInfo({ name, id }) {
    console.log(name, id);
  }
  printInfo(info);
  const printName = ({ name }) => console.log(name);
  printName(info);
  ```

- In React we use this pattern with props, which are the input for React components.

  ```js
  function MyReactComponent({ name, age }) {
    // ...
  }
  ```

### Array Destructuring

- With the use of below syntax we get the array elements into variables

  ```js
  const name = ["Savitha", "G"];

  //without destructuring

  const firstName = name[0];
  const lastName = name[1];

  //with destructuring
  const [firstName, lastName] = name;
  ```

- **Note:** the variables are assigned from left tp right of the array, therefore order is maintained.

  ```js
  const [fruit, veggie] = [
    "strawberry",
    "broccoli",
    "pizza",
    "taco",
    "sandwich",
    "burger",
  ];
  console.log(fruit); // strawberry
  console.log(veggie); // broccoli
  ```

- You can also skip few values

  ```js
  const [fruit, , pizza, , , burger] = [
    "strawberry",
    "broccoli",
    "pizza",
    "taco",
    "sandwich",
    "burger",
  ];
  console.log(fruit); // strawberry
  console.log(pizza); // pizza
  console.log(burger); // burger
  ```

- This concept is frequently used with React Hooks.

- [MDN: Destructuring assignment](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)

## Arrow functions

- A function declaration looks like this:

  ```js
  function sum(a, b) {
    return a + b;
  }
  ```

- A function expression looks like this:
  ```js
  const sum = function (a, b) {
    return a + b;
  };
  ```
- An arrow function constitutes as the alternative of the above two.

  ```js
  const sum = (a, b) => {
    return a + b;
  };
  ```

- If you have only one parameter you can skip `()` and if you have only return statement as the function body you can skip `{}` and `return` statement.

  ```js
  const user = (name) => console.log(`My name is ${name}`);
  ```

- If your function doesn't accept any parameters you need to put parantheses.

  ```js
  const user = () => console.log(`My name is Savitha`);
  ```

- Only with function declarations can you invoke functions before they have even been defined. This is because function declarations are hoisted, i.e., they are moved to the top of their scope before execution.
  ```js
  console.log(getNameDeclaration()); // "Savitha"
  console.log(getNameExp()); // ReferenceError: Cannot access 'getNameExp' before initialization
  console.log(getNameArrow()); // ReferenceError: Cannot access 'getNameArrow'before initialization
  function getNameDeclaration() {
    return "Savitha";
  }
  const getNameExp = () => {
    return "Savitha";
  };
  const getNameArrow = () => "Savitha";
  ```
- Another difference between function declarations/expressions and arrow function expressions is the `this` keyword. [Read this](https://www.freecodecamp.org/news/learn-es6-the-dope-way-part-ii-arrow-functions-and-the-this-keyword-381ac7a32881/) to know more about it

## Default Parameters

- This is another feature which I use alot.

- `Default parameters` as the name speaks, whenever we want a function to take default value we use this.

  ```js
  const add = (x = 5, y = 4) => a + b;

  add(3, 3); //6
  add(3); // x = 3, y = default value (4), 3 + 4 = 7
  add(); //uses default values of x and y and returns 9
  ```

- [MDN: Default Parameters](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Default_parameters)

## Rest/Spread operators

### Spread

- Spread operator (`...`) allows us to expand iterable values into variables

  ```js
  const multiply = (x,y,z) => return x * y * z
  const numbers = [1, 2, 3];

  console.log(multiply(...numbers)); //output: 6
  ```

- We can also copy object properties and thus create a new object

  ```js
  const food = {
    breakfast: ["cornflakes", "oats"],
    lunch: ["burger", "fries", "pizza"],
  };
  const foodAndDrinks = {
    ...food,
    drinks: ["wine", "mocktail", "beer", "juice"],
  };
  console.log(foodAndDrinks);
  /* 
  
  breakfast: ["cornflakes", "oats"],
  lunch: ["burger", "fries", "pizza"],
  drinks:["wine", "mocktail", "beer", "juice"],
   */
  ```

### Rest

- While the syntax of rest operator (`...`) looks exactly like spread operator, its functionality is different. With the help of rest operator you can merge a list of elements into an array
- If you use the operator inside of `{}` or `[]`, you use object or array spreading, respectively. On the other hand, if you use the operator with the last argument in a function signature, that is the rest parameter.

  ```js
  //With arrays
  const numbers = (x, y, ...other) => {
    //some other code
  };

  console.log(numbers); // x = 100, y= 200, other =[300,400,500,600]
  //with objects
  const userDetails = {
    name: "Savitha",
    id: 85,
    place: "India",
  };
  const { name, ...others } = userDetails;
  console.log(`${name} ${others}`); // Savitha {id:85, place: "India"}
  ```

## Optional Chaining

- > The optional chaining operator (?.) enables you to read the value of a property located deep within a chain of connected objects without having to check that each reference in the chain is valid - from MDN

- This is also known as `Elvis Operator`. Using this we can safely access properties and call functions that may or may not exist. Before optional chaining we used to have a workaround with truthy/falsy values.

  ```js
  //before optional chaining
  const doorNo =
    user &&
    user.location &&
    user.location.streetName &&
    user.location.streetName.doorNo;
    //with optional Chaining
    const doorNo = user.?location.?streetName.?doorNo;
  ```

- [MDN: Optional Chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining)

## Nullish Coalescing Operator

- Nullish coalescing operator is also used for short circuiting. If a given a value is `null` or `undefined` you will be using other operand from the expression
- > The nullish coalescing operator (??) is a logical operator that returns its right-hand side operand when its left-hand side operand is null or undefined, and otherwise returns its left-hand side operand. - from MDN

  ```js
  //before we used to do this
  a = a || some_default_value;
  //but this was problematic for falsy values which are valid

  //lets say we wanted to do this
  multiply(undefined, 5);

  //we used to do it this way
  const multiply = (a, b) => {
    a = a === undefined ? 1 : a;
    b = b === undefined ? 1 : b;
    return a * b;
  };
  //with nullish coalescing we can do this now
  const multiply = (a, b) => {
    a = a ?? 1;
    b = b ?? 1;
  };
  ```

- [MDN : Nullish Coalescing](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_operator)

## Array Methods

- Mastering array functions is an important skill for React developers. You will come across `map()` in almost every react application, e.g., to loop over a list of objects and render every single entry within a component.

### map

- The `map()` function produces a new array from an existing array by calling this function for each and every element of the array. This function is used to map values in an array to some other values.

  ```js
  const fruits = ["🍓", "🥝", "🍌", "🍒"];
  const moreFruits = fruits.map((f) => `${f}${f}`);
  console.log(moreFruits); // ["🍓🍓", "🥝🥝", "🍌🍌", "🍒🍒"]
  ```

### filter

- The `filter()` function returns a brand new array containing only those elements of original array that pass a provided condition.

  ```js
  const people = [
    { name: "Adam", gender: "male" },
    { name: "Alice", gender: "female" },
    { name: "Athena", gender: "female" },
  ];
  const women = people.filter((person) => person.gender === "female");
  console.log(women); //{ name: "Alice", gender: "female" },{ name: "Athena", gender: "female" },
  ```

### reduce

- The `reduce()` method as the name sounds, reduces an array of values into a single value. Runs a callback for each and every element.
  ```js
  const nums = [1, 3, 5, 7, 9];
  //Imperative or tradtional way
  let sum = 0;
  const sumOfArrayElements = (nums) => {
    for (let i = 0; i < nums.length; i++) {
      sum += nums[i];
    }
    return sum;
  };
  //Declarative way or using reduce function
  const initial = 0;
  const sum = nums.reduce((total, current) => total + current, initial);
  ```
  - **Note:** Using `initial` is an optional parameter.

### find

- Returns the first entry that satisfies the given condition.

  ```js
  const nums = [5, 15, 25, 30, 45];
  const found = nums.find((element) => element > 20);
  console.log(found); //25
  ```

### some

- Atleast one element in the array should satisfy the condition. Returns true if, in the array, it finds an element that satisfies the condition, else returns false.

  ```js
  const nums = [1, 2, 3, 4, 5];
  const odd = nums.some((element) => element % 2 !== 0);
  console.log(odd); //true
  ```

### every

- Every element of the array must satisfy the condition. Returns true if all the elements pass the condition else returns false.

  ```js
  const nums = [1, 2, 3, 4, 5];
  const isBelowLimit = nums.every((element) => element < 10);
  console.log(isBelowLimit); //true
  ```

### sort

- Sorts elements of an array in place & returns sorted array.
- Default sort order is built upon converting element to string, then comparing to their unicode (UTF-16) unit values

  ```js
  const months = ["March", "Jan", "Feb", "Dec"];
  months.sort(); //[Dec,Feb,Jan,March]
  const nums = [1, 30, 4, 21, 100000];
  nums.sort(); //[1,100000,21,30,4]
  ```

  `Syntax: arr.sort(compareFn);`

  - `compareFn` determines the sort order.
  - If this is omitted arr elements are converted to strings then sorted according to each character unicode.

  ```js
  let num = [4, 12, 5, 1, 3];
  num.sort((a, b) => a - b); //[1,2,3,4,5]
  num.sort((a, b) => b - a); //[5,4,3,2,1]
  ```

### includes

- Determines whether an array includes a certain value among its entries, returns `true` if an element is included, else returns `false`
  `Syntax: array.includes(element)`
  ```js
  const numbers = [1, 3, 5];
  values.includes(3); // true
  values.includes(2); // false
  ```

### splice

- Changes the content of an array by replacing or removing existing elements and / or adding new elements in place.

  ```js
  const months = ["Jan", "March", "April", "June"];
  //Add an item to array
  months.splice(1, 0, "Feb"); //[Jan,Feb,March,April,June] -> RT :[]

  //Replace  item in array

  //replace 1 item at index 4 with the 3rd param
  months.splice(4, 1, "May"); //[Jan,Feb,March,April,May] -> RT: deleted value -> June

  //Delete items
  let arrDeletedItems = arr.splice(start,deleteCount[,item1[,item2]...])
  //start - > index at where to start (if its -ve start from end)
  //deleteCount -> an integer indicating how many elements to be deleted from `start`

  //RT : An array containing deleted items, if no items are deleted an empty array is returned. deleted ele if only one is removed.

  months.splice(0,2) //RT: Jan,Feb . arr: [March, April, May]

  ```

### slice

- Returns a shallow copy of portion of an array into new array object selected from begin to end (non inclusive)

  ```js
  const num = [1, 2, 3, 4, 5];
  num.slice(2); //[3,4,5]
  num.slice(2, 4); //[3,4] -> 4th pos is not included
  num.slice(1, 5); //[2,3,4,5]
  num.slice(-3); //[3,4,5]
  num.slice(-3, -1); //[3,4] -> go 3 elements back & 1 ele forward.
  //copy an entire arr
  num.slice(); //[1,2,3,4,5]
  ```

## Default Exports vs Named exports

- While working with react you will often come across exports and imports, so it is very important to know how this works.
- [Here's a good explanation on Module exporting and importing](https://blog.greenroots.info/javascript-modules-and-how-to-effectively-work-with-export-import-cka7t5z6s01irx9s16st6j51j)

## Promises and async/await

- Promises are the important concept to understand the asynchronous events in the code. These are also used quite often in React.
- I recommend you to check these resources.
  1. [How Asynchronous code works in JS]({{<ref "/posts/15-async-code-in-js.md">}})
  2. [What are promises and how they work]({{<ref "/posts/14-promises-explained.md">}})
  3. [Async and Await]({{<ref "/posts/16-async-await.md">}})

## Basic DOM APIs

- If you ever came across `document.getElementById` or `createElement` etc,. you know these are used to modify the DOM elements. Its good to have a knowledge of DOM APIs to understand similiraties and differences between DOM API and react APIs.

- [MDN Docs are best place to learn this](https://developer.mozilla.org/en-US/docs/Web/API/Document)

---

Thats all for now. In the next article we'll dive into Raw React APIs to understand the underlying structure of React code.

Until next time, Happy learning! :tada: :computer:

