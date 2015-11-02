if isTestable("database") then

  uHandler = dbConnect("mysql", "dbname=tutorial;host=127.0.0.1", "root", "")
  if uHandler then
    _debug("MySQL-Verbindung erfolgreich")
  end


  function setVehicleSaveable(uVeh, iID)
    addEventHandler("onVehicleExit", uVeh, function(player, seat)
      if player and seat == 0 then
        local x,y,z = getElementPosition(uVeh)
        local spawn = toJSON({x,y,z})
        dbExec(uHandler, "UPDATE vehicles SET spawn = ? WHERE ID = ?;", spawn, iID)
      end
    end)
  end


  function destroyVehicleOnExplosion(uVeh, iID)
    addEventHandler("onVehicleExplode", uVeh, function()
      dbExec(uHandler, "DELETE FROM vehicles WHERE ID = ?;", iID)
      destroyElement(uVeh)
    end)
  end



  --dbExec(uHandler, "INSERT INTO vehicles (vehid, spawn) VALUES (?, ?);", 411, toJSON({0,15,4}))
  function doQuery()
  	local function queryCallback(query)
  		local result = dbPoll( query, 0 )
  		if result then
  			for _, row in pairs(result) do
  				outputChatBox(row["vehid"])
          local veh = createVehicle(tonumber(row["vehid"]), unpack(fromJSON(row["spawn"])))
          setVehicleSaveable(veh, row["ID"])
          destroyVehicleOnExplosion(veh, row["ID"])
  			end
  		end
  	end
  	dbQuery(queryCallback, uHandler, "SELECT * FROM vehicles;")
  end
  doQuery()

end




--[[

INSERT
("INSERT INTO <Tabellenname> (<Spalten>) VALUES (<Einträge mit ?>) ", <args>)


SELECT
("SELECT <Was? / *> FROM <Tabellenname> WHERE <Spalte = Wert mit ?>", <args>)


UPDATE
("UPDATE <Tabellenname> SET <Spalte = Wert mit ?> WHERE <Spalte = Wert mit ?>", <args>)


DELETE
("DELETE FROM <Tabellenname> WHERE <Spalte = Wert mit ?>", <args>)



uHandler = dbConnect("mysql", "dbname=tutorial;host=127.0.0.1", "root", "")
  if not uHandler then
    _debug("MySQL-Verbindung fehlgeschlagen!")
  end


  dbExec(uHandler, "INSERT INTO vehicles (vehid, spawn) VALUES (?, ?);", 411, toJSON({0,0,4}))
  --dbExec(uHandler, "ALTER TABLE vehicles AUTO_INCREMENT = 1;")
  --dbExec(uHandler, "TRUNCATE TABLE vehicles;")
  function doQuery()
  	local function queryCallback(query)
  		local result = dbPoll( query, 0 )
  		if result then
  			for _, row in pairs(result) do
  				outputChatBox(row["vehid"])
  			end
  		end
  	end
  	dbQuery(queryCallback, uHandler, "SELECT * FROM vehicles")
  end
  doQuery()











]]
