local function requireLua(mod)
  if mod and #mod > 0 then
    local loadFunc = (load ~= nil and load) or (loadstring ~= nil and loadstring)
    if loadFunc == nil then
      return
    end
    local loadLua = function(code)
      local succ, err = pcall(loadFunc, code, "=(@BGR)")
      if not succ then
        print(err)
        return nil, err
      end
    end
    local rootPath = "https://github.com/AquaTsukimura/BGR/blob/main/"
    local fullPath = rootPath .. tostring(mod)
    if game then
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
