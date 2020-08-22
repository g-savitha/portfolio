---
title: Today I Learned (Tech)
---

### 17 June, 2020

#### ES6: Private method using `Symbol()`

Symbol in JavaScript(ES6) is a data type. The speciality about Symbols are
that the value is unique. Using this feature, one could abstract methods of
ES6 `class`. Here's an example:

```javascript {hl_lines=[2, 5, "8-10"]}
(() => {
    const FORMAT_MSG = Symbol();
    class SayHello {
        constructor(name) {
            this[FORMAT_MSG](name);
        }

        [FORMAT_MSG](name) {
            this.message = `Hello, ${name}`
        }

        done() {
            alert(this.message);
        }
    }

    window.SayHello = SayHello;      // make it available to global scope
})()
```

credit: [Rajesh Pillai](https://teachyourselfcoding.com/articles/javascript-es6-private-methods-in-class-without-closure-using-symbol/)
