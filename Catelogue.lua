local Economy = {
	Zones 		= require(script.Zones),
	Trees 		= require(script.Trees),
	Juicers 	= require(script.Juicers),
	Storages	= require(script.Storages),
	Fences		= require(script.Fences),
	ShopPacks	= require(script.ShopPacks)

}

local ByType = {}
local ByRarity = {}
local byId = {}
local Array = {}

local total = 0

for typeName, items in pairs(Economy) do
	for i,item in pairs(items) do
		
		local rarity = item.Rarity
		local id = item.Id
		item.Type 	= typeName
		
		item.Model 	= script:FindFirstChild(typeName):FindFirstChild(item.Id)
		
		if item.Price then
			if item.Price.Robux then
				item.Price.Robux = item.Price.Robux.Prod
			end
		end
		
		if item.Model then
			local XSize = item.Model:GetAttribute("SizeX") or 2
			local ZSize = item.Model:GetAttribute("SizeZ") or 2
			
			item.Cells = {XSize,ZSize}
		end
		
		total += 1


		byId[id] = item
		
		Array[typeName] = Array[typeName] or {}
		ByType[typeName] = ByType[typeName] or {}
		ByType[typeName][rarity] = ByType[typeName][rarity] or {}

		ByRarity[rarity] = ByRarity[rarity] or {}
		ByRarity[rarity][typeName] = ByRarity[rarity][typeName] or {}

		ByType[typeName][rarity][id] = item
		ByRarity[rarity][typeName][id] = item
		
		Array[typeName][i] = item
	end
end

Economy.Raw = Array
Economy.ById = byId
Economy.ByType = ByType
Economy.ByRarity = ByRarity
Economy.Total = total

return Economy
