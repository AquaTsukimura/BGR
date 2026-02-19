PlayerManager = {}
local Players = game:GetService("Players")
PlayerManager.clientPlayer = Players.LocalPlayer
PlayerManager.Players = {}

if not PlayerManager.clientPlayer then
    PlayerManager.clientPlayer = nil
    print("Player failed to get.")
end

function PlayerManager:getClientPlayer()
    return self.clientPlayer
end

function PlayerManager:getPlayers()
    self.Players = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= self.clientPlayer then
            local entityId = generateSeed()
            table.insert(self.Players, player)
        end
    end
    return self.Players
end

function PlayerManager:getPlayerByName(targetName)
  self.Players = self:getPlayers()
  for _, player in pairs(self.Players) do
    if player and player.Name == targetName then
      return player
    end
  end
end

function PlayerManager:getPlayerByIndex(index)
    self.Players = self:getPlayers()
    return self.Players and self.Players[index]
end

function PlayerManager:getPlayerCount()
    return #self.Players
end
