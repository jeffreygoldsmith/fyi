# FYI

## Motivation & Explanation

Using this article on [Etsy's experimentation with immutable documentation](https://codeascraft.com/2018/10/10/etsys-experiment-with-immutable-documentation/) as heavy inspiration, this FYI slackbot is meant as an implementation to what is described in the article.

**As a tl;dr, FYI is a bot which enables channel-local immutable documentation in Slack.**

As a caveat, this bot does provide a way to delete documentation. This functionality is not meant to be used to remove old documentation, it is simply meant as a safeguard against mistakenly marking something as documentation through reacting to a message with the _fyi_ emoji.

## Application Configuration

This project is meant to be a base implementation which can be used as a stepping stone to be deployed and integrated into different company infrastructures.

### Storage

The `QueryDocumentationResponse` class, responsible for grabbing responses for a query and returning them in a formatted list to the user, searches via a naive `"documentation_text LIKE <query>"`. In a production environment, this may not be optimal depending on the usecase.

### Secrets

In order to communicate with Slack, this bot stores its secrets via [ejson](https://github.com/Shopify/ejson).

## Slack Configuration

### Secrets

There are a few secrets the this application needs to know about in order to function.

This application uses [`ejson`](https://github.com/Shopify/ejson) in combination with [`ejson-rails`](https://github.com/Shopify/ejson-rails) to inject secrets.

To configure the application's required secrets, create `config/secrets.json` (or `config/{{environment}}.secrets.json`) and place the following information inside it:
```json
{
  "slack": {
    "bot_token": "{{YOUR_BOT_TOKEN}}",
    "signing_secret": "{{YOUR_SIGNING_SECRET}}"
  }
}
```

The `bot_token` can be found in the `OAuth & Permissions` tab once the app is installed to a workspace.

The `signing_secret` can be found in the `Basic Information` tab.

### OAuth & Permissions

The following `Bot Token Scopes` must be enabled on your FYI slack bot app:
- `channels:history` to allow FYI to view channel messages
- `channels:read` to allow FYI to get basic information about channels
- `chat:write` to allow FYI to write messages to a channel
- `reactions:read` to allow FYI to see when someone reacts to a message
- `reactions:write` to allow FYI to react to a message
- `users:read` to allow FYI to see what user is writing a given message

### Event Subscriptions

In order to allow the slack app to subscribe to events at all, we must configure the webhook URL.
This URL should be set to the `/api/remote_events/slack` endpoint.

This bot must subscribe to the following events:
- `message.channels` to allow FYI to be notified when a user posts a message in a channel
- `reaction_added` to allow FYI to be notified when a user reacts to a message in a channel
- `reaction_removed` to allow FYI to be notified when a user removes a reaction to a message in a channel

### Emojis

The FYI bot uses three emojis to do its work: the `:fyi:` emoji, the `:fyi-saved:` emoji, and the `:fyi-error:` emoji.
These two emojis should be created in the workspace which this bot is installed to.

The names of these emojis can be configured in the `application.rb` file.

Default assets to create these emojis can be found in `/assets`.