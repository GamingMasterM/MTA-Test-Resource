if isTestable("callback_functions") then


  local function bla(uCallback)
  --  setTimer(uCallback, 5000, 1, "okay")
  end

  bla(function(sText)
    outputChatBox(sText.." 1")
  end)

  bla(function(sText)
    outputChatBox(sText.." 2")
  end)


  -------------------------------------------


  local currentFiles = {}

  addEventHandler("onClientFileDownloadComplete", getRootElement(), function(sFileName, bSuccess)
    if currentFiles[sFileName] then
      if not bSuccess then
        outputConsole("downloading of file '"..sFileName.."' failed!")
      end
      currentFiles[sFileName]()
      currentFiles[sFileName] = nil
    end
  end)

  function download(sFile, uCallbackFunc)
    currentFiles[sFile] = uCallbackFunc
    downloadFile(sFile)
  end


  setTimer(function()


    download("res/txt/wichtig.txt", function()
      outputChatBox("fertig!")
    end)



  end, 1000, 1)

end
