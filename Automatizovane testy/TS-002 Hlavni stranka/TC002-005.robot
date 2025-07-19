*** Settings ***
Library           SeleniumLibrary

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_MAIN}            https://pozlovice.cz/
${LINK_VICE_UREDNI}    xpath=//a[@class='main-box-more']
${CILOVA_CAST_URL}     /obec/uredni-deska

*** Test Cases ***
TC002-005: Funkčnost odkazu „Další zprávy na ÚD“
    [Documentation]    Ověří, že kliknutí na odkaz „Další zprávy na ÚD“ přesměruje na správnou stránku.

    Scroll Element Into View     ${LINK_VICE_UREDNI}
    Wait Until Element Is Visible    ${LINK_VICE_UREDNI}    timeout=5s
    Click Element                   ${LINK_VICE_UREDNI}
    Wait Until Location Contains   ${CILOVA_CAST_URL}    timeout=10s
    Location Should Contain        ${CILOVA_CAST_URL}

*** Keywords ***
Pre-conditions
    Open Browser    ${URL_MAIN}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-005.png
    Close Browser

# robot -o "TC002-005 - Output.xml" -r "TC002-005 - Report.html" -l "TC002-005 - Log.html" TC002-005.robot
