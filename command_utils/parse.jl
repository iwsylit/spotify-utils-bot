
function parse_command_name(command_text::String)::Union{String, Nothing}
    try
        return string(match(r"/([^@\s]+)", command_text)[1])
    catch
        return
    end
end


function parse_command_params(command_text::String)::Dict
    try
        params = match(r"\s(.*)$", command_text)[1] |>
            String |>
            split
        
        keys = map(
            p -> replace(p, r"[-—]" => "") |> lowercase, 
            params[1:2:end]
        )
        values = params[2:2:end]

        return Dict(zip(keys, values))
    catch
        return Dict()
    end
end
