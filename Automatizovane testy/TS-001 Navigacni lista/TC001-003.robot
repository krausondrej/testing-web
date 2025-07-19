*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/
${URL_EXPECTED}        https://pozlovice.cz/spol/farnost

${MENU_BURGER}         css=#menu
${LINK_SPOLKY}         xpath=//div[@class='sidebar']//a[normalize-space()='Spolky a instituce']
${LINK_FARNOST}        xpath=//div[@class='sidebar']//a[normalize-space()='Farnost']

*** Test Cases ***

TC001-003: Klik na „Farnost“ a kontrola URL
    [Documentation]    Ověří, že po kliknutí na „Farnost“ se načte správná stránka

    # Otevřít menu
    Click Element    ${MENU_BURGER}
    Wait Until Element Is Visible    xpath=//div[@class='sidebar']//nav    timeout=5s

    # Rozbalit "Spolky a instituce"
    Wait Until Element Is Visible    ${LINK_SPOLKY}    timeout=5s
    Click Element                    ${LINK_SPOLKY}

    # Kliknout na "Farnost"
    Wait Until Element Is Visible    ${LINK_FARNOST}    timeout=5s
    Click Element                    ${LINK_FARNOST}

    # Počkat na načtení nové stránky
    Wait Until Location Contains    /spol/farnost    timeout=10s
    Location Should Be              ${URL_EXPECTED}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-003.png
    Close Browser

#  robot -o "TC001-003 - Output" -r "TC001-003 - Report" -l "TC001-003 - Log" "TC001-003.robot"