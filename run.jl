using HTTP
using JSON

include("constants.jl")

include("src/telegram_api.jl")
include("src/update_handling.jl")


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
            @async handle_update(TOKEN, message)
        end

        sleep(1)
    end
end


run_bot()
