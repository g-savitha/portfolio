---
title: "Build your own HTTP Server"
url: "/posts/http-server"
date: 2025-04-07T22:16:23+05:30
draft: false
hideToc: false
enableToc: true
pinned: true
enableTocContent: true
tags:
 - typescript
 - node
 - backend
 - http 
categories:
  - backend
  - build-your-own-x
---

Have you ever wondered what happens behind the scenes when you browse the web? How does your browser communicate with servers to fetch websites and data? Recently, I completed the "Build Your Own HTTP Server" challenge on [codecrafters.io](https://codecrafters.io), and I want to share what I learned through this hands-on experience.

In this post, I'll walk you through creating a basic HTTP server using TypeScript. By the end, you'll understand the fundamentals of HTTP servers and have the knowledge to build your own!

## Creating a Socket Connection

The first step in building an HTTP server is establishing a socket connection. In networking, a socket is an endpoint for sending and receiving data across a network.

[TCP](https://www.cloudflare.com/en-ca/learning/ddos/glossary/tcp-ip/) is the underlying protocol used by HTTP servers. Let's create a TCP server that listens on port 4221:

```typescript
import * as net from "net";

const server = net.createServer((socket) => {
  socket.on("close", () => {
    socket.end();
  });
});

server.listen(4221, "localhost");
```

This code:
1. Imports the `net` module, which provides an API for creating TCP servers in Node.js
2. Creates a server using `net.createServer()` that executes a callback when a client connects
3. Sets up an event listener to properly close connections
4. Tells the server to listen on port 4221 on localhost (127.0.0.1)

Now we have a basic TCP server that can accept connections, but it doesn't do anything useful yet.

## Responding with a Basic HTTP 200 OK

HTTP responses have three parts, each separated by a [CRLF](https://developer.mozilla.org/en-US/docs/Glossary/CRLF) (`\r\n`):
1. Status line
2. Zero or more headers, each ending with a CRLF
3. Optional response body

Let's modify our server to respond with a simple "200 OK" status:

```typescript
socket.write(Buffer.from(`HTTP/1.1 200 OK\r\n\r\n`));
```

This response contains:
- **Status line**: `HTTP/1.1 200 OK\r\n` — Indicates the HTTP version, status code, and reason phrase
- **Headers**: Empty, but marked by the second `\r\n`
- **Response body**: Empty

## Extracting URL Paths and Handling Routes

Now let's make our server actually do something useful by parsing HTTP requests and responding differently based on the requested path.

An HTTP request consists of:
1. Request line (HTTP method, request target, HTTP version)
2. Zero or more headers
3. Optional request body

Here's how we can extract the URL path and respond with either a 200 OK or 404 Not Found:

```typescript
socket.on('data', (data) => {
  const request = data.toString();
  const path = request.split(" ")[1];
  const response = path === '/' ? `HTTP/1.1 200 OK\r\n\r\n` : `HTTP/1.1 404 Not Found\r\n\r\n`
  socket.write(response);
  socket.end();
})
```

This code:
1. Listens for data coming through the socket
2. Converts the binary data to a string
3. Extracts the path from the request (the second part of the first line)
4. Returns a 200 response for the root path (`/`), and 404 for anything else
5. Closes the connection

## Responding with a Body

Let's add an `/echo/{str}` endpoint that returns whatever string is passed to it:

```typescript
socket.on('data', (data) => {
  const request: string = data.toString();
  const path: string = request.split(" ")[1];

  const query = path.split('/')[2];
  console.log(`path body`, query);

  let response = `HTTP/1.1 200 OK\r\n`;

  if (path === '/') {
    response += `\r\n`;
  }
  else if (path === `/echo/${query}`) {
    response += `Content-Type: text/plain\r\nContent-Length: ${query.length}\r\n\r\n${query}`;
  }
  else {
    response = `HTTP/1.1 404 Not Found\r\n\r\n`;
  }
  socket.write(response);
  socket.end();
})
```

When implementing response bodies, we need to include these important headers:
- `Content-Type`: Tells the client what format the body is in (in this case, `text/plain`)
- `Content-Length`: Specifies the size of the body in bytes

## Reading Request Headers

HTTP headers contain important metadata. Let's implement a `/user-agent` endpoint that reads the [`User-Agent`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent) header from the request and returns it:

```typescript
let params = path.split('/')[1];
console.log(params);

const writeResponse = (response: string): void => {
  socket.write(response);
  socket.end();
}
switch (params) {
case 'user-agent': {
    const userAgent: string = request.split("\r\n")[2].split(":")[1].trim();
    response += `Content-Type: text/plain\r\nContent-Length: ${userAgent.length}\r\n\r\n${userAgent}`;
    writeResponse(response);
    break;
  }
default: {
    response = `HTTP/1.1 404 Not Found\r\n\r\n`;
    writeResponse(response);
    break;
  }
}
```

Note that header names are [case-insensitive](https://datatracker.ietf.org/doc/html/rfc9112#name-field-syntax), so we need to handle that properly in a production server.

## Handling Concurrent Connections

A real HTTP server needs to handle multiple clients simultaneously. Fortunately, Node.js's event-driven architecture makes this easy - our existing code can handle concurrent connections without modification!

The JavaScript [execution model](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Execution_model) is based on an event loop, which allows us to handle multiple connections without creating threads.

## Serving Files

Let's add the ability to serve files from the file system with a `/files/{filename}` endpoint:

```typescript
import { readFileSync } from "fs";

case 'files': {
  const fileName = path.split('/')[2];
  const args = process.argv.slice(2);
  const [_, absPath] = args;
  const filePath = absPath + fileName;
  try {
    const fileContent = readFileSync(filePath);
    response += `Content-Type: application/octet-stream\r\nContent-Length: ${fileContent.length}\r\n\r\n${fileContent}`
    writeResponse(response);
  }
  catch (error) {
    response = `HTTP/1.1 404 Not Found\r\n\r\n`;
    writeResponse(response);
  }
  break;
}
```

This code:
1. Extracts the filename from the path
2. Gets the directory path from command-line arguments.
3. Tries to read the file
4. If successful, returns the file with appropriate headers
5. If the file doesn't exist, returns a 404 response

## Handling POST Requests and Request Bodies

Finally, let's implement the ability to create files via POST requests to the `/files/{filename}` endpoint:

```typescript
import { readFileSync, writeFileSync } from "fs";

socket.on('data', (data) => {
  const [requestLine, ...headers] = data.toString().split("\r\n");
  const [body] = headers.splice(headers.length - 1);
  const [httpMethod, path] = requestLine.split(" ");
  //some other code
  case 'files': {
    const fileName = path.split('/')[2];
    console.log(`fileName : ${fileName}`);
    if (httpMethod !== 'POST') {
      const args = process.argv.slice(2);
      const [_, absPath] = args;
      console.log('args' + args);
      const filePath = absPath + fileName;
      try {
        const fileContent = readFileSync(filePath);
        response += `Content-Type: application/octet-stream\r\nContent-Length: ${fileContent.length}\r\n\r\n${fileContent}`
        writeResponse(response);
      }
      catch (error) {
        response = `HTTP/1.1 404 Not Found\r\n\r\n`;
        writeResponse(response);
      }
    }
    else {
      writeFileSync(fileName, body);
      response = `HTTP/1.1 201 Created\r\n\r\n`;
      writeResponse(response);
    }
    break;
  }
});
```

This code:
1. Parses the HTTP method from the request line
2. Extracts the request body
3. For GET requests, serves the file as before
4. For POST requests, creates a new file with the request body content and returns a 201 Created response

## Implementing HTTP Compression

HTTP compression is a technique that reduces the size of data transmitted between servers and clients, improving load times and reducing bandwidth usage. Let's implement this important feature in our server.

### Supporting Basic Compression Headers

First, we need to check if the client supports compression by reading the [`Accept-Encoding`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Encoding) header:

Let's use the echo endpoint for http compression.

```typescript
type HttpRequest = {
  method: string;
  path: string;
  headers: Record<string, string>;
  body: string;
}

type HttpResponse = {
  statusCode: number;
  statusText: String;
  headers: Record<string, string>;
  body: string | Buffer;
}

const handleEchoRequest = (path: string, headers: Record<string, string>): HttpResponse => {
  const echoText = path.split('/')[2];
  const baseHeaders = {
    'Content-Type': 'text/plain',
  }

  const acceptEncoding = headers['Accept-Encoding'];
  const hasGzipEncoding = acceptEncoding === 'gzip';

  return {
    statusCode: 200,
    statusText: 'OK',
    headers: hasGzipEncoding ? 
      { ...baseHeaders, 'Content-Encoding': 'gzip', 'Content-Length': echoText.length.toString() } : 
      { ...baseHeaders, 'Content-Length': echoText.length.toString() },
    body: echoText
  };
}
```

In this enhanced code, we're:
1. Creating types for structured HTTP requests and responses
2. Checking if the `Accept-Encoding` header is set to `gzip`
3. If it is, adding a `Content-Encoding: gzip` header to our response

### Handling Multiple Compression Schemes

Clients can request multiple compression schemes using a comma-separated list. Common compression schemes include [gzip](https://www.gnu.org/software/gzip/), [Brotli](https://github.com/google/brotli), [deflate](https://en.wikipedia.org/wiki/Deflate), and [zstd](https://facebook.github.io/zstd/). Let's update our code to handle multiple schemes:

```typescript
const baseHeaders = {
  'Content-Type': 'text/plain',
}

const acceptEncoding = headers['Accept-Encoding'];
const hasGzipEncoding = acceptEncoding === 'gzip' || acceptEncoding?.split(',').map(enc => enc.trim()).includes('gzip');
```

This code:
1. Splits the `Accept-Encoding` header by commas
2. Trims whitespace from each encoding scheme
3. Checks if `gzip` is among the supported schemes

### Actually Compressing the Content

Finally, let's add actual `gzip` compression to our responses:

```typescript
import { gzipSync } from "zlib";

const acceptEncoding = headers['Accept-Encoding'];
const hasGzipEncoding = acceptEncoding === 'gzip' || acceptEncoding?.split(',').map(enc => enc.trim()).includes('gzip');

if (hasGzipEncoding) {
  const textBuffer = Buffer.from(echoText, 'utf8');
  const compressedBody = gzipSync(textBuffer);
  return {
    statusCode: 200,
    statusText: 'OK',
    headers: {
      'Content-Encoding': 'gzip',
      ...baseHeaders,
      'Content-Length': compressedBody.length.toString(),
    },
    body: compressedBody
  }
}
return {
  statusCode: 200,
  statusText: 'OK',
  headers: {
    ...baseHeaders,
    'Content-Length': echoText.length.toString()
  },
  body: echoText
};
```

In this code, we:
1. Import Node.js's built-in `zlib` module for compression
2. Convert our text to a Buffer
3. Compress the Buffer using `gzipSync`
4. Update the `Content-Length` header to reflect the compressed size
5. Return the compressed data as the response body

Adding compression to our server makes it more efficient and production-ready. For small payloads like our examples, compression might actually increase the size due to overhead, but for larger content, the bandwidth savings can be substantial.

## Conclusion

Building a HTTP server from scratch gives you a deep understanding of how web servers work. We've covered:

1. Setting up a TCP server
2. Parsing HTTP requests
3. Generating HTTP responses
4. Handling different routes
5. Reading headers and request bodies.
6. Serving and creating files
7. Implementing HTTP compression

This is just the beginning - a production-ready HTTP server would need additional features like proper header parsing, robust error handling, connection pooling, and more.

Here's the full source code: https://github.com/g-savitha/http-server

Have you built your own HTTP server or completed a similar challenge? What did you learn from the experience? Let me know in the comments below!

Until next time, happy coding! :computer: :tada:
