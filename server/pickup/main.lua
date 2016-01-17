if isTestable("pickup") then
	local uPick = createPickup(2032, 1496, 11, 3, 1238, 1000)

	addEventHandler("onPickupUse", uPick, function(uPlayer)
		_debug("onPickupUse by "..getPlayerName(uPlayer))
		local rnd = math.random(0, 256)
		setElementModel(uPlayer, rnd)
	end)


	addCommandHandler("pick", function(uPlayer)
		usePickup(uPick,uPlayer)
	end)
end
