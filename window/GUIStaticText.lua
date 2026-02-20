GUIStaticText = {}
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

if not GUIWindow then
  return
end

GUIStaticText = setmetatable(GUIStaticText, { __newindex = GUIWindow })
HorizontalAlignment = {
  Left = "Left", 
  Center = "Center",
  Right = "Right"
}
VerticalAlignment = {
  Top = "Top",
  Center = "Center",
  Bottom = "Bottom"
}

function GUIStaticText:SetTextVertAlign(Align)
    self.win.TextYAlignment = Align
end

function GUIStaticText:SetTextHorzAlign(Align)
    self.win.TextXAlignment = Align
end

function GUIStaticText:SetText(text)
  self.win.Text = text
end
