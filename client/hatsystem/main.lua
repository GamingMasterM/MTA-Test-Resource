if isTestable("hatsystem") then

	addEventHandler("onClientResourceStart", resourceRoot, function()
		local txd = engineLoadTXD ( "res/mods/santahat.txd" )
		engineImportTXD ( txd, 1853 )
		local dff = engineLoadDFF ( "res/mods/santahat.dff" )
		engineReplaceModel ( dff, 1853 )
	end)

end
