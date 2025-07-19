*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/

${HEADLINE_TITLE}      xpath=//section[contains(@class, 'headline')]//h2
${EXPECTED_TEXT}       Vítejte v Pozlovicích

*** Test Cases ***

TC002-001: Kontrola titulku hlavní stránky
    [Documentation]    Ověří, že se na stránce zobrazuje nadpis „Vítejte v Pozlovicích“.

    Wait Until Element Is Visible    ${HEADLINE_TITLE}    timeout=5s
    Element Text Should Be           ${HEADLINE_TITLE}    ${EXPECTED_TEXT}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-001.png
    Close Browser

#  robot -o "TC002-001 - Output" -r "TC002-001 - Report" -l "TC002-001 - Log" "TC002-001.robot"