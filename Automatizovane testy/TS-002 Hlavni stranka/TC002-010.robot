*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}           https://pozlovice.cz/
${PROMO_SECTION}           id=module-promo
${PROMO_LINK_XPATH}        xpath=//section[@id="module-promo"]//a[contains(@href, "mobilni-aplikace")]
${EXPECTED_URL_PART}       /obec/p234-nova-mobilni-aplikace-nasi-obce

*** Test Cases ***

TC002-010: Kliknutí na box aplikace – ověření přesměrování
    [Documentation]    Ověří, že po kliknutí na box „Stáhněte si mobilní aplikaci naší obce“ dojde k přesměrování na správnou podstránku.

    Scroll Element Into View         ${PROMO_SECTION}
    Wait Until Element Is Visible    ${PROMO_LINK_XPATH}    10s
    Click Element                    ${PROMO_LINK_XPATH}
    Wait Until Location Contains     ${EXPECTED_URL_PART}    10s
    Location Should Contain          ${EXPECTED_URL_PART}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${PROMO_SECTION}    10s

Post-conditions
    Capture Page Screenshot    TC002-010.png
    Close Browser

# robot -o "TC002-010-Output.xml" -r "TC002-010-Report.html" -l "TC002-010-Log.html" TC002-010.robot
