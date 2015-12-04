if isTestable("dxGridlist") then
	local scx, scy = guiGetScreenSize()
	local px, py = scx/800, scy/600

	local iGridX, iGridY, iGridW, iGridH = 50*px, 50*py, 100*px, 300*py

	local iRows = 20
	local iVisibleRows = 10

	local function isCursorOverRectangle(x,y,w,h)
		if isCursorShowing() then
			local mx,my = getCursorPosition() -- relative
			cursorx,cursory = mx*scx,my*scy
			if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
				return true
			end
		end
	return false
	end

	local tblInput = {
		[1] = "dfihfjd",
		[2] = "ouhfdoj",
		[3] = "ouhfdoj",
		[4] = "ouhfdoj",
		[5] = "ouhfdoj"
	}

	local bClicked = false
	local iCurrentCell = 0

	addEventHandler("onClientRender", root, function()
		dxDrawRectangle(iGridX, iGridY, iGridW, iGridH, tocolor(0, 0, 0, 100))
		local iCellHeight = 30*py
		for i = iCurrentCell, iVisibleRows+iCurrentCell-1 do
			visibleI = i  - iCurrentCell
			local textColor = tocolor(255,255,255,255)
			dxDrawRectangle(iGridX+iGridW, iGridY+iGridH/iRows*iCurrentCell, 10, iGridH/iRows*iVisibleRows)
			if isCursorOverRectangle(iGridX, iGridY+iCellHeight*visibleI, iGridW, iCellHeight) then
				dxDrawRectangle(iGridX, iGridY+iCellHeight*visibleI, iGridW, iCellHeight, tocolor(255,255,255,255))
				textColor = tocolor(0,0,0,255)
				if getKeyState("mouse1") then
					dxDrawRectangle(iGridX, iGridY+iCellHeight*visibleI, iGridW, iCellHeight, tocolor(255,255,100,255))
					if bClicked == false then
						_debug(i)
						bClicked = i
					end
				else
					bClicked = false
				end
			end
			if visibleI ~= 0 then
				dxDrawLine(iGridX, iGridY+iCellHeight*visibleI, iGridX+iGridW, iGridY+iCellHeight*(visibleI), tocolor(0,0,0,100))
			end
			dxDrawText("Hallo_"..i, iGridX, iGridY+iCellHeight*visibleI, iGridX+iGridW, iGridY+iCellHeight*(visibleI+1), textColor, 1*px, "default", "center", "center")
		end
	end)
	bindKey("mouse_wheel_up", "down", function()
		if isCursorOverRectangle(iGridX, iGridY, iGridW, iGridH) then -- noch hinzugefügt, damit man ausserhalb der Gridlist nicht scrollen kann :)
			iCurrentCell = iCurrentCell - 1
			if iCurrentCell < 0 then iCurrentCell = 0 end
		end
	end)
	bindKey("mouse_wheel_down", "down", function()
		if isCursorOverRectangle(iGridX, iGridY, iGridW, iGridH) then
			iCurrentCell = iCurrentCell + 1
			if iCurrentCell > iRows-iVisibleRows then iCurrentCell = iRows-iVisibleRows end
		end
	end)
end
