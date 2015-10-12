--//
--||  PROJECT:  testing stuff and things
--||  AUTHOR:   MasterM
--||  DATE:     October 2015
--\\

--//
--||  static vars
--\\

lp = getLocalPlayer()
scx, scy = guiGetScreenSize()





--//
--||  getFPS by Krischkros
--\\

local fps_counter = 0
local fps = getFPSLimit()

addEventHandler("onClientResourceStart", resourceRoot, function()
	setTimer(calculate_fps, 1000, 0)
end)
addEventHandler("onClientRender", root, function()
	fps_counter = fps_counter + 1
end)
function calculate_fps()
	fps = fps_counter
	fps_counter = 0

end

function getFPS()
	return fps
end
