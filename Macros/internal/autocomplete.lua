autocompleteTable = {}
 
for class_name,class in pairs(_G) do
    if type(class) == 'table' then
        for function_name,function in pairs(class) do
            if type(function) == 'function' then
                autocompleteTable[#autocompleteTable+1] = class_name .. '.' .. function_name
            end
        end
    end
end