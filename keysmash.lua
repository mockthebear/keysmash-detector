function isKeySmash(text)
	text = text:lower()
	local common = "[asdfghjklç]"
	local uncommon = "[zxcqwem,%.uio]"
	local laught = "[ahus]" --Ppl lught wih: shusauhashuhsuauhashusa
	local score = 0

	local keysSmashLetters = 0
	local vogals = '[a]'

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
		return
	end
	

	--print(text, keysSmashLetters.."/"..(#text), segmentVogals, "Tresh: "..treshhold)
	if keysSmashLetters > 8 and keysSmashLetters >= (#text-math.max(1, treshhold)) then
		score = score +1
	end
	if segmentVogals > 0 then
		score = score +1
	end

	for i,b in pairs(letterMap) do 
		if b >= 0.7 * #text then 
			score = score -1
		end
	end

	if score > 1 then 
		return true
	end
	return false
end


local gcoldown = {}
local function popfurOnTalk(msg)
	gcoldown[msg.chat.id] = gcoldown[msg.chat.id] or 0
	if gcoldown[msg.chat.id] < os.time() then
		--print("nocoldown", msg.chat.id)
		if msg.text then
			local txt = msg.text .." "
			for word in txt:gmatch("(.-)%s") do
				if isKeySmash(word) then 
					gcoldown[msg.chat.id] = os.time() + 4
					--bot.sendMessage(msg.chat.id, "ba")
	       			bot.sendSticker(msg.chat.id, "CAACAgEAAx0CTJmDiwACJSZfNYoBzJoz_yLy2p3hDskjx_sxsAACGgADkGVrM5x-IZx71rIEGgQ", false, msg.message_id)
	       			return
				end
			end
			
	    end
	end
end



if StoreChatScript then
	StoreChatScript(popfurOnTalk)
end
