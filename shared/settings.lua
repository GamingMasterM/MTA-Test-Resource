
CLIENT = not triggerClientEvent
DEBUG = true
tblLoadedTests = {
  ["dx_animations"] = false,
  ["callback_functions"] = false,
  ["database"] = false,
  ["hatsystem"] = true
}

function isTestable(sCurrentTest)
  return tblLoadedTests[sCurrentTest]
end


if DEBUG then
  function _debug(sText)
    local sFuncName = tostring(debug.getinfo(2).name)
    local tblFileExt = split(debug.getinfo(2).source, '\\')
    local sLineNumber = tostring(debug.getinfo(2).currentline)
    local sClassName = tblFileExt[#tblFileExt]:gsub(".lua", "")

    if CLIENT then
      outputChatBox(("[%s:%s (%s)]#DDDDDD %s"):format(sClassName, sFuncName, sLineNumber, sText), 255, 0, 0, true)
    else
      outputChatBox(("[%s:%s (%s)]#DDDDDD %s"):format(sClassName, sFuncName, sLineNumber, sText), root, 255, 200, 0, true)
    end
  end
else
  function _debug() end
end

--[[

  Fahrzeuge
    Team
      TeamVehicle.lua
    Privat
      PrivatVehicle.lua
    Spezial
      SpezialVehicle.lua

    tank.lua
    kmstand.lua


]]
