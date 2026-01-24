--height of one upgrade section = 3*box height + 4*buffer + 2*largebuffer
----------------------------------------------------------------------------------------
--------------------Tree Upgrade Tiers Visualization functions--------------------------
----------------------------------------------------------------------------------------
local upgradeTree = {}

local tree_upgrade_node_height = 50
local tree_upgrade_node_width = 150

local tree_unlock1 = {
    unlock = {name = "Upgrade 1", unlockStatus = true, dependency = "none", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock1", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock1", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock1", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock1Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock1GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock1Max2", price = 1}
}

local tree_unlock2 = {
    unlock = {name = "Upgrade 2", unlockStatus = false, dependency = "unlock1", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock2", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock2", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock2", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock2Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock2GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock2Max2", price = 1}
}

local tree_unlock3 = {
    unlock = {name = "Upgrade 3", unlockStatus = false, dependency = "unlock2", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock3", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock3", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock3", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock3Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock3GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock3Max2", price = 1}
}

local tree_unlock4 = {
    unlock = {name = "Upgrade 4", unlockStatus = false, dependency = "unlock3", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock4", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock4", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock4", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock4Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock4GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock4Max2", price = 1}
}

local tree_unlock5 = {
    unlock = {name = "Upgrade 5", unlockStatus = false, dependency = "unlock4", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock5", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock5", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock5", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock5Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock5GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock5Max2", price = 1}
}

local tree_unlock6 = {
    unlock = {name = "Upgrade 6", unlockStatus = false, dependency = "unlock5", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock6", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock6", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock6", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock6Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock6GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock6Max2", price = 1}
}

local tree_unlock7 = {
    unlock = {name = "Upgrade 7", unlockStatus = false, dependency = "unlock6", price = 1},

    Speed1 = {name = "Speed Upgrade I", unlockStatus = false, dependency = "unlock7", price = 1},
    Max1 = {name = "Max Upgrade I", unlockStatus = false, dependency = "unlock7", price = 1},
    GainX2 = {name = "Gain 2x", unlockStatus = false, dependency = "unlock7", price = 1},

    Max2 = {name = "Max Upgrade II", unlockStatus = false, dependency = "unlock7Max1", price = 1},
    GainX3 = {name = "Gain 3x", unlockStatus = false, dependency = "unlock7GainX2", price = 1},

    Max3 = {name = "Max Upgrade III", unlockStatus = false, dependency = "unlock7Max2", price = 1}
}

local tree_unlock8 = {
    unlock = {unlockStatus = false, dependency = "all", price = 1}
}

local tree = {
    tree_unlock1 = tree_unlock1,
    tree_unlock2 = tree_unlock2,
    tree_unlock3 = tree_unlock3,
    tree_unlock4 = tree_unlock4,
    tree_unlock5 = tree_unlock5,
    tree_unlock6 = tree_unlock6,
    tree_unlock7 = tree_unlock7
    -- tree_unlock8 = tree_unlock8
}

function getUpgrade(requestedUpgrade)
    -- print(tree_upgrade)
    if requestedUpgrade == "none" then
        return {unlockStatus = true}

    elseif #requestedUpgrade == 7 then
        return tree["tree_" .. requestedUpgrade].unlock

    else
        local tier = "tree_" .. requestedUpgrade:sub(1,7)

        local wordLength = #requestedUpgrade

        local upgrade = requestedUpgrade:sub(8,wordLength)

        return tree[tier][upgrade]
    end
end

function printText(tree_tier, upgrade, divX, divY)
        love.graphics.setColor(0,0,0)
        love.graphics.print(tree_tier[upgrade].name, divX, divY)
        love.graphics.setColor(1,1,1)

        if not tree_tier[upgrade].unlockStatus then
            love.graphics.setColor(0,0,0)
            love.graphics.print(tree_tier[upgrade].price, divX, divY + 15)
            love.graphics.setColor(1,1,1)
        end
end


function updateTreeCoords(trimmedWindowWidth, scrollOffset, divY1, divY2, smallBuffer, tree_tier)
    local horiz_spacer = (trimmedWindowWidth - (4*tree_upgrade_node_width)) / 5
    local tierY = ((divY2 + divY1) / 2) - (tree_upgrade_node_height/2) - scrollOffset

    --unlockTierX
    tree_tier.unlock.x1 = horiz_spacer
    tree_tier.unlock.y1 = tierY
    tree_tier.unlock.x2 = horiz_spacer + tree_upgrade_node_width
    tree_tier.unlock.y2 = tierY + tree_upgrade_node_height

    --unlockTierX speed/max/gain
    tree_tier.Speed1.x1 = (2*horiz_spacer) + tree_upgrade_node_width
    tree_tier.Speed1.y1 = tierY - smallBuffer - tree_upgrade_node_height
    tree_tier.Speed1.x2 = (2*horiz_spacer) + (2*tree_upgrade_node_width)
    tree_tier.Speed1.y2 = tierY - smallBuffer

    tree_tier.Max1.x1 = (2*horiz_spacer) + tree_upgrade_node_width
    tree_tier.Max1.y1 = tierY
    tree_tier.Max1.x2 = (2*horiz_spacer) + (2*tree_upgrade_node_width)
    tree_tier.Max1.y2 = tierY + tree_upgrade_node_height

    tree_tier.GainX2.x1 = (2*horiz_spacer) + tree_upgrade_node_width
    tree_tier.GainX2.y1 = tierY + smallBuffer + tree_upgrade_node_height
    tree_tier.GainX2.x2 = (2*horiz_spacer) + (2*tree_upgrade_node_width)
    tree_tier.GainX2.y2 = tierY + smallBuffer + (2*tree_upgrade_node_height)

    --unlockTierX max/gain 2
    tree_tier.Max2.x1 = (3*horiz_spacer) + (2*tree_upgrade_node_width)
    tree_tier.Max2.y1 = tierY
    tree_tier.Max2.x2 = (3*horiz_spacer) + (3*tree_upgrade_node_width)
    tree_tier.Max2.y2 = tierY + tree_upgrade_node_height

    tree_tier.GainX3.x1 = (3*horiz_spacer) + (2*tree_upgrade_node_width)
    tree_tier.GainX3.y1 = tierY + smallBuffer + tree_upgrade_node_height
    tree_tier.GainX3.x2 = (3*horiz_spacer) + (3*tree_upgrade_node_width)
    tree_tier.GainX3.y2 = tierY + smallBuffer + (2*tree_upgrade_node_height)

    --unlockTierX max 3
    tree_tier.Max3.x1 = (4*horiz_spacer) + (3*tree_upgrade_node_width)
    tree_tier.Max3.y1 = tierY
    tree_tier.Max3.x2 = (4*horiz_spacer) + (4*tree_upgrade_node_width)
    tree_tier.Max3.y2 = tierY + tree_upgrade_node_height
end


function drawLine(node1, node2)
    if node1.dependency ~= "none" and node1.dependency ~= "all" then
        -- if getUpgrade(node2.dependency).unlockStatus then
            local x1 = (node1.x1 + node1.x2) / 2
            local y1 = (node1.y1 + node1.y2) / 2
            local x2 = (node2.x1 + node2.x2) / 2
            local y2 = (node2.y1 + node2.y2) / 2
            love.graphics.setColor(0,0,0)
            love.graphics.line(x1, y1, x2, y2)
            love.graphics.setColor(1,1,1)
        -- end
    end
end

function drawTreeConnections(tree_tier)
    --unlockTierX
    if getUpgrade(tree_tier.unlock.dependency).unlockStatus then
        drawLine(tree_tier.unlock, getUpgrade(tree_tier.unlock.dependency))
    end

    --unlockTierX speed/max/gain
    if getUpgrade(tree_tier.unlock.dependency).unlockStatus then
        drawLine(tree_tier.Speed1, getUpgrade(tree_tier.Speed1.dependency))
        drawLine(tree_tier.Max1, getUpgrade(tree_tier.Max1.dependency))
        drawLine(tree_tier.GainX2, getUpgrade(tree_tier.GainX2.dependency))
    end
    
    --unlockTierX max/gain 2
    if getUpgrade(tree_tier.Max2.dependency).unlockStatus then
        drawLine(tree_tier.Max2, getUpgrade(tree_tier.Max2.dependency))
    end
    
    if getUpgrade(tree_tier.GainX3.dependency).unlockStatus then
        drawLine(tree_tier.GainX3, getUpgrade(tree_tier.GainX3.dependency))
    end
    
    --unlockTierX max 3
    if getUpgrade(tree_tier.Max3.dependency).unlockStatus then
        drawLine(tree_tier.Max3, getUpgrade(tree_tier.Max3.dependency))
    end
end

function drawTierBoxes(trimmedWindowWidth, scrollOffset, divY1, divY2, smallBuffer, tree_tier)
    local horiz_spacer = (trimmedWindowWidth - (4*tree_upgrade_node_width)) / 5
    local tierY = ((divY2 + divY1) / 2) - (tree_upgrade_node_height/2) - scrollOffset

    --unlockTierX
    if getUpgrade(tree_tier.unlock.dependency).unlockStatus then
        drawLine(tree_tier.unlock, getUpgrade(tree_tier.unlock.dependency))
        love.graphics.rectangle("fill", horiz_spacer, tierY, tree_upgrade_node_width, tree_upgrade_node_height)
        printText(tree_tier, "unlock", horiz_spacer, tierY)
    end

    --unlockTierX speed/max/gain
    if getUpgrade(tree_tier.unlock.dependency).unlockStatus then
        love.graphics.rectangle("fill", (2*horiz_spacer) + tree_upgrade_node_width, tierY - smallBuffer - tree_upgrade_node_height, tree_upgrade_node_width, tree_upgrade_node_height)
        love.graphics.rectangle("fill", (2*horiz_spacer) + tree_upgrade_node_width, tierY, tree_upgrade_node_width, tree_upgrade_node_height)
        love.graphics.rectangle("fill", (2*horiz_spacer) + tree_upgrade_node_width, tierY + smallBuffer + tree_upgrade_node_height, tree_upgrade_node_width, tree_upgrade_node_height)

        printText(tree_tier, "Speed1", (2*horiz_spacer) + tree_upgrade_node_width, tierY - smallBuffer - tree_upgrade_node_height)
        printText(tree_tier, "Max1", (2*horiz_spacer) + tree_upgrade_node_width, tierY)
        printText(tree_tier, "GainX2", (2*horiz_spacer) + tree_upgrade_node_width, tierY + smallBuffer + tree_upgrade_node_height)
    end

    --unlockTierX max/gain 2
    if getUpgrade(tree_tier.Max2.dependency).unlockStatus then
        love.graphics.rectangle("fill", (3*horiz_spacer) + (2*tree_upgrade_node_width), tierY, tree_upgrade_node_width, tree_upgrade_node_height)
        printText(tree_tier, "Max2", (3*horiz_spacer) + (2*tree_upgrade_node_width), tierY)
    end
    
    if getUpgrade(tree_tier.GainX3.dependency).unlockStatus then
        love.graphics.rectangle("fill", (3*horiz_spacer) + (2*tree_upgrade_node_width), tierY + smallBuffer + tree_upgrade_node_height, tree_upgrade_node_width, tree_upgrade_node_height)
        printText(tree_tier, "GainX3", (3*horiz_spacer) + (2*tree_upgrade_node_width), tierY + smallBuffer + tree_upgrade_node_height)
    end
    
    --unlockTierX max 3
    if getUpgrade(tree_tier.Max3.dependency).unlockStatus then
        love.graphics.rectangle("fill", (4*horiz_spacer) + (3*tree_upgrade_node_width), tierY, tree_upgrade_node_width, tree_upgrade_node_height)
        printText(tree_tier, "Max3", (4*horiz_spacer) + (3*tree_upgrade_node_width), tierY)
    end

end

function upgradeTree.checkClick(mouseX, mouseY, total_money)
    for _, tier in pairs(tree) do
        for _, upgrade in pairs(tier) do
            if mouseX >= upgrade.x1 and mouseX <= upgrade.x2 and mouseY >= upgrade.y1 and mouseY <= upgrade.y2 then
                if not upgrade.unlockStatus and upgrade.price <= total_money then
                    upgrade.unlockStatus = true
                    total_money = total_money - upgrade.price
                    print(upgrade.name)
                end
            end
        end
    end
    return total_money
end

function upgradeTree.drawTree(trimmedWindowWidth, scrollOffset, windowHeight)
    local flipflop = true
    local largeBuffer = 35
    local smallBuffer = 25
    local offset = 0
    local treeBGY = windowHeight*0.06
    local treeBGHeight = 2*largeBuffer + 4*smallBuffer + 3*tree_upgrade_node_height
    
    for tier = 1, 8 do
        if flipflop then
            love.graphics.setColor(0.4,0.4,0.5)
            love.graphics.rectangle("fill", 0, treeBGY + offset - scrollOffset, trimmedWindowWidth, treeBGHeight)
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0.5,0.6,0.6)
            love.graphics.rectangle("fill", 0, treeBGY + offset - scrollOffset, trimmedWindowWidth, treeBGHeight)
            love.graphics.setColor(1,1,1)
        end

        if tier < 8 then
            local temp_tier = "tree_unlock" .. tostring(tier)
            updateTreeCoords(trimmedWindowWidth, scrollOffset, treeBGY + offset, treeBGY + treeBGHeight + offset, smallBuffer, tree[temp_tier])
            drawTreeConnections(tree[temp_tier])
            drawTierBoxes(trimmedWindowWidth, scrollOffset, treeBGY + offset, treeBGY + treeBGHeight + offset, smallBuffer, tree[temp_tier])
        end

        flipflop = not flipflop
        offset = offset + treeBGHeight
    end
end


return upgradeTree