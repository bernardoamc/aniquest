# aniquest
Example APP using Oauth2 and Token Authentication for APIs

### To start your app

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

### Configure Oauth

You will need to supply the following environment variables so OAuth2 can work:

  * CLIENT_ID
  * CLIENT_SECRET
  * REDIRECT_URI

### Making a request to the API

`curl -H "Authorization: token your_token_here"http://localhost:4000/api/v1/animes`
