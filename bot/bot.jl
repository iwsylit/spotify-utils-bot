using HTTP, JSON
using ConfigEnv; dotenv()

include("telegram_api.jl")
include("../command_utils/parse.jl")
include("../command_utils/execute.jl")


TOKEN = ENV["TOKEN"]
MASTER_ID = parse(Int, ENV["MASTER_ID"])
API_URL = ENV["API_URL"]
const COMMANDS = ["lucky", "move", "shuffle", "top_playlist", "fork", "merge", "group", "news"]


function run_bot()
    offset = 0

    while true
        updates = get_updates(TOKEN, offset)

        if length(updates) == 0
            continue
        else
            offset = maximum([u["update_id"] for u in updates]) + 1
        end

        for message in updates
            if haskey(message, "message")
                message = message["message"]
                message_text = message["text"]
                sender_id = message["chat"]["id"]

                if sender_id != MASTER_ID
                    send_message(
                        TOKEN, sender_id, 
                        "I won't respond you in any way, you are not my master. If you want to become one, go to https://github.com/iwsylit/spotify-utils-bot and tame me."
                        )
                    
                    continue
                end

                command_name = parse_command_name(message_text)
                command_params = parse_command_params(message_text)

                if isnothing(command_name)
                    continue
                end 

                if command_name in COMMANDS
                    send_message(TOKEN, MASTER_ID, "Got you, master!")
                    message = execute_command(command_name, command_params)
                else
                    message = "I do not know what to do, master. Your command \"$(command_name[1:end])\" looks weird." 
                end

                send_message(TOKEN, MASTER_ID, message)
            end
        end
    end
end
