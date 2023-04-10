*** Settings ***
Documentation     To validate the login form
Resource          ../PO/Resources.robot
Test Setup        Open the browser with the url    ${test_link}
Test Teardown     Close Browser


*** Variables ***
${test_link}                https://rahulshettyacademy.com/loginpagePractise/
${error_message_locator}    css:.alert-danger
${error_message}            Incorrect username/password.
${username_locator}         id:username
${password_locator}         id:password
${signin_btn_locator}       signInBtn    
${checkbox_locator}         terms
${nav_link_locator}         css:.nav-link
${card_title_locator}       css:.card-title 
${dropdown_locator}         css:select.form-control
${modal_footer_locator}     css:div.modal-footer
${okay_btn_locator}         okayBtn 
${radio_name}               radio
${radio_value}              user      # 'user' or 'admin'
${dropdown_value}           Teacher   # 'Student', 'Teacher', or 'Consultant'


*** Test Cases ***
Validate Unsuccessful Login
    Fill the login form    ${invalid_username}    ${invalid_password}
    Sign in
    Wait Until Element Is Visible   ${error_message_locator}  
    Verify error message

Validate Successful Login
    Fill the login form    ${valid_username}    ${valid_password}
    Sign in
    Wait Until Element Is Visible    ${nav_link_locator}
    Verify card titles in the shop page
    Select the card    Blackberry

Select the Form and Navigate to the Child Window
    Fill the login form    ${valid_username}    ${valid_password}
    Select Radio Button    ${radio_name}    ${radio_value}
    Wait Until Element Is Visible    ${modal_footer_locator}
    Click Button    ${okay_btn_locator}
    Select From List By Label    ${dropdown_locator}    ${dropdown_value}
    Sign in
    Wait Until Element Is Visible    ${nav_link_locator}


*** Keywords ***
Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text        ${username_locator}    ${username}
    Input Password    ${password_locator}    ${password}    

Verify error message
    # ${result}=    Get Text    ${error_message_Locator}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${error_message_locator}    ${error_message}

Sign in 
    Select Checkbox    ${checkbox_locator}
    Checkbox Should Be Selected    ${checkbox_locator}
    Click Button      ${signin_btn_locator}

Verify card titles in the shop page
    # '@{...}' used to create a list for the first time
    @{item_titles} =     Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${web_elements} =    Get WebElements    ${card_title_locator}
    FOR    ${element}    IN    @{web_elements}
        Should Contain    ${item_titles}     ${element.text} 
    END
    Set Global Variable    ${web_elements}

Select the card
    [Arguments]    ${title}
    ${index} =     Set Variable    1
    FOR    ${element}    IN    @{web_elements}
        Exit For Loop If    '${element.text}' == '${title}'
        ${index} =    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//button[contains(text(),'Add')])[${index}]
    Scroll Element Into View    ${nav_link_locator}

