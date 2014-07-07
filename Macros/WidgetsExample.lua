function MyEventHandler()
  print("EVENT OCCURED!")
  Obj.Exit()                  --exit Loop command
end

form = Obj.create("TForm")
form.OnClose = MyEventHandler
form.Caption = "Test Window"
form.Show()
Obj.Loop()
Obj.Free(form)