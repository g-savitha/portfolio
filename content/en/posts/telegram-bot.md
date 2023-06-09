---
title: "How I built an expenses tracker bot on telegram"
date: 2023-06-09T18:28:23+05:30
draft: false
hideToc: false
enableToc: true
pinned: false
enableTocContent: true
tags:
 - typescript
 - node
 - mongo 
categories:
  - typescript
  - node
---

Hello there! :wave:,

In the recent times I've been working on an exciting project called **'Artha Chakra'**. It's a telegram bot which helps you in tracking your expenses. 

## How did I build it?

### Why a telegram bot?

With numerous finance tracking apps available, the simplicity of tracking expenses by sending a text message, without switching apps, seemed really appealing. 

### Sketching the Bot's Functionality

Now that the convenience factor is sorted, I wanted to integrate features such as expense addition, daily reminders, alerts upon reaching monthly spending limits, expense categorization, and displaying the balance.

### Setting up 'Artha Chakra' on Telegram

Creating a bot on telegram was super easy. I simply created a new bot through *BotFather*, and like a secret password, I got my token to interact with the Telegram API.

### Building 'Artha Chakra'

For building this bot, I chose `Node.js` and `TypeScript` as the framework, relying on the `node-telegram-bot-api` library for smooth sailing. Commands like "`/credit`" and "`/debit`" were coded to handle addition and deduction of expenses respectively. A daily reminder was implemented using a cron job when you run "`/enable_reminder`". Here's peek at that snippet: 

```javascript
cron.schedule("0 21 * * *", async () => {
  // Checks if the user has enabled a reminder already 
  const users = await User.find({ reminderEnabled: true });

  for (let user of users) {
    // Send a reminder to each user who has enabled the reminder
    bot.sendMessage(
      user.telegramId,
      "Don't forget to add your expenses for today!"
    );
  }
});
```

### Deploying 'Artha Chakra'

Finding the right hosting service was a hassle with many options available like Vercel, AWS, GCP, Azure and Heroku on the table. Balancing complexity and pricing, I settled with `Render.com`, whose free tier graciously offered 512MB of space!

### Handling Data with MongoDB Atlas

Storing user data securely was of prime importance. I used MongoDB Atlas to host my database on the cloud. The three main collections were: Users, Categories, and Transactions, each playing a key role in storing user information, expense categories, and transaction details respectively.

### Challenges I Faced

As I was developing this project, I had a few hiccups:

1. Scheduling a user-specific reminder according to different timezones was a challenge. Initially, I used a cron job to query the User DB every minute, but that caused a speed bump, slowing the bot down. As a workaround, I settled for a 9PM UTC reminder, lightening the load on the User DB.

2. The free tier of MongoDB Atlas limits us to only 10 connections at a time. Steered this bottleneck by implementing a RabbitMQ messaging queue to moderate the incoming connections.

3. Hosting the RabbitMQ server on the cloud and scaling the bot to handle multiple users was another hurdle due to pricing considerations.

### So what's next?

Going forward, I plan to:

1. Congratulate a user if they stay within their spending limit and suggest adding the surplus to savings.
2. Scale the bot to accommodate more users.
3. Display monthly expenses by category percentages.
4. (Optional) Add a bit of casualness by incorporating an AI chatbot for user interaction.

### Why the name "Artha Chakra" though?

I wanted my app to have an ***Indian*** touch. In Sanskrit, "Artha" refers to wealth or money, and "Chakra" means wheel or cycle. The name "Artha Chakra" represents the concept of a financial wheel or cycle of money.  Just as a wheel turns in a cycle, Artha Chakra aims to help users navigate their financial journey, make informed decisions, and effectively manage their resources.
 
So, that was my journey with 'Artha Chakra', folks! It was a path of learning, stumbling, overcoming, and growing. If you've come across with similar projects or have any questions or suggestions, feel free to DM me [@gsavitha_](https://twitter.com/gsavitha_). 

Wanna check out the code? here's the link to the repo:  [GitHub](https://github.com/g-savitha/ArthaChakra-telegram-bot)

I have also documented my journey on my Twitter while building it, do follow me [@gsavitha_](https://twitter.com/gsavitha_) for more updates. 

Until next time, happy coding and financial navigating!

---

If you found this helpful, please give a shoutout to [@gsavitha_](https://twitter.com/gsavitha_) and share this article to help others. For more articles like this, subscribe to my [Newsletter](https://www.getrevue.co/profile/gsavitha) and get the latest updates straight to your inbox.

