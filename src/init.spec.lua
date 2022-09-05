return function()
	local RandomSelection = require(script.Parent)

	describe("RandomSelection.lua", function()
		describe("typechecking", function()
			it("should not accept non-number seeds", function()
				local badSeed = "hi"
				expect(function()
					RandomSelection.new(badSeed)
				end).to.throw()
			end)
			it("should allow no seed", function()
				local randomSelection = RandomSelection.new()
				expect(randomSelection).to.be.ok()
			end)
			it("should not accept non-table weight dictionary", function()
				local badDictionary = "hi"
				expect(function()
					assert(RandomSelection:_checkDictionary(badDictionary))
				end).to.throw()
			end)
			it("should not accept weight dictionary where all values are not numbers", function()
				local badDictionary1 = {
					value1 = 5;
					value2 = 55;
					value3 = "hello!";
				}
				local badDictionary2 = {
					894;
					"hi";
					29;
				}
				expect(function()
					assert(RandomSelection:_checkDictionary(badDictionary1))
				end).to.throw()
				expect(function()
					assert(RandomSelection:_checkDictionary(badDictionary2))
				end).to.throw()
			end)
			it("should not accept empty weight dictionary", function()
				expect(function()
					assert(RandomSelection:_checkDictionary({}))
				end).to.throw()
			end)
			it("should not accept non-number weight", function()
				local badWeight = "hi"
				expect(function()
					RandomSelection:_getRandomIndex(badWeight)
				end).to.throw()
			end)
			it("should not accept non-number index", function()
				local badIndex = "hi"
				local dictionary = {
					value1 = 5;
					value2 = 10;
					value3 = 15;
				}
				expect(function()
					RandomSelection:_getItemByWeightedIndex(dictionary, badIndex)
				end).to.throw()
			end)
		end)
		describe("_getTotalWeight", function()
			it("should return the total weight of a dictionary", function()
				local dictionary = {
					value1 = 5;
					value2 = 10;
					value3 = 15;
				}
				local total = 30;
				local result = RandomSelection:_getTotalWeight(dictionary)
				expect(result).to.equal(total)
			end)
			it("should return the total weight of an array", function()
				local array = { 5, 10, 15 }
				local total = 30
				local result = RandomSelection:_getTotalWeight(array)
				expect(result).to.equal(total)
			end)
		end)
		describe("_getRandomIndex", function()
			it("should be able to return a value less than 1", function()
				local max = 0.9999
				local result = RandomSelection:_getRandomIndex(max)
				expect(result < 1).to.equal(true)
			end)
		end)
		describe("_getItemByWeightedIndex", function()
			it("should never return an item with 0 weight", function()
				local array = { 0, 5 }
				local result = RandomSelection:_getItemByWeightedIndex(array, 0)
				expect(result).to.equal(2)
			end)
			it("should work with a value less than 1", function()
				local array = { 0.3, 0.6 }
				local result = RandomSelection:_getItemByWeightedIndex(array, 0.5)
				expect(result).to.equal(2)
			end)
			it("should always return an item with max weight", function()
				local array = { 0.25, 0.3, 0.45 }
				local result = RandomSelection:_getItemByWeightedIndex(array, 1)
				expect(result).to.equal(3)
			end)
		end)
		describe("getFromWeightedDictionary", function()
			it("should return a random item from a dictionary", function()
				local dictionary = {
					value1 = 5;
					value2 = 10;
					value3 = 15;
				}
				local result = RandomSelection:getFromWeightedDictionary(dictionary)
				expect(result).to.be.ok()
				expect(dictionary[result]).to.be.ok()
			end)
		end)
	end)
end