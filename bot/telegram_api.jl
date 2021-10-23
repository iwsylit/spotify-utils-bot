
function send_message(token::String, id::Int, text::String)::Nothing
    text = text |> HTTP.URIs.escapeuri
    url = "https://api.telegram.org/$token/sendMessage"
    query = "chat_id=$id&text=$text"
    
    HTTP.request("GET", url; query=query)

    return
end


function get_updates(token::String, offset::Int = 0, timeout::Int = 10)::Array{Dict}
    url = "https://api.telegram.org/$token/getUpdates"
    query = "offset=$offset&timeout=$timeout"

    return HTTP.request("GET", url; query=query).body |> 
        String |>
        JSON.parse |>
        updates -> updates["result"]
end
