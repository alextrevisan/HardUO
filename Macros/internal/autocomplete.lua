autocompleteTable = {}
 
for class_name,class in pairs(_G) do
    if type(class) == 'table' then
        for function_name,f in pairs(class) do
            if (class_name == '_G' or class_name =='UO') then
                fill_autocomplete(function_name)
            end
        end
    end
end
for k,v in pairs(__autocompleteUO__) do fill_autocompleteUO(k) end