---
title: "Intro to Node"
date: 2020-09-22T16:09:53+05:30
draft: false
tags: [node, javascript, es6]
categories: [node]
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

## What is Node and why to use it?

- **What is Node?** Node.js is a _JS runtime_ built on top of Google's opensource V8 Js Engine. Node helps us to run JS outside the browser. It acts like a container to run JS code. _V8 engine executes the JS code_.

- **Why Node?** With help of Node, we can use JS on server-side of web development. We can build fast, highly scalable applications.

### Pros

- _**Single threaded, based on event driven, non blocking I/O model**_.
- Perfect for building _fast_ and _scalable_ data-intensive apps
  - Eg: Building an API with DB, preferably NoSQL DB.
  - Data streaming apps (Youtube or Netflix), Real time chat apps, Server side webapps(Entire content generated on server)
- _JS across entire stack_: faster and efficient development.
- _NPM_ : huge lib of open-sourcepackages available for free.
- Very active dev community.

## When to not use Node?

- Applications with heavy server-side processing (CPU-intensive)
  - Image manipulation, Video compression, file compression etc. (Use python or Ruby on rails or PHP for things like this)

## REPL

```sh
node
# acts like a console
> greet='क्या हाल है?'
'क्या हाल है?'
> 7+3
10
> !0
true
> +'7'
7
> 3*8
24
> _+15 # _ adds 15 to previous value
39
> _-30 #subtracts 30 from previous value
9
> .exit or #ctrl + D
```

- **Trick**: By hitting `tab` in node repl, you can see all global vars available.

  - `String.` + `tab ` -> lists all string methods available

- [Read more from here](https://nodejs.org/dist/latest-v14.x/docs/api/repl.html)

## Intro to Node Modules

- With Node we can do all sorts of amazing things that we cant with browser, like accessing file system. In order to do that we need to use node modules. All kinds of _additional functionality_ is stored in modules.

- **How to use modules?** _Require_ them in your code and _store_ them in a _variable_

```js
const fs = require("fs"); //returns an object with lots of fns which we can later use
```

- Check out other modules from [Official Docs](https://nodejs.org/dist/latest-v14.x/docs/api/)

## `fs` module

### reading and writing files

#### `readFileSync()`:

- Sync version of file Reading
- Takes two args : (filePath, charEncoding)

```js {hl_lines=[3]}
const fs = require("fs");
//reads data from file and encodes in readable format
const textIn = fs.readFileSync("./txt/input.txt", "utf-8"); // if we dont specify encoding, we get buffer as output
console.log(textIn);
```

- [Refer](https://nodejs.org/dist/latest-v14.x/docs/api/fs.html#fs_fs_readfilesync_path_options)

#### `writeFileSync()`:

- Sync version of file writing
- Takes two args : (filePath, textToOutput)

```js {hl_lines=[2]}
const textOut = `This is what we know about : ${textIn}.\nCreated on ${Date.now()}`;
fs.writeFileSync("./txt/output.txt", textOut);
console.log("File written");
```

- [Refer](https://nodejs.org/dist/latest-v14.x/docs/api/fs.html#fs_fs_writefilesync_file_data_options)

### Blocking and Non-blocking async nature of Node

- The previous written code is synchronous way (each statement is processed one after the other). Each line of code depends on prev line's execution. This behavour of _**Synchronous code is also called Blocking code**_.
- _**Async code is non-blocking code**_. We upload heavy work to run in background. Once that work is done **A Callback** which we registered before _is called to handle the result_. In the mean time rest of code will be executing, without being blocked by heavy task(running in bg). We need to make our code non-blocking

Async version of previous code ...

```js {hl_lines=[1]}
fs.readFile("./txt/input.txt", "utf-8", (err, data) => {
  if (err) throw new Error();
  console.log(data);
});
console.log("reading file...");
```

- **Why does it have to be this way?** : Node's process(where our app is running) is a **single threaded** (A thread is set of instructions that runs on CPU.) _For each app there is only one thread_. All users accessing your application use the same thread. Whenever they are interacting with your application the _code for each user will run on same thread at same place_. When one user blocks the code with sync code all have to wait for that execution to complete.

- **Note:** _When we use callbacks in our code, it doesn't automatially make it asynchronous_. Passing functions as args is quite common in JS, so that doesn't make them async automatically. _**It only works this way for some functions in Node API.**_ One such example is `readFile()` function.
- While writing async code, make sure you dont get into ["Callback hell"](https://www.geeksforgeeks.org/what-is-callback-hell-in-node-js/#:~:text=This%20is%20a%20big%20issue,difficult%20to%20read%20and%20maintain.). Use _ES6->Promises_ or _ES8->Async/Await_ to escape callback hell.

### Reading and Writing files Asynchronously (Non-blocking way)

#### `readFile()`:

- file-encoding is optional. Better to have it
- **How this works?** node will read our file first in the bg, as soon as it is ready it will start the cb fn we specified

```js {hl_lines = [2, 3, 4]}
fs.readFile("./txt/start.txt", "utf-8",
(err, data) => {
    console.log(data)
}
console.log("will read first")
//output:
// will read file
//text in start.txt
```

- **Note :** callback function will run only when reading the file is done

```js {hl_lines=[2]}
fs.readFile("./txt/start.txt", "utf-8", (err, data1) => {
  fs.readFile(`./txt/${data1}.txt`, "utf-8", (err, data2) => {
    //2nd readFile depends on 1st one coz we are using data of file1 as the name of file2
    console.log(data2);
    fs.readFile(`./txt/append.txt`, "utf-8", (err, data3) => {
        console.log(data3);
    }
  });
});
console.log("will read file!");
//output:
//will read file
//output of data2
//output of data 3
```

#### `writeFile()` :

- Args: where to write, what to write, encoding, callback

```js {hl_lines=[9]}
fs.readFile("./txt/start.txt", "utf-8", (err, data1) => {
    if(err) return console.log(`ERROR!! ${err} 😥`);
  fs.readFile(`./txt/${data1}.txt`, "utf-8", (err, data2) => {
      if(err) return console.log(`ERROR!! ${err} 😥`);
    console.log(data2);
    fs.readFile(`./txt/append.txt`, "utf-8", (err, data3) => {
        if(err) return console.log(`ERROR!! ${err} 😥`);
        console.log(data3);
        fs.writeFile(`./txt/final.txt`, `${data2}\n${data3}`, "utf-8",
        (err) => { //no data to read, so only one arg: err
            console.log('file has been written 😁')
        })
    }
  });
});
console.log("will read file!");
//output:
// will read file
//output of data2
//output of data3
//file has been written 😁
```

- This type of code is an example of _callback hell_.

- [More about `fs` module](https://nodejs.org/dist/latest-v14.x/docs/api/fs.html)
