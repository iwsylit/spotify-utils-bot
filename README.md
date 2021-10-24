# spotify-utils-bot
Telegram bot for my [spotify-utils](https://github.com/iwsylit/spotify-utils).

## Requirements
**Julia** and her packages listed in `Project.toml`.

## Configuration
Create `.env` file in the repo directory with the following content:

```
TOKEN = bot<bot token>
MASTER_ID = <chat id>
API_URL = http://0.0.0.0:9876/
```

## Usage
Run the bot using `julia --project=. run.jl`. 

## Docker
To run the bot in Docker
1. Build the image `docker build -t spotify-utils-bot .`
2. Run it `docker run -t -i spotify-utils-bot`
