*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/
${URL_EXPECTED}        https://pozlovice.cz/

${LOGO_LINK}           xpath=//a[contains(@class, 'header-logo')]

*** Test Cases ***

TC001-004: Kliknutí na logo přesměruje na domovskou stránku
    [Documentation]    Ověří, že po kliknutí na logo se uživatel přesměruje na domovskou stránku

    Wait Until Element Is Visible    ${LOGO_LINK}    timeout=5s
    Click Element                    ${LOGO_LINK}

    Wait Until Location Is          ${URL_EXPECTED}    timeout=10s
    Location Should Be              ${URL_EXPECTED}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-004.png
    Close Browser

#  robot -o "TC001-004 - Output" -r "TC001-004 - Report" -l "TC001-004 - Log" "TC001-004.robot"