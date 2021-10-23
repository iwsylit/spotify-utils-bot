using HTTP, JSON

include("../constants.jl")
include("telegram_api.jl")
include("../command_utils/parse.jl")
include("../command_utils/execute.jl")


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

                command_name = parse_command_name(message_text)
                command_params = parse_command_params(message_text)

                if sender_id != MASTER_ID
                    send_message(TOKEN, sender_id, STRANGER_MESSAGE)
                    continue
                elseif isnothing(command_name)
                    continue
                elseif command_name == "start"
                    send_message(TOKEN, MASTER_ID, START_MESSAGE)
                    continue
                elseif command_name in COMMANDS
                    send_message(TOKEN, MASTER_ID, "Got you, master!")
                    message = execute_command(command_name, command_params)
                else
                    message = "I do not know what to do, master. Your command \"$(command_name[1:end])\" confuses me." 
                end

                send_message(TOKEN, MASTER_ID, message)
            end
        end
    end
end
