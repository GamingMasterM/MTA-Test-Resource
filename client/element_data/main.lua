if isTestable("element_data") then
    addCommandHandler("sch", function()
        setElementData(localPlayer, "Schluessel", math.random(-20000000, 20000000))
    end)
end
