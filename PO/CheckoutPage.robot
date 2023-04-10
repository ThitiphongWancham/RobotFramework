*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${checkout_btn_locator}    css:.btn-success


*** Keywords ***
Verify items in the checkout page and proceed
    [Arguments]    ${products}
    Wait Until Element Is Visible    ${checkout_btn_locator}
    FOR    ${product}    IN    @{products}
        Page Should Contain    ${product}
    END
    Click Button    ${checkout_btn_locator}
