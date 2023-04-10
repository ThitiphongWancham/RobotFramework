*** Settings ***
Library    RequestsLibrary
Library    Collections


*** Variables ***
${base_url}    https://rahulshettyacademy.com


*** Test Cases ***
Play around with dictionary
    # &{...} is used when newly creating a dictionary
    &{data}=    Create Dictionary    name=rahulshetty    course=robot    website=rahulshettyacademy.com
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name 
    Log    ${data}[name]

Add book into library database
    &{req_body}=    Create Dictionary    name=Learn Appium Automation with Java    isbn=xcba    aisle=2278    author=John foe 
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id}=    Get From Dictionary    ${response.json()}    ID 
    Log    ${book_id}
    # Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200    ${response}
    Set Global Variable    ${book_id}
    ${book_name}=    Set Variable    ${req_body}[name]
    Set Global Variable    ${book_name}

Get book details
    ${response}=    GET    ${base_url}/Library/GetBook.php     params=ID=${book_id} 
    # You have to run with the previous test in order to get 'book_id' value 
    Status Should Be    200    ${response}
    Log    ${response.json()[0]}   # response.json() is a list contains a dictionary
    Should Be Equal As Strings    ${book_name}    ${response.json()[0]}[book_name]

