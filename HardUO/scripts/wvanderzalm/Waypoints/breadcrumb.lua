BreadCrumb=class()
function BreadCrumb:__init(position) 
  self.f_score = 2147483647 --Int32.MaxValue
  self.g_score = 2147483647
  self.h_score = 2147483647
  self.dir=-1
  self.onClosedList = false
  self.onOpenList = false
  self.position={}--Point3Dw(position[1],position[2],position[3])
end

BreadCrumb.__eq = function(op1,op2)
   return op1.position==op2.position
end
function BreadCrumb:CompareTo(other) --other breadcrumb                               
    --if (self.h_score>other.h_score) then return 1 elseif (self.h_score<other.h_score) then return -1 else return 0 end -- First best                                                                                            
    if (self.f_score>other.f_score) then return 1 elseif (self.f_score<other.f_score) then return -1 else return 0 end --Old A*
end