--[[
TheNexusAvenger

Stores and replicates player data.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local PlayerData = ReplicatedStorageProject:GetResource("UI.PlayerData")

local PlayerDataService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
PlayerDataService:SetClassName("PlayerDataService")
PlayerDataService.PlayerData = {}
ServerScriptServiceProject:SetContextResource(PlayerDataService)



--[[
Initializes the data for a player.
--]]
function PlayerDataService:LoadPlayer(Player)
    --Create the player data folder.
    local PlayerDataFolder = Instance.new("Folder")
    PlayerDataFolder.Name = "PlayerData"
    PlayerDataFolder.Parent = Player
    
    --Initialize the player data.
    self.PlayerData[Player] = PlayerData.GetPlayerData(Player)
    self.PlayerData[Player]:InitializeFromSerializedData() --TODO: Fetch player data.
end

--[[
Clears a player.
--]]
function PlayerDataService:ClearPlayer(Player)
    --TODO: Flush player data.

    --Clear the resources.
    self.PlayerData[Player] = nil
end



return PlayerDataService