*** Settings ***
Documentation    To validate the login form
Resource         ../PO/Resources.robot
Test Setup       Open the browser with the url    ${test_link}   
# Test Teardown    Close Browser


*** Variables ***
${test_link}                https://rahulshettyacademy.com/loginpagePractise/
${hyperlink_locator}        css:a.blinkingText
${red_paragraph_locator}    css:p.red
${username_locator}         username 

*** Test Cases ***
Validate child window functionality
    Open Link
    Verify the user is switched to the child window
    Grab the email id in the paragraph
    Switch back to the parent window and enter the email


*** Keywords ***
Open Link 
    Click Element    ${hyperlink_locator}
    Sleep    5

Verify the user is switched to the child window
    Switch Window    NEW
    Wait Until Element Is Visible    ${red_paragraph_locator}

Grab the email id in the paragraph
    ${paragraph} =    Get Text    ${red_paragraph_locator}
    ${email} =    Get Substring    ${paragraph}    19    48
    Set Global Variable    ${email}

Switch back to the parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Wait Until Element Is Visible    ${username_locator}
    Input Text    ${username_locator}    ${email}