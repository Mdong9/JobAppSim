local clickCheck = {}

clickCheck.total_money = 0
----------------------------------------------------------------------------------------
----------------------------Upgrade Buttons Click Check---------------------------------
----------------------------------------------------------------------------------------
function clickCheck.clickUpgradeCheck(mouseX, mouseY, upgrade_info, total_money)
    for _, button in ipairs(upgrade_info) do

        if mouseX >= button.x1 and mouseX <= button.x2 and mouseY >= button.y1 and mouseY <= button.y2 then
            
            if button.boughtQuantity < button.maxQuantity and total_money >= button.price then
                clickCheck.total_money = total_money - button.price

                button.boughtQuantity = button.boughtQuantity + 1 --update value bought
                button.price = (button.base_price * (1.20 ^ button.boughtQuantity)) + button.price
                --update upgrade related values later
                --change color of box when pressed then change it back
            end
            break
        end
    end
end
----------------------------------------------------------------------------------------
----------------------------Main clicker Click Check------------------------------------
----------------------------------------------------------------------------------------
function clickCheck.clickJobCheck(mouseX, mouseY, jobX1, jobY1, jobX2, jobY2, total_money)

    if mouseX >= jobX1 and mouseX <= jobX2 and mouseY >= jobY1 and mouseY <= jobY2 then
        clickCheck.total_money = total_money + 1
    end

end
----------------------------------------------------------------------------------------
--------------------------------Upgrade Tree Click Check--------------------------------
----------------------------------------------------------------------------------------
function clickCheck.clickTreeTabCheck(mouseX, mouseY, treeTabX1, treeTabY1, treeTabX2, treeTabY2, main_game_screen, upgrade_tree_screen)

    if mouseX >= treeTabX1 and mouseX <= treeTabX2 and mouseY >= treeTabY1 and mouseY <= treeTabY2 then
        clickCheck.main_game_screen = not main_game_screen
        clickCheck.upgrade_tree_screen = not upgrade_tree_screen
    else
        clickCheck.main_game_screen = main_game_screen
        clickCheck.upgrade_tree_screen = upgrade_tree_screen
    end
end

return clickCheck