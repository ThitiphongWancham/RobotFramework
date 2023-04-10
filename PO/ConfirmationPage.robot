*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${country_field_locator}    country
${suggestion_locator}       css:div.suggestions
${checkbox2_locator}        css:label[for="checkbox2"]
${purchase_locator}         css:input[type='submit']


*** Keywords ***
Enter the country and accept terms
    [Arguments]    ${country_name}
    Input Text    ${country_field_locator}    ${country_name}
    Sleep    2
    Wait Until Element Is Visible    ${suggestion_locator}
    Click Link    xpath://a[text()='${country_name}']
    Sleep    2
    Wait Until Element Is Visible    ${checkbox2_locator}
    Click Element    ${checkbox2_locator}

Purchase and verify message
    Click Element    ${purchase_locator}
    Page Should Contain    Success!