*** Settings ***
Library           SeleniumLibrary

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_MAIN}               https://pozlovice.cz/
${UREDNI_DOKUMENTY}       xpath=//div[@class='main-box-docs']//a[contains(@class,'mbd-item')]

*** Test Cases ***
TC002-004: Přítomnost minimálně 1 dokumentu na úřední desce
    [Documentation]    Ověří, že se v sekci „Úřední deska“ na hlavní stránce zobrazí alespoň jeden dokument.

    Scroll Element Into View    ${UREDNI_DOKUMENTY}
    Wait Until Element Is Visible    ${UREDNI_DOKUMENTY}    timeout=5s
    ${count}=    Get Element Count   ${UREDNI_DOKUMENTY}
    Should Be True    ${count} > 0    msg=Očekává se alespoň 1 dokument, ale nalezeno ${count}
    Log    Nalezeno ${count} dokument(ů) na úřední desce

*** Keywords ***
Pre-conditions
    Open Browser    ${URL_MAIN}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-004.png
    Close Browser

# robot -o "TC002-004 - Output.xml" -r "TC002-004 - Report.html" -l "TC002-004 - Log.html" TC002-004.robot

