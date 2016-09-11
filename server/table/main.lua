if isTestable("table") then

    local object = createObject(1337, 0, 3, 4)
    local tabelle = {
        ["Fach_1"] = createVehicle(411, 0, 0, 4),
        ["Fach_2"] = getPlayerFromName("MasterM"),
        [object] = 1337,
        ["Fach_4"] = {
            [1] = "Hallo",
            [2] = "ich",
            [3] = "bin",
            [4] = "MasterM",
            [5] = "der",
            [6] = "krasse",
            [7] = "Scripter",
        },
        ["Fach_5"] = {}
    }


    --[[outputChatBox(getVehicleName(tabelle["Fach_1"]))
    tabelle["Fach_1"] = nil
    outputChatBox(getVehicleName(tabelle["Fach_1"]))
    outputChatBox(tabelle[object])

    for fach_name, fach_wert in ipairs(tabelle["Fach_4"]) do
        outputChatBox(fach_name.." "..fach_wert)
    end

    for i = 1, 10 do
        tabelle["Fach_5"][i] = "Wert "..i
    end

    for fach_name, fach_wert in ipairs(tabelle["Fach_5"]) do
        outputChatBox(fach_name.." "..fach_wert)
    end]]


    function addVehicleToTable(uVeh)
        tabelle[uVeh] = {}
        tabelle[uVeh]["Besitzer"] = tabelle["Fach_2"]

        addEventHandler("onVehicleStartEnter", uVeh, function(uPlayer, iSeat)
            if iSeat == 0 then -- Fahrersitz
                if uPlayer == getVehicleData(uVeh, "Besitzer") then
                    outputChatBox("dein Fahrzeug", uPlayer)
                    cancelEvent(true)
                end
            end
        end)
    end

    function getVehicleData(uVeh, sData)
        return tabelle[uVeh] and tabelle[uVeh][sData]
    end

    function setVehicleData(uVeh, sData, value)
        if tabelle[uVeh] then
            tabelle[uVeh][sData] = value
        end
    end



    addVehicleToTable(tabelle["Fach_1"])
    addVehicleToTable(createVehicle(411, 0, 5, 4))
    addVehicleToTable(createVehicle(411, 0, 10, 4))
    addVehicleToTable(createVehicle(411, 0, 15, 4))
    setVehicleData(tabelle["Fach_1"], "Besitzer", tabelle["Fach_2"])

    outputChatBox(getPlayerName(getVehicleData(tabelle["Fach_1"], "Besitzer")))

end
