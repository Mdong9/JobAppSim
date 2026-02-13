local upgradeTree = require("upgradeTree")
local upgrades = {}

local upgradeBox

local font = love.graphics.getFont()
----------------------------------------------------------------------------------------
----------------------------Render Upgrades Main Screen---------------------------------
----------------------------------------------------------------------------------------
local upgrade_info = {}
local upgrade_base = {
    {
        name = "Stamp",
        description = "placeholder",
        unlock = true,
        base_price = 5,
        maxQuantity = 10,
        rate = 1
    },

    {
        name = "Autoclicker",
        description = "placeholder",
        unlock = false,
        base_price = 100,
        maxQuantity = 10,
        rate = 5
    },

    {
        name = "Autofill",
        description = "placeholder",
        unlock = false,
        base_price = 1000,
        maxQuantity = 10,
        rate = 50
    },

    {
        name = "JobGPT",
        description = "placeholder",
        unlock = false,
        base_price = 10000,
        maxQuantity = 10,
        rate = 250
    },

    {
        name = "Clones",
        description = "placeholder",
        unlock = false,
        base_price = 151001,
        maxQuantity = 10,
        rate = 1000
    },

    {
        name = "Time Machine",
        description = "placeholder",
        unlock = false,
        base_price = 101010101,
        maxQuantity = 10,
        rate = 100000
    },

    {
        name = "Multiverse",
        description = "placeholder",
        unlock = false,
        base_price = 7777777777,
        maxQuantity = 10,
        rate = 1000000
    }
}

function upgrades.initializeUpgradeValues(upgradeBoxWidth, upgradeBoxHeight)
    for x, upgrade in ipairs(upgrade_base) do
        upgrade.width = upgradeBoxWidth
        upgrade.height = upgradeBoxHeight
        upgrade.price = upgrade.base_price
        upgrade.boughtQuantity = 0
        upgrade.x1 = -1
        upgrade.x2 = -2
        upgrade.y1 = -1
        upgrade.y2 = -2
        upgrade.color = {1,1,1}
        upgrade.multiplier = 1
        upgrade.speed = false
        -- upgrade["unlock".. tostring(x) .. "Speed1"] = false
        -- upgrade["unlock".. tostring(x) .. "Max1"] = false
        -- upgrade["unlock".. tostring(x) .. "Max2"] = false
        -- upgrade["unlock".. tostring(x) .. "Max3"] = false
        -- upgrade["unlock".. tostring(x) .. "GainX2"] = false
        -- upgrade["unlock".. tostring(x) .. "GainX3"] = false
        table.insert(upgrade_info, upgrade)
        -- upgrade_info["unlock" .. tostring(x)] = upgrade
    end
    return upgrade_info
end

function upgrades.updateMultiplier()
    for i, upgrade in ipairs(upgrade_info) do
        if upgradeTree.getUpgrade("unlock"..tostring(i).."GainX2").unlockStatus then
            print("uh")
            upgrade.multiplier = 2
        end

        if upgradeTree.getUpgrade("unlock"..tostring(i).."GainX3").unlockStatus then
            upgrade.multiplier = 6
        end
    end
    return upgrade_info
end

function upgrades.updateMax()
    for i, upgrade in ipairs(upgrade_info) do
        if upgradeTree.getUpgrade("unlock"..tostring(i).."Max1").unlockStatus then
            -- print("uh")
            upgrade.maxQuantity = 20
        end
    end
    return upgrade_info
end

-- function updateSpeed()

function drawUpgradeMenuBackground(bgX, bgWidth, windowHeight)
    --color of box
    love.graphics.setColor(0.2, 0.2, 0.2)
    --box dimensions/location
    love.graphics.rectangle("fill", bgX, 0, bgWidth, windowHeight)

    love.graphics.setColor(1,1,1)
end

function drawUpgradeButtons(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
    local margin = 16
    --remember to add coords to upgrade boxes for click checks
    local offset_y = 0
    for i, button in ipairs(upgrade_info) do
        button.unlock = upgradeTree.getUpgradeUnlockStatus("unlock" .. tostring(i))
    end

    for _, button in ipairs(upgrade_info) do
        if button.unlock then
            love.graphics.setColor(button.color)
            -- draws upgrade box
            love.graphics.rectangle(
                "fill",
                bgX + bgWidth*0.2,
                windowHeight*0.1 + offset_y,
                bgWidth*0.6,
                upgradeBoxHeight
            )

            --update box coords
            button.x1 = bgX + bgWidth*0.2 
            button.x2 = bgX + bgWidth*0.2 + bgWidth*0.6
            button.y1 = windowHeight*0.1 + offset_y
            button.y2 = windowHeight*0.1 + offset_y + upgradeBoxHeight
            
            --set color to draw in to black
            love.graphics.setColor(0,0,0)

            --print button name
            love.graphics.print(button.name, windowWidth*0.9 - (upgradeBoxWidth/2), windowHeight*0.1 + offset_y)
            
            --print button price
            button.price = math.floor(button.price)
            love.graphics.print("$" .. button.price, windowWidth*0.9 - (upgradeBoxWidth/2), windowHeight*0.1 + offset_y + upgradeBoxHeight*0.70)

            
            local textWidth = font:getWidth(tostring(button.boughtQuantity) .. "/" .. button.maxQuantity)
            love.graphics.print(button.boughtQuantity .. "/" .. button.maxQuantity, windowWidth*0.9 + (upgradeBoxWidth/2) - textWidth, windowHeight*0.1 + offset_y + upgradeBoxHeight*0.70)

            offset_y = upgradeBoxHeight + margin + offset_y

            love.graphics.setColor(1,1,1)
        end
    end
end

function drawUpgradeMenuTabs(windowWidth, windowHeight)
    local upgradeTabWidth
    local upgradeTabHeight
    local tabX1
    local tabY1

    --divider for tabs from upgrades
    love.graphics.line(windowWidth*0.8, windowHeight*0.06, windowWidth, windowHeight*0.06)

    --upgrade tree tab
    upgradeTabHeight = 20
    upgradeTabWidth = 25
    tabX1 = windowWidth*0.82
    tabY1 = windowHeight*0.06 - upgradeTabHeight

    love.graphics.rectangle("fill", tabX1, tabY1, upgradeTabWidth, upgradeTabHeight)

    upgrades.TabHeight = upgradeTabHeight
    upgrades.TabWidth = upgradeTabWidth
    upgrades.TabX1 = tabX1
    upgrades.TabY1 = tabY1
    upgrades.TabX2 = tabX1 + upgradeTabWidth
    upgrades.TabY2 = tabY1 + upgradeTabHeight
end

----------------------------------------------------------------------------------------
--------------------------------Initialized Upgrade Menu--------------------------------
----------------------------------------------------------------------------------------
function upgrades.drawUpgradeMenu(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
    drawUpgradeMenuBackground(bgX, bgWidth, windowHeight)
    drawUpgradeMenuTabs(windowWidth, windowHeight)
    drawUpgradeButtons(bgX, bgWidth, windowWidth, windowHeight, upgradeBoxHeight, upgradeBoxWidth)
end

-- upgrades.info = upgrade_info

return upgrades