---------------------------------------------------------------
-- Table.lua: Extra table functions for various uses
---------------------------------------------------------------
-- These table functions are used to perform special operations
-- that are not natively supported.  
---------------------------------------------------------------
-- Fix for WoW Classic 1.12.1 - properly define db
local db = ConsolePort
local tbl = {}
---------------------------------------------------------------
db.table = tbl
---------------------------------------------------------------
-- Copy: Recursive table duplicator, creates a deep copy
---------------------------------------------------------------
local function copy(src)
	local srcType, t = type(src)
	if srcType == "table" then
		t = {}
		for key, value in next, src, nil do
			t[copy(key)] = copy(value)
		end
		setmetatable(t, copy(getmetatable(src)))
	else
		t = src
	end
	return t
end
---------------------------------------------------------------
-- Flip: Flips the table associations. (only for unique values)
---------------------------------------------------------------
local function flip(src)
	local srcType, t = type(src)
	if srcType == "table" then
		t = {}
		for key, value in pairs(src) do
			if not t[value] then
				t[value] = key
			else
				return src
			end
		end
	end
	return t or src
end
---------------------------------------------------------------
-- Unravel: Unpacks associative keys/values for a given table
---------------------------------------------------------------
local function unravel(t, i)
	local k = next(t, i)
	if k ~= nil then
		return k, unravel(t, k)
	end
end

local function unravelv(t, i)
	local k, v = next(t, i)
	if k ~= nil then
		return v, unravelv(t, k)
	end
end
---------------------------------------------------------------
-- Compare: Recursive table comparator, checks if identical
---------------------------------------------------------------
local function compare(t1, t2)
	if t1 == t2 then
		return true
	elseif (t1 and not t2) or (t2 and not t1) then
		return false
	end
	if type(t1) ~= "table" then
		return false
	end
	local mt1, mt2 = getmetatable(t1), getmetatable(t2)
	if not compare(mt1,mt2) then
		return false
	end
	for k1, v1 in pairs(t1) do
		local v2 = t2[k1]
		if not compare(v1,v2) then
			return false
		end
	end
	for k2, v2 in pairs(t2) do
		local v1 = t1[k2]
		if not compare(v1,v2) then
			return false
		end
	end
	return true
end
---------------------------------------------------------------
-- spairs: Sort by non-numeric key, handy for string keys
---------------------------------------------------------------
local function spairs(t, order)
	local keys = {unravel(t)}
	if order then
		table.sort(keys, function(a,b) return order(t, a, b) end)
	else
		table.sort(keys)
	end
	local i, k = 0
	return function()
		i = i + 1
		k = keys[i]
		if k then
			return k, t[k]
		end
	end
end
---------------------------------------------------------------
-- count: Count the number of entries in a table (safe for WoW Classic 1.12.1)
---------------------------------------------------------------
local function count(t)
	if type(t) ~= "table" then
		print("ConsolePort: Warning - Attempted to count non-table value:", type(t), tostring(t))
		return 0
	end
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

---------------------------------------------------------------
local function mixin(object, mixin1, mixin2, mixin3, mixin4, mixin5)
	local scriptSupport = (type(object.HasScript) == 'function')
	local mixins = {mixin1, mixin2, mixin3, mixin4, mixin5}
	
	for i = 1, 5 do
		local mixin = mixins[i]
		if not mixin then break end

		for k, v in pairs(mixin) do
			if scriptSupport and object:HasScript(k) then
				if object:GetScript(k) then
					object:HookScript(k, v)
				else
					object:SetScript(k, v)
				end
			end
			object[k] = v
		end
	end

	return object
end

---------------------------------------------------------------
tbl.copy, tbl.flip, tbl.compare = copy, flip, compare
tbl.unravel, tbl.unravelv = unravel, unravelv
tbl.spairs, tbl.mixin = spairs, mixin
tbl.count = count