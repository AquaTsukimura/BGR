GUIWindow = {}

function vType(val)
  local func = nil
  local typeWork = true

  if type then
    func = type
    local test = func("")
    if test ~= "string" then
      print("[AQUA] type is not working.")
      typeWork = false
    end
  elseif typeof then
    func = typeof
    local test = func("")
    if test ~= "string" then
      print("[AQUA] typeof is not working.")
      typeWork = false
    end
  end

  if func and typeWork then
    local succ, result = pcall(func, val)
    if succ then
      return result
    else
      print("[AQUA] FAILED TO GET VALUE TYPE.")
    end
  end
end

function GUIWindow:SetDragStyle(enabled)
    if enabled then
        local dragging = false
        local dragInput, dragStart, startPos

        local function update(input)
            local delta = input.Position - dragStart
            self.win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                             startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        self.win.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = self.win.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        self.win.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)
    end
    return self
end

function GUIWindow:SetXPosition(pos)
    self.win.Position = UDim2.new(pos[1], pos[2], self.win.Position.Y.Scale, self.win.Position.Y.Offset)
    return self
end

function GUIWindow:SetYPosition(pos)
    self.win.Position = UDim2.new(self.win.Position.X.Scale, self.win.Position.X.Offset, pos[1], pos[2])
    return self
end

function GUIWindow:SetWidth(size)
    
    local currentSize = self.win.Size
    self.win.Size = UDim2.new(currentSize.X.Scale, size[2], currentSize.Y.Scale, currentSize.Y.Offset)
end
