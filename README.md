# RandomSelection

A module for selecting a random item from a weighted list.

## API

The API consists of a single function that accepts a dictionary where each key is an item that corresponds to a numeric weight indicating its likelihood of being chosen. The function returns the item (key) of the random selection.

```lua
Variant getFromWeightedDictionary(Dictionary itemWeights)
```

## Usage

```lua
local RandomSelection = require(script.Parent.RandomSelection)

local itemWeights = {
	item1 = 1; -- will be selected 20% of the time
	item2 = 2; -- will be selected 40% of the time
	item3 = 2; -- will be selected 40% of the time
}

local selectedItem = RandomSelection:getFromWeightedDictionary(itemWeights)

print(selectedItem) -- "item1", "item2", or "item3"
```

## Weight Dictionary Formatting

The typical structure is a dictionary of item names and weights:
```lua
local itemWeights = {
	item1 = 5;
	item2 = 10;
	item3 = 15;
}
```

Any data type can be used, although **strings** are strongly recommended.

```lua
local items = script.Parent.ItemsFolder
local itemWeights = {
	[items.Item1] = 5;
	[items.Item2] = 10;
	[items.Item3] = 15;
}
local selectedItem = RandomSelection:getFromWeightedDictionary(itemWeights)
selectedItem:Clone()
```

```lua
local itemWeights = { 5, 10, 15 }
local selectedItem = RandomSelection:getFromWeightedDictionary(itemWeights)
print(itemWeights) -- 1, 2, or 3
```

Decimal weight values can be used.

```lua
local itemWeights = {
	item1 = 0.1;
	item2 = 0.6;
	item3 = 0.7;
}
```

Empty arrays will throw errors.

```lua
local itemWeights = {}
-- the following line will error:
RandomSelection:getFromWeightedDictionary(itemWeights)
```
