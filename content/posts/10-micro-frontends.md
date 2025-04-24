---
title: "What is Micro Frontends?"
url : "/posts/mfe"
date: 2021-03-26T14:45:17+05:30
draft: false
description: "A microservice approach to frontend"
hideToc: false
enableToc: true
enableTocContent: true
tags: [web-architecture, design]
categories: [frontend]
---

Most of the web apps these days are having 90% of front end and only 10% of the backend. As the application grows bigger and bigger having a **monolithic** approach on front end doesn't work. There needs to be a way to break this approach into smaller modules that can work independently.

**Micro Frontends** - A micro service approach to front end development.

## What does it mean?

Micro Frontends are loosely coupled components of UI that are developed by applying micro services principles on frontend.

> Writing Micro frontends is more of an architectural design & development rather than being a technology.

## How does it help?

Applying microservices on frontend gives complete freedom to the developers on _picking their desired tech stack_ to develop a service. Not only that, since they are loosely coupled, _fault isolation_ is provided as well.

## Microfrontends vs Monolithic architecture

Despite of having microservices in the backend, a seperate team is required to handle the front end development if you have a monolithic architecture.

{{< img src="/images/blog-img/monolithic.jpeg" alt="monolithic" width="400px" position="center" >}}

With the micro frontends approach, we split our application into vertical blocks. Where each block goes from end to end from UI to database.

Using this micro frontends approach, each team will have an independence to build their own components in their desired tech stack. Later, integrating all these independent components helps us in forming a Complete UI application and also prevents a need to have a dedicated centralised UI team.

{{< img src="/images/blog-img/mf.jpeg" alt="microfrontends" width="400px" position="center" >}}

## Example - an e-commerce application

I took this example because micro frontends in most popular with the e-commerce websites.

Alright, let us consider an online gaming store as an example.

Our website has several UI components, some of the key feature components are:

- **Search Component:** This component helps the users in searching based on the words they enter.
- **Game Category Component:** This component helps the users in displaying the games by filtering them based on the given category (price, new arrivals, popular, season's best, highest paid etc)
- **Add to cart and Checkout component:** This component helps the users in adding items to cart and proceed with filling the details before the payment.
- **Payment Component:** This component helps the users in facilitating different modes of payments.

Every component is powered by a dedicated microservice running behind the scenes. A dedicated full stack teams are assigned to manage and develop individual components.

{{< img src="/images/blog-img/mf2.jpeg" alt="microfrontends" width="400px" position="center" >}}

## Can I use this in my application?

It may sound delightful to go forward with the micro frontends approach but it only fits for _medium to large scale applications_, for simple use cases this approach is not that advantageous. Rather it will make things more complex.

If we use multiple technologies for a simple use case, not only it becomes cumbersome but also brings lots of architectural, compatability, performance and maintainance complexities.

With micro frontends, we also need to write additional logic to club all the components together.

So, there are always trade-offs involved. There is no silver bullet.

## How do I integrate?

So, once we are done with having different micro frontends, how can we integrate them all together to have a fully functional website?

We can do it in 2 ways:

1. **Integrating micro frontends on client**
2. **Integrating micro frontends on server**

This concept is pretty similar to client side & server side rendering. In this case we just need to write additional logic to integrate different UI components.

### Client side integration

A naive approach is to have micro frontends with unique links, whenever a user clicks a link they will be navigating to micro frontend.

{{< img src="/images/blog-img/mf3.jpeg" alt="microfrontends" width="400px" position="center" >}}

Lets say you have hosted your _checkout_ component on Google Cloud and _Payments_ on AWS. If you integrate via basic links, when you navigate from checkout page to payments page, the address in the browser will be visible to the end user (when it changes from GCP's URL to AWS's URL).

One way to do this is by integrating these links in a specific page using [iframes.](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) You may argue that using iframes is a very legacy approach, yes, you are right.

_Recommended read:_ [Good reasons why not to use Iframes in page content](https://stackoverflow.com/questions/23178505/good-reasons-why-not-to-use-iframes-in-page-content)

{{< img src="/images/blog-img/mf4.jpeg" alt="microfrontends" width="400px" position="center" >}}

A _Recommended way_ to integrate on client side is using Web Components and frameworks such as [single SPA](https://single-spa.js.org/)

From [MDN](https://developer.mozilla.org/en-US/docs/Web/Web_Components) :

> Web Components is a suite of different technologies allowing you to create reusable custom elements — with their functionality encapsulated away from the rest of your code — and utilize them in your web apps.

_Single SPA_ is a JS Framework for micro services, which enables developers to build their UI with different JS frameworks.

### Server side Integration

As opposed to sending individual components onto client and integrating them together, these UI components are integrated on the server, on user's request a complete pre built web page is delivered to client from server _cutting down the loading time_ on client.

Just like client side integration process we need to write seperate logic on the server to integrate these micro frontends.

These are few of the technologies and frameworks that helps us to achieve this.

- [Open Components](https://opencomponents.github.io/) : An open-source framework to integrate micro frontends components.
- [Server side includes (SSI)](https://en.wikipedia.org/wiki/Server_Side_Includes) : A scripting language used to integrate contents of files onto web pages.
- [Project Mosaic](https://www.mosaic9.org/)
- [Podium](https://podium-lib.io/)

That's all folks, that pretty much sums up about micro frontends.

Until next time, happy learning! :tada: :computer:


