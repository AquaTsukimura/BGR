 GUIManager = {}

local GUIType = {
    Button = 1,
    StaticText = 2,
    Layout = 3,
    DraggableButton = 4,
    StaticImage = 5,
    ProgressBar = 6,
    ScrollableLayout = 7
}

function GUIManager:createGUIWindow(type, name)
    local guiObject = Instance.new("ScreenGui")
    guiObject.Name = name or "GUIWindow"

    local mainElement

    if type == GUIType.Button then
        mainElement = Instance.new("TextButton")
        mainElement.Size = UDim2.new(0, 100, 0, 50)
        mainElement.Text = name
    elseif type == GUIType.StaticText then
        mainElement = Instance.new("TextLabel")
        mainElement.Size = UDim2.new(0, 200, 0, 50)
        mainElement.Text = name
    elseif type == GUIType.DraggableButton then
        mainElement = Instance.new("TextButton")
        mainElement.Size = UDim2.new(0, 100, 0, 50)
        mainElement.Text = name
    else
        mainElement = Instance.new("Frame")
        mainElement.Size = UDim2.new(0, 200, 0, 200)
        mainElement.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    end

    mainElement.Parent = guiObject

    local obj = {
        Gui = guiObject,
        Main = mainElement
    }

    function obj:SetDragStyle(enabled)
        if enabled then
            local dragging = false
            local dragInput, dragStart, startPos

            local function update(input)
                local delta = input.Position - dragStart
                self.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end

            self.Main.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStart = input.Position
                    startPos = self.Main.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            self.Main.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input)
                end
            end)
        end
        return self
    end

    return obj
end

