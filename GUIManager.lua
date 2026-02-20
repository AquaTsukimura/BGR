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

local function requireLua(mod)
  if mod and #mod > 0 then
    local loadFunc = (load ~= nil and load) or (loadstring ~= nil and loadstring)
    if loadFunc == nil then
      return
    end
    local loadLua = function(code)
      local succ, err = loadFunc(code, "=(@BGR)")
      if succ then
        local success, error = pcall(succ)
        if success then
          print("[AQUA] No runtime errors occured.")
        else
          print("[AQUA] Runtime error: ", error)
        end
      else
        print(err)
      end
    end
    local rootPath = "https://github.com/AquaTsukimura/BGR/blob/main/"
    local fullPath = rootPath .. tostring(mod)
    if game then
      if not game.HttpGet then
        print("[AQUA : SCRIPT_EXCEPTION] game.HttpGet not exist!")
        return
      end
      local succ, datOrErr = pcall(game.HttpGet, game, fullPath)
      if succ then
        loadLua(datOrErr)
        return "Success."
      else
        print(datOrErr)
        return datOrErr
      end
    end
  end
end

requireLua("ui/GUIWindow.lua")
requireLua("ui/GUIStaticText.lua")


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

    local Valyeka = GUIWindow
    if type == GUIType.StaticText then
     Valyeka = GUIStaticText
    end
    if not Valyeka then
     return
    end
    setmetatable(obj, { __index = Valyeka })

    return obj
end
