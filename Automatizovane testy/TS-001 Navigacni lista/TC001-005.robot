*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}              Chrome
${URL_TEST_PAGE}        https://pozlovice.cz/
${SEARCH_FIELD}         xpath=//form[contains(@class,'header-search')]//input[@name='q']
${SEARCH_TEXT}          kabelovka
${SEARCH_RESULT_URL}    /hledat?q=${SEARCH_TEXT}

*** Test Cases ***

TC001-005: Ověření funkčnosti vyhledávacího pole
    [Documentation]    Ověří, že po zadání výrazu do pole pro hledání a potvrzení dojde k přesměrování na stránku s výsledky

    Wait Until Element Is Visible    ${SEARCH_FIELD}    timeout=5s
    Input Text                       ${SEARCH_FIELD}    ${SEARCH_TEXT}
    Press Keys                       ${SEARCH_FIELD}    RETURN

    Wait Until Location Contains     ${SEARCH_RESULT_URL}    timeout=10s
    Location Should Contain          ${SEARCH_RESULT_URL}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-005.png
    Close Browser

#  robot -o "TC001-005 - Output" -r "TC001-005 - Report" -l "TC001-005 - Log" "TC001-005.robot"