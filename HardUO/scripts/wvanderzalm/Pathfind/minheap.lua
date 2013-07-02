------------------------------------
-- Script Name: minheap.lua
-- Author: Wesley Vanderzalm
-- Version: 1.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestServer
-- Revision Date: 
-- Public Release: Feb 27 2011
-- Purpose: Contains a binary heap with the smallest value in the front. Used to store movement in an A* algorithm
------------------------------------
MinHeap=class()
function MinHeap:__init()
  self.count=0
  self.array={}
end
function MinHeap:BuildHead()
  for position=this.count,1,-1 do
    self:MinHeapify(position)
  end
end
function MinHeap:Add(item)--item breadcrumb   
  self.count=self.count+1
  table.insert(self.array,self.count,item)
  local position=self.count - 1  --  +-1 for non-zero orientation
  local parent = math.floor((position-1)/2) + 1
  position = position + 1
  while(position>1 and self.array[parent]:CompareTo(self.array[position])>0)do
    local temp=self.array[position]
    self.array[position]=self.array[parent]
    self.array[parent]=temp
    position=parent
    parent = math.floor((position-1)/2) + 1 
  end
end
function MinHeap:ExtractFirst()   
  if self.count == 0 then print("Heap is empty") return false end
  local temp = self.array[1]
  self.array[1] = self.array[self.count]
  self.count=self.count-1
  self:MinHeapify(1)   
  return temp
end
function MinHeap:Peek()      
  if self.count == 0 then print("Heap is empty") return false end
  return self.array[1]
end
function MinHeap:MinHeapify(position) --int 
  local minPosition = 1 --?
  while true do
    position = position - 1
    local parent = math.floor((position-1)/2) + 1
    local left = position*2 + 2          
    local right = position*2 + 3
    position = position + 1
    if left < self.count and self.array[left]:CompareTo(self.array[position]) < 0 then minPosition=left else minPosition=position end
    if right < self.count and self.array[right]:CompareTo(self.array[minPosition]) < 0 then minPosition=right end
    if minPosition ~= position then
      local mheap=self.array[position]
      self.array[position]=self.array[minPosition]
      self.array[minPosition] = mheap
      position=minPosition
    else
      return 
    end
  end
end