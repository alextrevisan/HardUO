Point3D=class()
function Point3D:__init(X,Y,Z)
  if type(X)=="table" then
    self.X=X.X 
    self.Y=X.Y 
    self.Z=X.Z
  else
    self.X=X
    self.Y=Y
    self.Z=Z
  end
end                                                                               
Point3D.__eq = function(op1,op2) return op1.X==op2.X and op1.Y==op2.Y and op1.Z==op2.Z end
Point3D.__add = function(op1,op2) return Point3D(op1.X+op2.X,op1.Y+op2.Y,op1.Z+op2.Z) end
Point3D.__sub = function(op1,op2) return Point3D(op1.X-op2.X,op1.Y-op2.Y,op1.Z-op2.Z) end
Point3D.__eq = function(op1,op2) return op1.X==op2.X and op1.Y==op2.Y and math.abs(op1.Z-op2.Z)<=3 end
Point3D.__add = function(op1,op2) return Point3D(op1.X+op2.X,op1.Y+op2.Y,op1.Z+op2.Z) end
Point3D.__sub = function(op1,op2) return Point3D(op1.X-op2.X,op1.Y-op2.Y,op1.Z-op2.Z) end

function Point3D:GetDistanceSquared(point) dx = self.X - point.X dy = self.Y - point.Y return math.sqrt((dx * dx) + (dy * dy)) end   
function Point3D:tostring() return self.X..", "..self.Y..", "..self.Z end                    