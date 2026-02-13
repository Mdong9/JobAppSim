----------------------------------------------------------------------------------------
----------------------------Exit Game Logic---------------------------------------------
----------------------------------------------------------------------------------------

local exit = {}

exit.coords = {}

function exit.drawExit(bgX, bgWidth, windowHeight, upgradeBoxHeight)
    --test exit box
    love.graphics.rectangle(
        "fill",
        bgX + bgWidth*0.2,
        windowHeight - 75,
        bgWidth*0.6,
        upgradeBoxHeight
    )
    exit.coords = {
        exitX1 = bgX + bgWidth*0.2,
        exitX2 = bgX + bgWidth*0.2 + bgWidth*0.6,
        exitY1 = windowHeight - 75,
        exitY2 = windowHeight - 75 + upgradeBoxHeight
    }
    
    love.graphics.print("EXIT")
end


function exit.exitCheck(mouseX, mouseY, exitX1, exitY1, exitX2, exitY2)
    if mouseX >= exitX1 and mouseX <= exitX2 and mouseY >= exitY1 and mouseY <= exitY2 then
        love.event.quit(0)
    end
end

return exit