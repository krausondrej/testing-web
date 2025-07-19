*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}        Chrome
${URL_TEST_PAGE}  https://pozlovice.cz/

*** Test Cases ***

TC001: Kontrola načtení hlavičky a nadpisu
    [Documentation]    Ověří, že hlavička stránky obsahuje správný nadpis "Pozlovice"
    Wait Until Page Contains Element    css:header.header h1.sr-only    timeout=10s
    Element Text Should Be              css:header.header h1.sr-only    Pozlovice
    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001_Header.png
    Close Browser

#  robot -o "TC001 - Output" -r "TC001 - Report" -l "TC001 - Log" "TC001.robot"