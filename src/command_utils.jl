
function parse_command(command_text::String)::Tuple{String, Dict{String, String}}
    command_name = try string(match(r"/([^@\s]+)", command_text)[1]) catch; "" end
    params = try match(r"\s(.*)$", command_text)[1] |> String |> split catch; "" end

    keys = map(
        p -> replace(p, r"[-—]" => "") |> lowercase, 
        params[1:2:end]
    )
    values = params[2:2:end]

    command_params = Dict{String, String}(zip(keys, values))

    return command_name, command_params
end


function execute_command(command_name::String, command_params::Dict)::String
    try
        return HTTP.request("POST", API_URL * command_name; query = command_params).body |>
            String |>
            JSON.parse |>
            response -> response["message"]
    catch
        return "Something is wrong with the params or the API is unavailable, master."
    end
end


