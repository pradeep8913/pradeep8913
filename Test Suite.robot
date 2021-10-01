*** Settings ***
Library           DateTime
Library           string
Library           Selenium2Library
Library           requests
Library           OperatingSystem
Library           String
Library           SoapLibrary
Library           JSONLibrary
Library           ../../../Users/pg33/PycharmProjects/pythonProject/venv/Scripts/UI_Automation.py
Resource          Object_Repository.txt

*** Test Cases ***
TC01
    ${Path}    Set Variable    C://Program Files//Mozilla Firefox//firefox.exe
    ${URL}    Set Variable    https://www.google.com
    ${URL}    Open Browser Python    ${URL}    ${Path}

TC02
    ${REST_URL}    SET VARIABLE    https://reqres.in/api/users
    #${AccessToken}    SET VARIABLE    kdis88Slskks9899==
    ${Rest_File}    SET VARIABLE    { \ \ \ \ "name": "Pradeep", \ \ \ \ "job": "Technical Leader" }
    Comment    ${Rest_File}    OperatingSystem.Get File    C://Automation//Robot_Framework//DELL_OTEL//Rest_API//test.txt
    Comment    &{headers}    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${AccessToken}
    &{headers}    Create Dictionary    Content-Type=application/json
    @{Response}    requests.Post    ${REST_URL}    ${Rest_File}    headers=${headers}
    Comment    ${TextFileContent_1}=    Replace String    ${Rest_File}    "firstName": ""    "firstName": "Pradeep"    3
    ${Response1}    Convert String to JSON    @{Response}
    ${Response2}    JSONLibrary.Get Value From Json    ${Response1}    id

TC03
    [Setup]    Runkeyword \ \ \ Create Soap Client \ \ \ D:/TAG_Automation/WSDLs/INT_326_A-B-C-D-generalServices/generalServices.wsdl \ \ \ EOC_OrderStatus
    Comment    ${TestDataPath}    Set Variable    C://Automation//Robot_Framework//DELL_OTEL//WSDL//generalServices.wsdl
    Comment    ${sheetName}    Set Variable    TestData
    ${RowCount}    Get Excel Row Count    ${TestDataPath}    TestData
    ${RowCount}    Evaluate    ${RowCount}+1    #: FOR    ${k}    IN RANGE    2    5    #\    &{Details}    Return Dictionary From Excel    ${k}    ${TestDataPath}    ${sheetName}    #\    Comment    Update Excel From Dictionary
    ...    # ${TestDataPath}    ${sheetName}    ${k}    ${Details}    #\    &{dict}    EOC_OrderVerification    &{Details}    #\    Set To Dictionary    ${Details}    out=${dict.out}    #\    Set To Dictionary    ${Details}    ExeStatus=${dict.out.description}
    ...    #\    Run Keyword If    '${Details.ExeStatus}'=='SUCCESS'    Set To Dictionary    ${Details}    EOC_OrderStatus=${Details.out.orders.order[0].orderStatus}    #\    ...    # ELSE    Set To Dictionary    ${Details}    EOC_OrderStatus=FAILED
    #\    Log Dictionary    ${Details}
    #\    Update Excel From Dictionary    ${k}    ${TestDataPath}    ${sheetName}    ${Details}
