if isTestable("hatsystem") then

	local hats = {}
	local standardPos  = {-0.03,0.03,0.15,0,0,90}
	local hatPos = {
		[294] = {-0.02, 0.03,0.15,0,0,90},
		[0] = {-0.03,0.03,0.15,0,0,-90},
	}


	startResource(getResourceFromName("bone_attach"))

	local function addHat(player)
		if not player then player = source end
		hats[player] = createObject(1853, 0, 0, 0)
			setObjectScale(hats[player], 0.8)

		local pos = standardPos
		if hatPos[getElementModel(player)] then
			pos = hatPos[getElementModel(player)]
		end
		exports.bone_attach:attachElementToBone(hats[player],player,1,unpack(pos))
	end

	local function removeHat(player)
		if type(player) == "string" then player = source end
		if hats[player] then
			if isElement(hats[player]) then
				destroyElement(hats[player])
			end
			hats[player] = nil
		end
	end


	for i, player in pairs(getElementsByType("player")) do
		addHat(player)
	end

	addEventHandler("onPlayerJoin", root, addHat)
	addEventHandler("onPlayerQuit", root, removeHat)


	addCommandHandler("hat", function(player)
		if hats[player] then
			removeHat(player)
		else
			addHat(player)
		end

	end)



end
