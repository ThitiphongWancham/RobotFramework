*** Settings ***
Documentation     To validate the login form
Resource          ../PO/Resources.robot
Resource          ../PO/LandingPage.robot
Resource          ../PO/ShopPage.robot
Resource          ../PO/CheckoutPage.robot
Resource          ../PO/ConfirmationPage.robot
Library           ../CustomLibrary/Shop.py
# 'chrome', 'edge', or 'firefox' (not recommended)
Test Setup        Open the custom browser with the url    ${test_link}
Test Teardown     Close Browser


*** Variables ***
${test_link}                https://rahulshettyacademy.com/loginpagePractise/  
# Loggin/Landing Page  
${error_message}            Incorrect username/password.
${radio_value}              user      # 'user' or 'admin'
${dropdown_value}           Teacher   # 'Student', 'Teacher', or 'Consultant'
# Shop Page & Checkout Page
@{products}                 iphone X    Samsung Note 8
# Confirmation Page
${country_name}             India


*** Test Cases ***
Validate Unsuccessful Login
    [Tags]    SMOKE
    LandingPage.Fill the login form    ${invalid_username}    ${invalid_password}
    LandingPage.Sign in
    LandingPage.Verify error message    ${error_message}
    Hello World    # « Shop.py

Validate Successful Login
    [Tags]    REGRESSION
    LandingPage.Fill the login form    ${valid_username}    ${valid_password}
    LandingPage.Sign in
    ShopPage.Wait for checkout button to appear
    ShopPage.Verify card titles in the shop page
    Add Items To Cart And Checkout    ${products}    # « Shop.py
    CheckoutPage.Verify items in the checkout page and proceed    ${products}
    ConfirmationPage.Enter the country and accept terms    ${country_name}
    ConfirmationPage.Purchase and verify message

Fill the Form and Navigate to the Child Window
    LandingPage.Fill the login form    ${valid_username}    ${valid_password}
    LandingPage.Select radio    ${radio_value}
    LandingPage.Dismiss the modal    # If 'radio_value' is 'user'
    LandingPage.Select option    ${dropdown_value}
    LandingPage.Sign in
    ShopPage.Wait for checkout button to appear
