----------------------------------------------------------------------------------------
--------------------Tree Upgrade Tiers Visualization functions--------------------------
----------------------------------------------------------------------------------------

local upgradeTree = {}


local tree_upgrade_node_height = 30
local tree_upgrade_node_width = 60

local buffer = 20
local tree_margin = 5

local tree_upgrade_tier1 = {
    {name = "unlock1", unlockStatus = true, dependency = "none", price = 1},
    {name = "unlock2", unlockStatus = false, dependency = "unlock1", price = 1},
    {name = "unlock3", unlockStatus = false, dependency = "unlock2", price = 1},
    {name = "unlock4", unlockStatus = false, dependency = "unlock3", price = 1},
    {name = "unlock5", unlockStatus = false, dependency = "unlock4", price = 1},
    {name = "unlock6", unlockStatus = false, dependency = "unlock5", price = 1},
    {name = "unlock7", unlockStatus = false, dependency = "unlock6", price = 1}
}

local tree_upgrade_tier2 = {
    --ugprade #1
    {name = "unlock1Speed1", unlockStatus = false, dependency = "unlock1", price = 1},
    {name = "unlock1Max1", unlockStatus = false, dependency = "unlock1", price = 1},
    {name = "unlock1gainX2", unlockStatus = false, dependency = "unlock1", price = 1},

    --ugprade #2
    {name = "unlock2Speed1", unlockStatus = false, dependency = "unlock2", price = 1},
    {name = "unlock2Max1", unlockStatus = false, dependency = "unlock2", price = 1},
    {name = "unlock2gainX2", unlockStatus = false, dependency = "unlock2", price = 1},

    --upgrade #3
    {name = "unlock3Speed1", unlockStatus = false, dependency = "unlock3", price = 1},
    {name = "unlock3Max1", unlockStatus = false, dependency = "unlock3", price = 1},
    {name = "unlock3gainX2", unlockStatus = false, dependency = "unlock3", price = 1},

    --upgrade #4
    {name = "unlock4Speed1", unlockStatus = false, dependency = "unlock4", price = 1},
    {name = "unlock4Max1", unlockStatus = false, dependency = "unlock4", price = 1},
    {name = "unlock4gainX2", unlockStatus = false, dependency = "unlock4", price = 1},

    --upgrade #5
    {name = "unlock5Speed1", unlockStatus = false, dependency = "unlock5", price = 1},
    {name = "unlock5Max1", unlockStatus = false, dependency = "unlock5", price = 1},
    {name = "unlock5gainX2", unlockStatus = false, dependency = "unlock5", price = 1},

    --upgrade #6
    {name = "unlock6Speed1", unlockStatus = false, dependency = "unlock6", price = 1},
    {name = "unlock6Max1", unlockStatus = false, dependency = "unlock6", price = 1},
    {name = "unlock6gainX2", unlockStatus = false, dependency = "unlock6", price = 1},

    --ugprade #7
    {name = "unlock7Speed1", unlockStatus = false, dependency = "unlock7", price = 1},
    {name = "unlock7Max1", unlockStatus = false, dependency = "unlock7", price = 1},
    {name = "unlock7gainX2", unlockStatus = false, dependency = "unlock7", price = 1}
}

local tree_upgrade_tier3 = {
    --upgrade #1
    {name = "unlock1Max2", unlockStatus = false, dependency = "unlock1Max1", price = 1},
    {name = "unlock1gainX3", unlockStatus = false, dependency = "unlock1", price = 1},

    --upgrade #2
    {name = "unlock2Max2", unlockStatus = false, dependency = "unlock2Max1", price = 1},
    {name = "unlock2gainX3", unlockStatus = false, dependency = "unlock2", price = 1},

    --upgrade #3
    {name = "unlock3Max2", unlockStatus = false, dependency = "unlock3Max1", price = 1},
    {name = "unlock3gainX3", unlockStatus = false, dependency = "unlock3", price = 1},

    --ugprade #4
    {name = "unlock4Max2", unlockStatus = false, dependency = "unlock4Max1", price = 1},
    {name = "unlock4gainX3", unlockStatus = false, dependency = "unlock4", price = 1},

    --upgrade #5
    {name = "unlock5Max2", unlockStatus = false, dependency = "unlock5Max1", price = 1},
    {name = "unlock5gainX3", unlockStatus = false, dependency = "unlock5", price = 1},

    --ugprade #6
    {name = "unlock6Max2", unlockStatus = false, dependency = "unlock6Max1", price = 1},
    {name = "unlock6gainX3", unlockStatus = false, dependency = "unlock6", price = 1},

    --ugprade #7
    {name = "unlock7Max2", unlockStatus = false, dependency = "unlock7Max1", price = 1},
    {name = "unlock7gainX3", unlockStatus = false, dependency = "unlock7", price = 1}
}

local tree_upgrade_tier4 = {
    --upgrade #1
    {name = "unlock1Max3", unlockStatus = false, dependency = "unlock1Max2", price = 1},
    
    --upgrade #2
    {name = "unlock2Max3", unlockStatus = false, dependency = "unlock2Max2", price = 1},

    --upgrade #3
    {name = "unlock3Max3", unlockStatus = false, dependency = "unlock3Max2", price = 1},
    
    --upgrade #4
    {name = "unlock4Max3", unlockStatus = false, dependency = "unlock4Max2", price = 1},
    
    --upgrade #5
    {name = "unlock5Max3", unlockStatus = false, dependency = "unlock5Max2", price = 1},
    
    --upgrade #6
    {name = "unlock6Max3", unlockStatus = false, dependency = "unlock6Max2", price = 1},
    
    --upgrade #7
    {name = "unlock7Max3", unlockStatus = false, dependency = "unlock7Max2", price = 1}
}

local tree_upgrade_final = {
    --endgame upgrade
    {name = "endgame", unlockStatus = false, dependency = "all" , price = 1}
}

local tree_upgrade_tiers = {
    tree_upgrade_tier1,
    tree_upgrade_tier2,
    tree_upgrade_tier3,
    tree_upgrade_tier4,
    tree_upgrade_final
}

function renderTier1(trimmedWindowWidth)
    local xTier1 = (trimmedWindowWidth*0.15) - tree_upgrade_node_width
    local yTier1 = buffer + (tree_margin*2) + tree_upgrade_node_height
    local offset1 = 0
    for _, upgrade in ipairs(tree_upgrade_tier1) do
        love.graphics.rectangle( "fill", xTier1, yTier1 + offset1, tree_upgrade_node_width, tree_upgrade_node_height )
        upgrade.x = xTier1
        upgrade.y = yTier1
        upgrade.width = tree_upgrade_node_width
        upgrade.height = tree_upgrade_node_height
        offset1 = offset1 + (tree_margin + tree_upgrade_node_height) * 3
    end
end

function renderTier2(trimmedWindowWidth)
    local xTier2 = (trimmedWindowWidth*0.3) - tree_upgrade_node_width
    local yTier2 = buffer + tree_margin
    local offset2 = 0
    for _, upgrade in ipairs(tree_upgrade_tier2) do
        love.graphics.rectangle( "fill", xTier2, yTier2 + offset2, tree_upgrade_node_width, tree_upgrade_node_height )
        upgrade.x = xTier2
        upgrade.y = yTier2
        upgrade.width = tree_upgrade_node_width
        upgrade.height = tree_upgrade_node_height
        offset2 =  offset2 + tree_margin + tree_upgrade_node_height 
    end
end

function renderTier3(trimmedWindowWidth)
    local xTier3 = (trimmedWindowWidth*0.45) - tree_upgrade_node_width
    local yTier3 = buffer + (tree_margin*2) + tree_upgrade_node_height
    local offset3 = 0
    local space_toggle = true
    for _, upgrade in ipairs(tree_upgrade_tier3) do
        love.graphics.rectangle( "fill", xTier3, yTier3 + offset3, tree_upgrade_node_width, tree_upgrade_node_height )
        upgrade.x = xTier3
        upgrade.y = yTier3
        upgrade.width = tree_upgrade_node_width
        upgrade.height = tree_upgrade_node_height
        if space_toggle then
            offset3 = offset3 + tree_margin + tree_upgrade_node_height
        end
        
        if not space_toggle then
            offset3 = offset3 + (tree_margin + tree_upgrade_node_height) * 2
        end
        space_toggle = not space_toggle
    end
end

function renderTier4(trimmedWindowWidth)
    local xTier4 = (trimmedWindowWidth*0.6) - tree_upgrade_node_width
    local yTier4 = buffer + (tree_margin*2) + tree_upgrade_node_height
    local offset4 = 0
    for _, upgrade in ipairs(tree_upgrade_tier4) do
        love.graphics.rectangle( "fill", xTier4, yTier4 + offset4, tree_upgrade_node_width, tree_upgrade_node_height )
        upgrade.x = xTier4
        upgrade.y = yTier4
        upgrade.width = tree_upgrade_node_width
        upgrade.height = tree_upgrade_node_height
        offset4 = offset4 + (tree_margin + tree_upgrade_node_height) * 3
    end
end

function renderTierFinal(trimmedWindowWidth, windowHeight)
    local xTier5 = (trimmedWindowWidth*0.85) - tree_upgrade_node_width
    local yTier5 = buffer + tree_margin + (tree_margin + tree_upgrade_node_height) * 10
    
    local finalUpgrade = tree_upgrade_final[1]

    love.graphics.rectangle( "fill", xTier5, yTier5, tree_upgrade_node_width, tree_upgrade_node_height )
    finalUpgrade.x = xTier5
    finalUpgrade.y = yTier5
    finalUpgrade.width = tree_upgrade_node_width
    finalUpgrade.height = tree_upgrade_node_height

    local font = love.graphics.getFont()
    local textWidth = font:getWidth(tostring(finalUpgrade.name))

    love.graphics.setColor(0,0,0)
    love.graphics.print(finalUpgrade.name, (trimmedWindowWidth*0.85) - tree_upgrade_node_width , windowHeight/2 - tree_upgrade_node_height, 0, 0.9, 0.9)
    love.graphics.setColor(1,1,1)
end

function upgradeTree.renderTree(trimmedWindowWidth)
    renderTier1(trimmedWindowWidth)
    renderTier2(trimmedWindowWidth)
    renderTier3(trimmedWindowWidth)
    renderTier4(trimmedWindowWidth)
    -- renderTierFinal()
end

return upgradeTree