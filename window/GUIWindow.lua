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
end

function GUIWindow:SetYPosition(pos)
    self.win.Position = UDim2.new(self.win.Position.X.Scale, self.win.Position.X.Offset, pos[1], pos[2])
end

function GUIWindow:SetWidth(size)
    if vType(size) ~= 'table' then
        print('[AQUA] BAD ARGS TO GUIWindow::SetWidth, size is not a table!')
        return
    end

    if #size < 2 then
        print('[AQUA] BAD ARGS TO GUIWindow::SetWidth, size requires a statement like GUIWindow::SetWidth({1, -50})')
        return
    end

    local scale = size[1]
    local offset = size[2]

    if type(scale) ~= 'number' or type(offset) ~= 'number' then
        print('[AQUA] BAD ARGS: scale and offset should be numbers.')
        return
    end

    local currentSize = self.win.Size
    if not currentSize or type(currentSize) ~= 'userdata' then
        print('[AQUA] Invalid current size.')
        return
    end

    self.win.Size = UDim2.new(scale, offset, currentSize.Y.Scale, currentSize.Y.Offset)
end

function GUIWindow:SetHeight(size)
    if vType(size) ~= 'table' then
        print('[AQUA] BAD ARGS TO GUIWindow::SetHeight, size is not a table!')
        return
    end

    if #size < 2 then
        print('[AQUA] BAD ARGS TO GUIWindow::SetHeight, size requires a statement like GUIWindow::SetHeight({1, -50})')
        return
    end

    local scale = size[1]
    local offset = size[2]

    if type(scale) ~= 'number' or type(offset) ~= 'number' then
        print('[AQUA] BAD ARGS: scale and offset should be numbers.')
        return
    end

    local currentSize = self.win.Size
    if not currentSize or type(currentSize) ~= 'userdata' then
        print('[AQUA] Invalid current size.')
        return
    end

    self.win.Size = UDim2.new(currentSize.X.Scale, currentSize.X.Offset, scale, offset)
end
