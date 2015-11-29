if isTestable("xmaslights") then

	local tblCache = {}
	local tblLights = {}
	addEvent("xmaslights:onClientRecieveLights", true)
	addEvent("xmaslights:onLightStateChange", true)


	local function updateLights()
		for element, v in pairs(tblCache) do
			if tblCache[element].markers then
				for marker, state in pairs(tblCache[element].markers) do
					local sState = tblCache[element].markers[marker]
					if isElement(marker) and sState == "add" then
						local iAlpha = getElementAlpha(marker)
						if iAlpha+7.5 >= 255 then
							setElementAlpha(marker, 255)
							tblCache[element].markers[marker] = "sub"
						else
							setElementAlpha(marker, iAlpha+7.5)
						end
					end
					if isElement(marker) and sState == "sub" then
						local iAlpha = getElementAlpha(marker)
						if iAlpha-7.5 <= 0 then
							setElementAlpha(marker, 0)
							tblCache[element].markers[marker] = "add"
						else
							setElementAlpha(marker, iAlpha-7.5)
						end
					end
				end
			end
		end
	end
	addEventHandler("onClientRender", root, updateLights)


	local function renderLight(uElement, bDim)
		if bDim and tblCache[uElement] then
			local iID  = getElementData(uElement, "iID")
			if tblLights[iID].state and not tblCache[uElement].markers then
				tblCache[uElement].markers = {}
				for i, v in pairs(tblLights[iID].light) do
					local iX, iY, iZ, iSize, iR, iG, iB = unpack(v)
					local marker = createMarker(iX, iY, iZ, "corona", iSize, iR, iG, iB, math.random(0,15)*15)
					tblCache[uElement].markers[marker] = "add"
				end
			end
		end
	end

	local function pauseLight(uElement, bDim)
		if bDim and tblCache[uElement] then
			local iID  = getElementData(uElement, "iID")
			if tblCache[uElement].markers then
				for marker,v in pairs(tblCache[uElement].markers) do
					if isElement(marker) then
						destroyElement(marker)
					end
					tblCache[uElement].markers[marker] = nil
				end
				tblCache[uElement].markers = nil
			end
		end
	end




	local uCol = createColSphere(0,0,0,100)
		attachElements(uCol, lp)
		addEventHandler("onClientColShapeHit", uCol, renderLight)
		addEventHandler("onClientColShapeLeave", uCol, pauseLight)


	addEventHandler("onClientResourceStart", resourceRoot, function()
		triggerServerEvent("xmaslights:onClientRequestLights", lp)
	end)
	setDevelopmentMode(true)

	addEventHandler("xmaslights:onLightStateChange", resourceRoot, function(iID, bEnabled)
		if isElementWithinColShape(tblLights[iID].uElement, uCol) then
			tblLights[iID].state = bEnabled
			if bEnabled then
				renderLight(tblLights[iID].uElement, true)
			else
				pauseLight(tblLights[iID].uElement, true)
			end
		end
	end)


	addEventHandler("xmaslights:onClientRecieveLights", resourceRoot, function(tblServerLights)
		tblLights = tblServerLights
		for i, v in pairs(tblLights) do
			local iX, iY, iZ = unpack(tblLights[i].render)
			local uElement = createObject(1337, iX, iY, iZ)
				setElementAlpha(uElement, 0)
				setElementData(uElement, "iID", i, false)
			tblCache[uElement] = {}
			tblLights[i].uElement = uElement
			if isElementWithinColShape(uElement, uCol) then
				renderLight(uElement, true)
			end
		end
	end)
end

	--[[
	bindKey("o", "down", function()
		local px,py,pz = getElementPosition(lp)
		outputChatBox("{"..px..", "..py..", "..pz..", 0.5, 200, 0, 0},")
		createMarker(px,py,pz, "cylinder", 0.2)
	end)
	]]
