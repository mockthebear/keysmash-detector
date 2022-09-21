local _M = {}

local function count_segments(text)
	local laughtLenght = 0
	local lastIsVowel = false
	local repetitionMap = {}
	local keysSmashScore = 0
	local segmentVowels = 0

	local common = "[asdfghjklç0-9]"
	local uncommon = "[zxcqwem,%.uio]"
	local vogals = '[aeiou]'
	local laught = "[ahus]" --Ppl lught wih: shusauhashuhsuauhashusa

	for i=1, #text do 
		local let = text:sub(i,i)
		if not repetitionMap[let] then 
			repetitionMap[let] = 0
		end
		repetitionMap[let] = repetitionMap[let] +1
		if let:match(common) then 
			keysSmashScore = keysSmashScore +1
		end

		if let:match(laught) then 
			laughtLenght = laughtLenght + 1
		end

		if let:match(uncommon) then 
			keysSmashScore = keysSmashScore +0.3
		end
		if let:match(vogals) then 

			segmentVowels = segmentVowels -1
			if (lastIsVogal) then 
				segmentVowels = segmentVowels -1
			end
			lastIsVogal = true
		else 
			segmentVowels = segmentVowels +1
			if (lastIsVogal) then 
				segmentVowels = segmentVowels -1
			end
			lastIsVogal = false
		end
		
	end

	return laughtLenght, repetitionMap, segmentVowels, keysSmashScore
end

function _M.isKeySmash(text, minimumKeysmashCharacters, repetitionTreshHold)
	text = text:lower()
	
	minimumKeysmashCharacters = minimumKeysmashCharacters or 8
	repetitionTreshHold = repetitionTreshHold or 0.7

	if text:match("[%[%]%(%)%%0-9;!%?@\\|/]") then 
		return false, 0, "contains accentuation"
	end

	if text:match("http.+")  then
		return false, score, "it seems to be a http link"
	end

	if text:find("çã") or text:find("çõ") then 
		
		return false, 0, "found çã and çõ;"
	end

	local laughtLenght, repetitionMap, segmentVowels, keysSmashScore = count_segments(text)
	local treshhold = #text*(1 - 0.15)
	local range = math.max((#text-math.max(1, treshhold)), minimumKeysmashCharacters)

	if laughtLenght >= treshhold then 
		return false, keysSmashScore, "it seems to  be just a laught"
	end

	if not (keysSmashScore > minimumKeysmashCharacters and keysSmashScore >= (#text-math.max(1, treshhold))) then
		return false, keysSmashScore, "not enoght score (<"..range..");"
	end

	if segmentVowels <= 0 then
		return false, keysSmashScore, "too many vowels (vowel score: "..segmentVowels..");"
	end

	local limit = repetitionTreshHold * #text
	for letter, repetitions in pairs(repetitionMap) do 
		if repetitions >= limit then 
			return false, keysSmashScore, "letter "..letter.." repeat more than "..tostring(repetitionTreshHold * 100).."%);"
		end
	end

	return true, "ok", keysSmashScore
end

return _M
