autocompleteTable = {}
 
for class_name,class in pairs(_G) do
    if type(class) == 'table' then
        for function_name,f in pairs(class) do
            if (class_name == '_G' or class_name =='UO') then
                autocompleteTable[#autocompleteTable+1] = function_name
            end
        end
    end
end

for i=1, #autocompleteTable do
    fill_autocomplete(autocompleteTable[i])
end