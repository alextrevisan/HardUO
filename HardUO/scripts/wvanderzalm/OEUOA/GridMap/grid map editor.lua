EditorMenu={}  
EditorMenu.Objects={}
EditorMenu.CreateObj=function(name,str,args) dostring(name..'=Obj.Create("'..str..'") table.insert(EditorMenu.Objects,{Pointer='..name..',Name="'..name..'",Type="'..str..'"})') if args then dostring(name.."._="..args) end end
EditorMenu.SetHints=function(bool) for i=1,#EditorMenu.Objects do EditorMenu.Objects[i].Pointer.ShowHint=bool end end       
EditorMenu.Free=function() for i=#EditorMenu.Objects,1,-1 do if EditorMenu.Objects[i].Pointer then Obj.Free(EditorMenu.Objects[i].Pointer) end end end
                        
EditorMenu.CreateObj("Editor_form",            "TForm",    "{FormStyle = 3,Caption = 'Grid Map Editor',Left=840, Width=600, Height=350, OnClose = function() Editor_View.Checked=false Editor_form.Hide() end} ")     
EditorMenu.CreateObj("NodeList",            "TListBox",    "{Width=180, Height=300, Parent = Editor_form,OnClick=function() local Index = NodePropList.ItemIndex NodePropListUpdate() NodePropList.ItemIndex=Index NodePropEditUpdate() end}")   
EditorMenu.CreateObj("NodePropList",            "TListBox",    "{Left=200, Top=0, Width=200, Height=200, Parent = Editor_form,OnClick=function() NodePropEdit.SetFocus() NodePropEdit.SelectAll() end}")   
EditorMenu.CreateObj("NodePropEdit",            "TEdit",    "{Left=400, Top=0, Width=200, Height=40, Parent = Editor_form, AutoSelect=true}")   

EditorMenu.CreateObj("Button_MoveUp",            "TButton",    [[{Left=180, Top=120, Width=20, Caption="ñ", Parent = Editor_form, OnClick=function() 
  if NodeList.ItemIndex ~= -1 and NodeList.ItemIndex ~= 0 then
    table.insert(Nodes,NodeList.ItemIndex,{Label=Nodes[NodeList.ItemIndex+1].Label,X=Nodes[NodeList.ItemIndex+1].X,Y=Nodes[NodeList.ItemIndex+1].Y,Z=Nodes[NodeList.ItemIndex+1].Z,Facet=Nodes[NodeList.ItemIndex+1].Facet,Action=Nodes[NodeList.ItemIndex+1].Action,Col=Nodes[NodeList.ItemIndex+1].Col, Scale=Nodes[NodeList.ItemIndex+1].Scale,Width=Nodes[NodeList.ItemIndex+1].Width}) 
    table.remove(Nodes,NodeList.ItemIndex+2) 
    local Index=NodeList.ItemIndex
    NodeListUpdate()                   
    NodeList.ItemIndex=Index-1
  end
  clrscr()              
  update=true
end}  ]])     
Button_MoveUp.Font._={Name="Wingdings", Size=14}
 
EditorMenu.CreateObj("Button_MoveDown",            "TButton",    [[{Left=180, Top=145, Width=20, Caption="ò", Parent = Editor_form, OnClick=function() 
  if NodeList.ItemIndex ~= -1 and NodeList.ItemIndex ~= table.getn(Nodes)-1 then
    table.insert(Nodes,NodeList.ItemIndex+3,{Label=Nodes[NodeList.ItemIndex+1].Label,X=Nodes[NodeList.ItemIndex+1].X,Y=Nodes[NodeList.ItemIndex+1].Y,Z=Nodes[NodeList.ItemIndex+1].Z,Facet=Nodes[NodeList.ItemIndex+1].Facet,Action=Nodes[NodeList.ItemIndex+1].Action,Col=Nodes[NodeList.ItemIndex+1].Col, Scale=Nodes[NodeList.ItemIndex+1].Scale,Width=Nodes[NodeList.ItemIndex+1].Width}) 
    table.remove(Nodes,NodeList.ItemIndex+1) 
    local Index=NodeList.ItemIndex
    NodeListUpdate()                   
    NodeList.ItemIndex=Index+1
  end
  clrscr() 
  update=true
end}]])     
Button_MoveDown.Font._={Name="Wingdings", Size=14} 

EditorMenu.CreateObj("Button_MoveNorth",            "TButton",    [[{Left=260, Top=210, Width=30, Caption="ì", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].Y=Nodes[NodeList.ItemIndex+1].Y-1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end }]])  
Button_MoveNorth.Font._={Name="Wingdings", Size=14}  
          
EditorMenu.CreateObj("Button_MoveEast",            "TButton",    [[{Left=260, Top=240, Width=30, Caption="î", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].X=Nodes[NodeList.ItemIndex+1].X+1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end}]]) 
Button_MoveEast.Font._={Name="Wingdings", Size=14}    

EditorMenu.CreateObj("Button_MoveHigher",            "TButton",    [[{Left=240, Top=210, Width=20, Caption="ñ", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].Z=Nodes[NodeList.ItemIndex+1].Z+1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end}  ]])   
Button_MoveHigher.Font._={Name="Wingdings", Size=14}                                         
          
EditorMenu.CreateObj("Button_MoveLower",            "TButton",    [[{Left=240, Top=240, Width=20, Caption="ò", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].Z=Nodes[NodeList.ItemIndex+1].Z-1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end}]])     
Button_MoveLower.Font._={Name="Wingdings", Size=14}
  
EditorMenu.CreateObj("Button_MoveSouth",            "TButton",    [[{Left=210, Top=240, Width=30, Caption="í", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].Y=Nodes[NodeList.ItemIndex+1].Y+1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end }]])                        
Button_MoveSouth.Font._={Name="Wingdings", Size=14}

EditorMenu.CreateObj("Button_MoveWest",            "TButton",    [[{Left=210, Top=210, Width=30, Caption="ë", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 then return false end
  Nodes[NodeList.ItemIndex+1].X=Nodes[NodeList.ItemIndex+1].X-1  
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index 
  clrscr() 
  update=true
end}]])    
Button_MoveWest.Font._={Name="Wingdings", Size=14}  
  
EditorMenu.CreateObj("Button_Save",            "TButton",    "{Left=400, Top=45, Caption='Save', Parent = Editor_form, OnClick=Nodes_Save}")      
EditorMenu.CreateObj("Button_SaveAs",            "TButton",    "{Left=480, Top=20, Caption='Save As', Parent = Editor_form, OnClick=Nodes_SaveAs}")      
EditorMenu.CreateObj("Button_Load",            "TButton",    "{Left=480, Top=45, Caption='Load', Parent = Editor_form, OnClick=Nodes_Load}")      
EditorMenu.CreateObj("Button_Add",            "TButton",    [[{Left=400, Top=75, Caption='Add Above', Parent = Editor_form, 
OnClick=function()
  if NodeList.ItemIndex ~= -1 then
    table.insert(Nodes,NodeList.ItemIndex+1,{Label="Untitled",X=UO.CharPosX,Y=UO.CharPosY,Z=UO.CharPosZ,Facet=UO.CursKind,Action="Null",Col=255, Scale=0, Width=1}) 
  else                                                                                  
    table.insert(Nodes,1,{Label="Untitled",X=UO.CharPosX,Y=UO.CharPosY,Z=UO.CharPosZ,Facet=UO.CursKind,Action="Null",Col=255, Scale=0, Width=1}) 
    NodeList.ItemIndex=0
  end
  local Index = NodeList.ItemIndex
  local Index2 = NodePropList.ItemIndex
  NodeListUpdate() 
  NodeList.ItemIndex=Index   
  NodePropListUpdate()   
  NodePropList.ItemIndex=Index2 
  update=true 
end} ]])      
EditorMenu.CreateObj("Button_Clone",            "TButton",    [[{Left=480, Top=75, Caption="Clone Node", Parent = Editor_form, 
OnClick=function() 
  if NodeList.ItemIndex ~= -1 then
    table.insert(Nodes,NodeList.ItemIndex+2,{Label=Nodes[NodeList.ItemIndex+1].Label,X=Nodes[NodeList.ItemIndex+1].X,Y=Nodes[NodeList.ItemIndex+1].Y,Z=Nodes[NodeList.ItemIndex+1].Z,Facet=Nodes[NodeList.ItemIndex+1].Facet,Action=Nodes[NodeList.ItemIndex+1].Action,Col=Nodes[NodeList.ItemIndex+1].Col, Scale=Nodes[NodeList.ItemIndex+1].Scale,Width=Nodes[NodeList.ItemIndex+1].Width}) 
    local Index=NodeList.ItemIndex  
    local Index2 = NodePropList.ItemIndex
    NodeListUpdate()                   
    NodeList.ItemIndex=Index+1  
    NodePropListUpdate()   
    NodePropList.ItemIndex=Index2 
  end
  update=true 
end}  ]])      
EditorMenu.CreateObj("Button_AddBelow",            "TButton",    [[{Left=400, Top=100, Caption="Add Below", Parent = Editor_form, 
OnClick=function()
  if NodeList.ItemIndex ~= -1 then
    table.insert(Nodes,NodeList.ItemIndex+2,{Label="Untitled",X=UO.CharPosX,Y=UO.CharPosY,Z=UO.CharPosZ,Facet=UO.CursKind,Action="Null",Col=255, Scale=0, Width=1}) 
  else                                                                                  
    table.insert(Nodes,1,{Label="Untitled",X=UO.CharPosX,Y=UO.CharPosY,Z=UO.CharPosZ,Facet=UO.CursKind,Action="Null",Col=255, Scale=0, Width=1})
    NodeList.ItemIndex=1 
  end
  local Index = NodeList.ItemIndex+2  
  local Index2 = NodePropList.ItemIndex
  NodeListUpdate() 
  NodeList.ItemIndex=Index-1
  NodePropListUpdate()   
  NodePropList.ItemIndex=Index2 
  update=true 
end}]])      
EditorMenu.CreateObj("Button_Delete",            "TButton",    [[{Left=400, Top=140, Caption="Delete Node", Parent = Editor_form, OnClick=function() 
  if #Nodes == 0 or NodeList.ItemIndex == -1 then return false end
  local Index = NodeList.ItemIndex
  table.remove(Nodes,NodeList.ItemIndex+1) 
  NodeListUpdate() 
  if #Nodes-1 < Index then
    NodeList.ItemIndex=#Nodes-1
  elseif #Nodes == 0 then
     NodeList.ItemIndex=-1
  else
    NodeList.ItemIndex=Index
  end
  clrscr() 
  update=true
end} ]])      
EditorMenu.CreateObj("Button_Apply",            "TButton",    [[{Left=400, Top=20, Caption="Apply", Parent = Editor_form, OnClick=function()
  if NodeList.ItemIndex ==-1 or NodePropList.ItemIndex ==-1 then return false end
  if VarName[NodePropList.ItemIndex+1] ~= "Action" and VarName[NodePropList.ItemIndex+1] ~= "Label" then
    Nodes[NodeList.ItemIndex+1][VarName[NodePropList.ItemIndex+1] ]=tonumber(NodePropEdit.Text)
  else                                                                                        
    Nodes[NodeList.ItemIndex+1][VarName[NodePropList.ItemIndex+1] ]=NodePropEdit.Text
  end
  local Index = NodeList.ItemIndex    
  local Index2 = NodePropList.ItemIndex   
  NodeListUpdate()  
  NodeList.ItemIndex=Index
  local Index = NodePropList.ItemIndex
  NodePropListUpdate() 
  NodePropList.ItemIndex=Index2
  clrscr() 
  update=true  
end} ]])                      
     
 