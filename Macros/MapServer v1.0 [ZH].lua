socket = require('socket')
local users_list = {}
local id = 1
--Funçoes
function enviarParaTodos(msg,ig)
   for i, users in pairs(users_list) do
        if i ~= ig and users ~= nil then
            users:send(msg..'\n') -- eu coloquei o \n concanetado no final
        end
   end
end
--
local data = socket.bind('*',7121)

function iniciar()
    while true do
        data:settimeout(0.01)
        local user = data:accept()
        if user then
            local ip = user:getpeername()
            print(ip..' entrou no chat id='..id)
            enviarParaTodos(ip..' entrou no chat\n')
            users_list[id] = user
            id = id+1
        end
        for i,user in pairs(users_list) do
            --print("user: "..i)
            if user ~= nil then
                user:settimeout(0.01)
                local msg,stat = user:receive()
                if stat == 'closed' then
                    local ip = user:getpeername()
                    enviarParaTodos('saiu:'..i,i)
                    users_list[i] = nil
                else
                    if msg ~= nil then
                        local ip = user:getpeername()
                        --print(ip..' enviou: '..msg)
                        enviarParaTodos(msg..":"..i,i)
                    end
                end
            end
        end
    end
end
iniciar()