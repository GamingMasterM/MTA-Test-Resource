if isTestable("element_data") then


    tblAllowedKeysClient = {
        ["fps"] = true
    }
    tblAllowedResources = {
        ["t"] = true
    }

    function checkChange(dataName,oldValue)
        outputChatBox("----")
        outputChatBox("source: "..(getElementType(source) == "player" and getPlayerName(source) or tostring(source)) )
        outputChatBox("client: "..(client and getPlayerName(client) or "nein"))
        outputChatBox("sourceResource: "..(sourceResource and getResourceName(sourceResource) or "keine"))
        outputChatBox("oldValue: "..tostring(oldValue).." newValue: ".. tostring(getElementData(source, dataName)))
        if client then
            outputChatBox("ElementData vom Client")
            if not tblAllowedKeysClient[dataName] then
                setElementData(source, dataName, oldValue ) -- Set back the original value
            end
        end
        if sourceResource and sourceResource ~= getThisResource() then
            outputChatBox("ElementData von anderer Ressource")
            if not tblAllowedResources[getResourceName(sourceResource)] then
                setElementData(source, dataName, oldValue ) -- Set back the original value
            end
        end
    end
    addEventHandler("onElementDataChange", root, checkChange)


    local uPlayer = getPlayerFromName("MasterM")

    setElementData(uPlayer, "Schluessel", math.random(-20000000, 20000000))
    outputChatBox(getElementData(uPlayer, "Schluessel"))
end
