*** Settings ***
Documentation    To validate the login form
Resource         ../PO/Resources.robot
Test Setup       Open the browser with the url    ${test_link}   
Test Teardown    Close Browser
# Test that will be run for each test case with its own dataset.
Test Template    Validate Unsuccessful Login


*** Variables ***
${test_link}                https://rahulshettyacademy.com/loginpagePractise/
${error_message_locator}    class:alert-danger
${error_message}            Incorrect username/password.
${username_locator}         id:username
${password_locator}         id:password
${signin_btn_locator}       signInBtn


*** Test Cases ***    username    password
Invalid username     dsahed    learning
Invalid password     rahulshettyacademy    wrongPassword
Special character    @$%&*^@#    learning


*** Keywords ***
Validate Unsuccessful Login
    [Arguments]    ${username}    ${password}
    Fill the login form    ${username}    ${password}
    Wait until it checks and displays error message
    Verify error message

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text        ${username_locator}    ${username}
    Input Password    ${password_locator}    ${password}
    Click Button      ${signin_btn_locator}

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${error_message_locator}   

Verify error message
    # ${result}=    Get Text    ${error_message_Locator}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${error_message_locator}    ${error_message}