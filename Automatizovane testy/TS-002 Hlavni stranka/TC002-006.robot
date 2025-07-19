*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/
${DROPDOWN_TOGGLE}     id=snippet--org-title
${DROPDOWN_MESTYS}     xpath=//div[contains(@class, 'title-selector-inner')]//a[contains(text(), 'Městys')]

*** Test Cases ***

TC002-006: Výběr z dropdownu – „Městys“
    [Documentation]    Ověří, že v rozbalovacím menu sekce „Příspěvky“ existuje možnost „Městys“.

    Scroll Element Into View    ${DROPDOWN_TOGGLE}
    Wait Until Element Is Visible    ${DROPDOWN_TOGGLE}    timeout=5s
    Click Element                   ${DROPDOWN_TOGGLE}

    Wait Until Element Is Visible    ${DROPDOWN_MESTYS}    timeout=5s
    Element Should Be Visible        ${DROPDOWN_MESTYS}

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-006.png
    Close Browser

# robot -o "TC002-006 - Output" -r "TC002-006 - Report" -l "TC002-006 - Log" TC002-006.robot
