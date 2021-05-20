---
title: "Hosting react projects on GH Pages"
date: 2020-09-11T12:31:59+05:30
draft: false
description: Host react apps for free on Github Pages.
featured: false # feature a post in homepage
tableofcontents: true # whether to generate ToC
tags: [ghpages, react, hosting]
categories: [devops, ci-cd]
hideToc: false
enableToc: true
enableTocContent: true
image: "https://miro.medium.com/max/1000/1*4u4uD5FiSkWdBNkRO6lVtQ.jpeg"
---

<!--  Start Typing... -->

Want to host a react website? You cant afford paying bills for each and every project?

Well, Don't worry now you can do that for free with the help of [Github Pages](https://pages.github.com/). Using GH Pages you can host any website for free in a secured way.

When you host any static website or blog on github servers, basically your domain name would be in this format: `{username}.github.io/{repo-name}`, if you wish to host it on your own domain, no problem you can do that as well.

In this post let's see how to host a react project on GH Pages.

Before continuing further, I assume that you know what is Github and how to create a react app. Let's get started...

## TL;DR :rocket:

These are the only commands you need to execute

```sh
npm install gh-pages --save-dev
```

_Package.json_

```json
"scripts": {
"start": "react-scripts start",
"predeploy": "npm run build",
"deploy": "gh-pages -d build",
"build": "react-scripts build",
},
//add homepage property
"homepage": "https://g-savitha.github.io/projectname"
```

```sh
npm run deploy
```

## Create a repository

First things first, create a repository in your Github profile. For instance I'd like to create an app with name `deploy-react-app`

![create-repo](https://i.imgur.com/EVPrPjZ.png)

**Note:** If you have already developed a react app and pushed it onto Github you can skip this section..

## Create react app

After creating a repo, Let's create a react app using`create-react-app`.

```sh
npx create-react-app deploy-react-app
cd deploy-react-app
```

Once you created a react app and changed into its directory. Run the following commands in terminal/command prompt.

```sh
git init
git add -A
git commit -m "initial commit"
git remote add origin https://github.com/username/deploy-react-app.git
git push origin master
```

**Note:** replace `username` with your own Github username and if you are using ssh instead of https for Github repo add `git remote add origin git@github.com:username/deploy-react-app.git`

Once you pushed your code to Github...

## Deploy app on GH Pages

1. Install `gh-pages` as dev-dependency of react app.
   ```sh
   npm install gh-pages --save-dev
   ```
2. Add the `homepage` property in your `package.json` file. `homepage` attribute value should be String. `http://{username}.github.io/{repo-name}` (`username` must be your Github username and `repo-name` must be your GitHub repository)
   ```json
   "homepage": "https://g-savitha.github.io/deploy-react-app"
   ```
3. Add the `predeploy` and `deploy` properties with existing `scripts` property in your project's `package.json`
   ```json
   "scripts": {
   "start": "react-scripts start",
   "predeploy": "npm run build",
   "deploy": "gh-pages -d build",
   "build": "react-scripts build",
   "test": "react-scripts test",
   "eject": "react-scripts eject"
   },
   ```
   The `predeploy` script initiates after running our `deploy` script, which bundles our application for deployment.
4. Deploy your application to GH pages.
   ```sh
   npm run deploy
   ```

After succesfully deploying the application, Open your github repository. Go to **Settings** tab of the repository, scroll down until you reach Github Pages section and choose `gh-pages` branch as the source.

BOOM! :boom: your website is hosted on Github pages now.

---

Other than Github, you can host your website on [Heroku](), [Vercel](), [Firebase](), [Netlify]() and more. Try out as many as you can to determine which best aligns with your deployment requirements. After all they're free to use :smiley:.

For a good next step, try to add custom domains to your deployed application. It’s good to have a distinctive domain for projects.

Until next time, Happy coding! :computer: :tada:

---

If this was helpful to you, please Share this article so that it reaches others as well. To get my latest articles straight to your inbox, please subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) . You can also follow me on twitter [@gsavitha\_](https://twitter.com/gsavitha_).
