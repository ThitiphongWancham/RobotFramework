*** Settings ***
Documentation    All the page objects and keywords of shop page
Library          SeleniumLibrary   


*** Variables ***
${checkout_locator}         css:a.btn-primary
${card_title_locator}       css:.card-title


*** Keywords *** 
Verify card titles in the shop page
    # '@{...}' used to create a list for the first time
    @{item_titles} =     Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${web_elements} =    Get WebElements    ${card_title_locator}
    FOR    ${element}    IN    @{web_elements}
        Should Contain    ${item_titles}     ${element.text} 
    END
    Set Global Variable    ${web_elements}

Wait for checkout button to appear
    Wait Until Element Is Visible    ${checkout_locator}

# Move this keyword to Shop.py
# Select the card
#     [Arguments]    ${title}
#     ${index} =     Set Variable    1
#     FOR    ${element}    IN    @{web_elements}
#         Exit For Loop If    '${element.text}' == '${title}'
#         ${index} =    Evaluate    ${index} + 1
#     END
#     Click Button    xpath:(//button[contains(text(),'Add')])[${index}]
#     Scroll Element Into View    ${nav_link_locator}