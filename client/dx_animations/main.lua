if isTestable("dx_animations") then
  setFPSLimit(60)
  local bActive = false
  local iX = 0
  local iFPS = 40


  local function render()
    local iEasing = getEasingValue(iX/scx,"InOutQuad")
    dxDrawText(getFPS(),scx/2, scy/2,scx/2, scy/2)
    dxDrawImage(0,0,iEasing*scx,scy/2,"res/img/logo_512.png")
    if iX >= scx then
      iX = scx
    else
      iX = iX + 10*iFPS/getFPS()
    end
  end

  local function toggle(bToggle)
    if bToggle and not bActive then
      addEventHandler("onClientRender", root, render)
      bActive = true
    elseif not bToggle and bActive then
      removeEventHandler("onClientRender", root, render)
      bActive = false
    end
  end

  toggle(true)
end
