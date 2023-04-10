*** Settings ***
Documentation    A resource file with reusable keywords and variables. 
...              The system specific keywords created here from our own domain 
...              specific language. They utilize keywords provided by the 
...              imported  SeleniumLibrary.

Library          SeleniumLibrary   
Library          Collections
Library          String


*** Variables ***
${invalid_username}         someone 
${invalid_password}         12345678
${valid_username}           rahulshettyacademy
${valid_password}           learning
${browser}                  Chrome

*** Keywords ***
Open the browser with the url
    [Arguments]         ${test_link}
    Create Webdriver    Chrome
    Go To               ${test_link}

Open the custom browser with the url
    [Arguments]         ${test_link}
    Create Webdriver    ${browser}    executable_path=../WebDriver/${browser}
    Go To               ${test_link}