local Llama = require(script.Parent.Llama)
local t = require(script.Parent.t)

local weightedDictionaryCheck = t.values(t.number)

local RandomSelection = {}
RandomSelection.__index = RandomSelection

function RandomSelection.new(seed)
	assert(t.optional(t.number)(seed))
	local self = setmetatable({
		_rng = if seed then Random.new(seed) else Random.new();
	}, RandomSelection)

	return self
end

function RandomSelection:getFromWeightedDictionary(itemWeights)
	assert(self:_checkDictionary(itemWeights))
	local totalWeight = self:_getTotalWeight(itemWeights)
	local randomIndex = self:_getRandomIndex(totalWeight)
	local selection = self:_getItemByWeightedIndex(itemWeights, randomIndex)
	return selection
end

function RandomSelection:_getTotalWeight(itemWeights)
	assert(self:_checkDictionary(itemWeights))
	local total = 0
	for _item, weight in itemWeights do
		total += weight
	end
	return total
end

function RandomSelection:_getRandomIndex(totalWeight)
	assert(t.number(totalWeight))
	return self._rng:NextNumber(0, totalWeight)
end

function RandomSelection:_getItemByWeightedIndex(itemWeights, randomIndex)
	assert(self:_checkDictionary(itemWeights))
	assert(t.number(randomIndex))
	local weightCount = 0
	for item, weight in itemWeights do
		weightCount += weight
		if weightCount >= randomIndex and weight > 0 then
			return item
		end
	end
end

function RandomSelection:_checkDictionary(dictionary)
	local result, response = weightedDictionaryCheck(dictionary)
	if Llama.isEmpty(dictionary) then
		result, response = false, "item weight dictionary cannot be empty"
	end
	return result, response
end

return RandomSelection.new()