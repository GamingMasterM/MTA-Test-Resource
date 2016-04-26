if isTestable("dx_moveable") then

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

    local sClicked = false

    local x, y, w, h = 100, 100, 200, 300
    local offx, offy
    local offw, offh



    local function process()
        local mx,my = getCursorPosition() -- relative
        cursorx,cursory = mx*scx,my*scy

        if sClicked == "mouse1" then
            x, y = cursorx-offx, cursory-offy
        elseif sClicked == "mouse2" then
            local dist = math.max((cursorx-x)*offh/offw, cursory-y)
            w, h = math.max(10/offh*offw, dist/offh*offw+1), math.max(10, dist+1)
            --w = w*h/offh
            --h = h2
        end
    end


    addEventHandler("onClientHUDRender", root, function()
        if sClicked == "mouse1" then
            dxDrawRectangle(x, y, w, h, tocolor(200, 200, 0))
        elseif sClicked == "mouse2" then
            dxDrawRectangle(x, y, w, h, tocolor(0, 200, 200))
        else
            dxDrawRectangle(x, y, w, h)
        end
        if isCursorOverRectangle(x, y, w, h) then
            local mx,my = getCursorPosition() -- relative
            cursorx,cursory = mx*scx,my*scy

            if getKeyState("mouse1") then
                if not sClicked then
                    sClicked = "mouse1"
                    offx, offy = cursorx-x, cursory-y
                    addEventHandler("onClientCursorMove", root, process)
                end
            elseif getKeyState("mouse2") then
                if not sClicked then
                    sClicked = "mouse2"
                    offx, offy = cursorx-x, cursory-y
                    offw, offh = w,h
                    addEventHandler("onClientCursorMove", root, process)
                end
            else
                if sClicked then
                    sClicked = false
                    removeEventHandler("onClientCursorMove", root, process)
                end
            end
        end
    end)

    bindKey("m", "both", function() showCursor(not isCursorShowing()) end)
end
