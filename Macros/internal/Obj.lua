Obj = {}
Obj.isRunning = true
ObjList = {}
ObjProperties = {}
function Obj.OnClose(id)
    ObjList[id].OnClose()
    print("fechei id="..id)
end
function Obj.create(name)
    local id = __create__(name)
    print(id)
    local Form = {}
    function Form.Show()
        __show__(Form.id)
    end
    function Form.OnClose()
    end
    Form.id = id
    Form.mt = {
    __index = function (t,k)
        return _G[k]
    end,

    __newindex = function (t,k,v)
        _G[k] = v
        if k=="Caption" then
            __caption__(Form.id,v)
        end
    end,
    }
    setmetatable(Form, Form.mt)
    ObjList[id] = Form
    ObjList[id].OnClose = function() end
    return Form
end
function Obj.Loop()
    while Obj.isRunning do
        __objloop__()
        wait(1)
    end
end
function Obj.Free(form)
    print("Freeing ")
end
function Obj.Exit()
    Obj.isRunning = false
end
