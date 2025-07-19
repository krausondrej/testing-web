*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}              Chrome
${URL_TEST_PAGE}        https://pozlovice.cz/

${MENU_BURGER}          css=#menu
${LINK_OBCAN}           xpath=//div[@class='sidebar']//a[normalize-space()='Občan']
${LINK_INFORMUJEME}     xpath=//div[@class='sidebar']//a[h4[normalize-space()='Informujeme']]

*** Test Cases ***

TC001-002: Klik na Občan a ověření zobrazení „Informujeme“
    [Documentation]    Klikne na "Občan" v burger menu a ověří, že se objeví submenu "Informujeme"

    Click Element    ${MENU_BURGER}
    Wait Until Element Is Visible    xpath=//div[@class='sidebar']//nav    timeout=5s

    Wait Until Element Is Visible    ${LINK_OBCAN}    timeout=5s
    Click Element                    ${LINK_OBCAN}

    Wait Until Element Is Visible    ${LINK_INFORMUJEME}    timeout=5s
    Element Should Be Visible        ${LINK_INFORMUJEME}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-002.png
    Close Browser


#  robot -o "TC001-002 - Output" -r "TC001-002 - Report" -l "TC001-002 - Log" "TC001-002.robot"