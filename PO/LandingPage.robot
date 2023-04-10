*** Settings ***
Documentation    All the page objects and keywords of landing page
Library          SeleniumLibrary   

*** Variables ***
${username_locator}         username
${password_locator}         password
${error_message_locator}    css:.alert-danger
${signin_btn_locator}       signInBtn
${checkbox_locator}         terms
${dropdown_locator}         css:select.form-control
${modal_footer_locator}     css:div.modal-footer
${okay_btn_locator}         okayBtn 
${radio_name}               radio


*** Keywords ***
Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text        ${username_locator}    ${username}
    Input Password    ${password_locator}    ${password} 

Verify error message
    [Arguments]    ${error_message}
    Wait Until Element Is Visible   ${error_message_locator}
    Element Text Should Be    ${error_message_locator}    ${error_message}

Sign in 
    Select Checkbox    ${checkbox_locator}
    Checkbox Should Be Selected    ${checkbox_locator}
    Click Button      ${signin_btn_locator}

Dismiss the modal
    Wait Until Element Is Visible    ${modal_footer_locator}
    Click Button    ${okay_btn_locator}
    Wait Until Element Is Not Visible    ${modal_footer_locator}

Select radio
    [Arguments]    ${choice}
    Select Radio Button    ${radio_name}    ${choice}

Select option
    [Arguments]    ${option}
    Select From List By Label    ${dropdown_locator}    ${option}