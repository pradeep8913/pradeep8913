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
