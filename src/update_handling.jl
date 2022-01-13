include("command_utils.jl")


function handle_update(token::String, message::Dict)::Nothing
    if haskey(message, "message")
        message = message["message"]
        message_text = message["text"]
        sender_id = message["chat"]["id"]

        command_name, command_params = parse_command(message_text)

        if sender_id != MASTER_ID
            send_message(token, sender_id, STRANGER_MESSAGE)
            return
        elseif command_name == ""
            return
        elseif command_name == "start"
            send_message(token, MASTER_ID, START_MESSAGE)
            return
        elseif command_name in COMMANDS
            send_message(token, MASTER_ID, "Got you, master!")
            message = execute_command(command_name, command_params)
        else
            message = "I do not know what to do, master. Your command \"$(command_name[1:end])\" confuses me." 
        end

        send_message(token, MASTER_ID, message)
    end
end