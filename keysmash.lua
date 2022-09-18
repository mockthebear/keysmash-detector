function isKeySmash(text)
	text = text:lower()
	local common = "[asdfghjklç0-9]"
	local uncommon = "[zxcqwem,%.uio]"
	local laught = "[ahus]" --Ppl lught wih: shusauhashuhsuauhashusa
	local score = 0

	local keysSmashLetters = 0
	local vogals = '[aeiou]'

	if text:match("[%[%]%(%)%%0-9;!%?@\\|/]") then 
		return false, 0
	end

	local segmentVogals = 0
	local lastIsVogal = false
	local letterMap = {}
	local laughtLenght = 0
	for i=1, #text do 
		local let = text:sub(i,i)
		if not letterMap[let] then 
			letterMap[let] = 0
		end
		letterMap[let] = letterMap[let] +1
		if let:match(common) then 
			keysSmashLetters = keysSmashLetters +1
		end

		if let:match(laught) then 
			laughtLenght = laughtLenght + 1
		end

		if let:match(uncommon) then 
			keysSmashLetters = keysSmashLetters +0.3
		end
		if let:match(vogals) then 

			segmentVogals = segmentVogals -1
			if (lastIsVogal) then 
				segmentVogals = segmentVogals -1
			end
			lastIsVogal = true
		else 
			segmentVogals = segmentVogals +1
			if (lastIsVogal) then 
				segmentVogals = segmentVogals -1
			end
			lastIsVogal = false
		end
		
	end

	local treshhold = #text*(1 - 0.15)
	
	if text:match("http.+") or (laughtLenght >= treshhold) then
		return false, score, keysSmashLetters
	end
	
	local reason = ""

	--print(text, keysSmashLetters.."/"..(#text), segmentVogals, "Tresh: "..treshhold)
	local range = math.max((#text-math.max(1, treshhold)), 8)
	if keysSmashLetters > 8 and keysSmashLetters >= (#text-math.max(1, treshhold)) then
		score = score +1
	else
		reason = "not enoght score (<"..range..");"
		return false, reason, keysSmashLetters
	end
	if segmentVogals > 0 then
		score = score +1
	else 
		reason = reason .. "too many vowels (vowel score: "..segmentVogals..");"
	end

	local letter_score = 0

	for i,b in pairs(letterMap) do 
		if b >= 0.7 * #text then 
			score = score -1
			reason = reason .. "repeat "..i.." too many times ("..tostring(0.7 * #text)..");"
		end
	end

	if text:find("çã") or text:find("çõ") then 
		score = score - #text/2
		reason = reason .. "found çã and çõ;"
	end

	if score > 1 then 
		return true, reason.."ok", keysSmashLetters
	end
	return false, reason, keysSmashLetters
end

return {isKeySmash = isKeySmash}