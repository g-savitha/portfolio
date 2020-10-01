---
title: "Intro to Node - 2"
date: 2020-09-22T19:00:37+05:30
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

## Creating a Web server

## `http` module

- Gives us _networking capability_ -> such as _building a http server_.

```js
const http = require("http");
```

- `http` requires a _cb fn which gets fired off whenever a new request comes_
- CB _gets access to_ _2 very imp variables_ _*(req and res)*_

- Create a server
- start the server -> by listening on incoming reqs

_Create a server:_

```js
http.createServer(
  //whenever a new req comes to server, this callback is called
  (req, res) => {
    res.end("Hello from the server!"); // the response we send back
  }
);
```

_listening on incoming reqs_ :

- store result of server in a new variable to listen on incoming requests.

- Args: _PORT_(sub address on a certain host), _HOST-ADDRESS_(where to go next (by default it is localhost)), _CALLBACK_(Optional)
- CB runs right after server is started

```js
const server = http.createServer((req, res) => {
  res.end("Hello from the server!");
});
//listen to incoming requests from client
server.listen(8000, "127.0.0.1", () => {
  console.log("listening to reqs on port: 8000");
});
//enter 127.0.0.1 :8000 in browser
```

**Note :** Node cannot simply exit the process this time -> coz of _event loop_ . It keeps on listening to incoming request on given port.

- [More about `http` module](https://nodejs.org/dist/latest-v14.x/docs/api/http.html)

### Routing

- _Routing_: Implementing different actions for different URLS
- Routing in `http` becomes complicated as the application grows, so use `express` then.

- First Step : Analyze the URL. Lets use `url` module for that

```js
const url = require("url");
```

- _url module parses_ urls like `/overview/id=23&abc=4d` _into a nicely formatted object_.

```js
const server = http.createServer((req, res) => {
  console.log(req.url); // we get 2 reqs by default (`/ ` & `/favicon.ico`) -> cb is executed twice
    res.end("Hello from the server");
  }
});
```

_Routing..._

- `res.writeHead()` : Sends a response header to the request.
  - Args: _statusCode_ (3 didgit HTTP code like `404`), _status-msg_(optional, for human readabilty), _headers_(response headers -> [info about response we are sending back])
    - **Note** : We can also specify custom header
  - This method _must only be called once on a message_ and it _must be called before_ `response.end()` is called.
  - _Returns a reference to the ServerResponse_, so that calls can be chained.

```js {hl_lines=[2,12,13,14,15,16,19]}
const server = http.createServer((req, res) => {
  const pathName = req.url;
  if (pathName === "/" || pathName === "/overview") {
    res.end("This is overview page");
  } else if (pathName === "/product") {
    res.end("This is product page");
  } else {
    // throws a 404 error in browser console. You can also check in network tab
    res.writeHead(404);
    //there are many header types one of them is content-type
    //note all these status codes and headers need to be sent before sending response
    res.writeHead(404, {
      "Content-type": "text/html", //browser now expects an html to come in
      // our own made up header
      "my-own-header": "hello-world",
    });
    res.end("Page not found!");
    //what we can do now is embed a html in response
    res.end("<h1>Page not found</h1>"); //output : response in <h1>
  }
});
```

## Build a simple API

- **API** : A service from which we can request data.

- _First Way_:
  - Read data from json file and parse data to JS
  - Send result back to client

```js {hl_lines=[3,4,6]}
if (pathName === "/api") {
  //__dirname translates directory in which script that we're currently executing is located
  fs.readFile(`${__dirname}/dev-data/data.json`, "utf-8", (err, data) => {
    const productData = JSON.parse(data); //Turns JSON string to JS object
    console.log(productData);
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(data);
  });
}
```

This is _not 100% efficient_, because each time a user hits `/api` file have to be read and then sent back. Instead we can _read the file once in the beginning_ and then each time someone hits this route, _simply send back the data without having to read it each time that a user requested_

- _Efficient way_:
  - _Use sync version of readFile_ (But sync version blocks code right?)
    - In this case, its not a problem at all coz top level code gets executed only once in the beginning.
    - The code outside callback(so called top-level code) gets executed only once.

```js
//top-level code
const data = fs.readFileSync(`${__dirname}/dev-data/data.json`, "utf-8");

//inside callback
if (pathName === "/api") {
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(data);
}
```

### Parse variables from URL

- lets say from url : 'https://localhost:8080/api&id=0' and we want query string ie., 'id=0'

```js
const url = require("url");
console.log(url.parse(req.url, true));
```
