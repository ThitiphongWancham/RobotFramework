*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
# Resource    
Test Teardown    Close Browser


*** Variables ***
${test_link}                https://rahulshettyacademy.com/loginpagePractise/
${error_message_locator}    class:alert-danger    # css:.alert-danger
${error_message}            Incorrect username/password.
${username_locator}         id:username
${password_locator}         id:password
${invalid_username}         someone 
${invalid_password}         12345678
${signin_btn_locator}       signInBtn    # If it is an id, you can omit "id:"


*** Test Cases ***
Validate Unsuccessful Login
    Open the browser with the url
    Fill the login form
    Wait until it checks and displays error message
    Verify error message


*** Keywords ***
Open the browser with the url
    Create Webdriver    Chrome
    Go To    ${test_link}

Fill the login form
    Input Text        ${username_locator}    ${invalid_username}
    Input Password    ${password_locator}    ${invalid_password}
    Click Button      ${signin_btn_locator}

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${error_message_locator}   

Verify error message
    # ${result}=    Get Text    ${error_message_Locator}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${error_message_locator}    ${error_message}