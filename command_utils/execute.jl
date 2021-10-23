
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
