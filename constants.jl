using ConfigEnv; dotenv()


TOKEN = ENV["TOKEN"]
MASTER_ID = parse(Int, ENV["MASTER_ID"])
API_URL = ENV["API_URL"]

const COMMANDS = ["lucky", "move", "shuffle", "top_playlist", "fork", "merge", "group", "news"]

const START_MESSAGE = """
Hi! I am a spotify-utils bot made by iwsylit living at https://github.com/iwsylit/spotify-utils-bot.\n
I can:
    /lucky - create a playlist containing all your songs in random order
    /move - move n songs from the bottom to the top of a playlist
    /shuffle - shuffle songs in a playlist
    /top_playlist - create a playlist containing your top songs
    /fork - steal someone's playlist
    /merge - merge two playlists
    /group - group playlists
    /news - create a playlist containing all your songs ordered by date added
"""
const STRANGER_MESSAGE = """
I won't respond you in any way, you are not my master. 
If you want to become one, go to https://github.com/iwsylit/spotify-utils-bot and try to tame me.
One day my master will make me available for you, too, but I am not sure.
"""