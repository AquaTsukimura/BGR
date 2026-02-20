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
        win = mainElement
    }

    setmetatable(obj, { __index = GUIObjectPrototype })

    return obj
end
