--[[
TheNexusAvenger

Manages the inventory for a player.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local NexusEventCreator = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.Event.NexusEventCreator")
local PlayerData = ReplicatedStorageProject:GetResource("UI.PlayerData")

local Inventory = NexusObject:Extend()
Inventory:SetClassName("Inventory")



--[[
Creates a player data object.
--]]
function Inventory:__new(Player)
    self:InitializeSuper()

    --Store the state.
    self.PlayerData = PlayerData.GetPlayerData(Player)
    self.InventoryChanged = NexusEventCreator.CreateEvent()
    self.Inventory = self.PlayerData:GetValue("Inventory")
    self.CachedSlotResults = {}

    --Connect the inventory changing.
    self.PlayerData:GetValueChangedSignal("Inventory"):Connect(function()
        self.Inventory = self.PlayerData:GetValue("Inventory")
        self.CachedSlotResults = {}
        self.InventoryChanged:Fire(self.Inventory)
    end)
end

--[[
Returns the item at a given slot.
--]]
function Inventory:GetItem(Slot)
    Slot = tostring(Slot)
    return self.Inventory[Slot]
end

--[[
Returns the total amount of items
the inventory can store.
--]]
function Inventory:GetMaxItems()
    return 3 * 35 --TODO: Calculate the total amount of pages from the inventory expanders.
end

--[[
Returns the next open slot.
Returns nil if there is no empty slot.
--]]
function Inventory:GetNextOpenSlot()
    for i = 1,self:GetMaxItems() do
        if not self:GetItem(i) then
            return i
        end
    end
end

--[[
Returns the slots an item occupies.
The total amount of an item can be determined
by how many slots are used.
--]]
function Inventory:GetItemSlots(ItemName)
    --Create the cache entry.
    --Caching is done because of how often the map range
    --and page count is calculated.
    if not self.CachedSlotResults[ItemName] then
        --Determine the slots.
        local Slots = {}
        self.CachedSlotResults[ItemName] = Slots
        for Slot,ItemData in pairs(self.Inventory) do
            if ItemData.Name == ItemName then
                table.insert(Slots,Slot)
            end
        end
    end

    --Return the cached result.
    return self.CachedSlotResults[ItemName]
end

--[[
Saves the inventory.
--]]
function Inventory:Save()
    self.PlayerData:SetValue("Inventory",self.Inventory)
end

--[[
Adds an item to the inventory.
--]]
function Inventory:AddItem(Item)
    --Throw an error if there is no empty slot.
    local NextSlot = self:GetNextOpenSlot()
    if not NextSlot then
        error("Inventory doesn't have any open slots.")
    end

    --Add the item and save the inventory.
    self.Inventory[tostring(NextSlot)] = Item
    self:Save()
end

--[[
Swaps two slots in the inventory.
--]]
function Inventory:SwapSlots(Slot1,Slot2)
    --Swap the slots and save the inventory.
    Slot1,Slot2 = tostring(Slot1),tostring(Slot2)
    self.Inventory[Slot1],self.Inventory[Slot2] = self.Inventory[Slot2],self.Inventory[Slot1]
    self:Save()
end

--[[
Removes items at given slots.
--]]
function Inventory:RemoveSlots(Slots)
    --Remove the items and save the inventory.
    for _,Slot in pairs(Slots) do
        self.Inventory[tostring(Slot)] = nil
    end
    self:Save()
end

--[[
Removes an item at a given slot.
--]]
function Inventory:RemoveSlot(Slot)
    self:RemoveSlots({Slot})
end



return Inventory