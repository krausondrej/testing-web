*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}           Chrome
${URL_TEST_PAGE}     https://pozlovice.cz/

${NAV_KONTAKTY}         xpath=//div[@class='sidebar']//nav//a[normalize-space()='Kontakty']
${NAV_OBCAN}            xpath=//div[@class='sidebar']//nav//a[normalize-space()='Občan']
${NAV_SPOLKY}           xpath=//div[@class='sidebar']//nav//a[normalize-space()='Spolky a instituce']
${NAV_TURISTA}          xpath=//div[@class='sidebar']//nav//a[normalize-space()='Turista a volný čas']
${NAV_UBYTOVANI}        xpath=//div[@class='sidebar']//nav//a[normalize-space()='Ubytování a služby']
${NAV_FOTOGALERIE}      xpath=//div[@class='sidebar']//nav//a[normalize-space()='Fotogalerie']
${NAV_VIDEA}            xpath=//div[@class='sidebar']//nav//a[normalize-space()='Videa']

*** Test Cases ***

TC001-001: Kontrola navigace v burger menu
    [Documentation]    Ověří hlavní položky navigace ve výsuvném (burger) menu

    Click Element    css=#menu
    Wait Until Element Is Visible    xpath=//div[@class='sidebar']//nav    timeout=5s

    Element Should Be Visible    ${NAV_KONTAKTY}
    Element Should Be Visible    ${NAV_OBCAN}
    Element Should Be Visible    ${NAV_SPOLKY}
    Element Should Be Visible    ${NAV_TURISTA}
    Element Should Be Visible    ${NAV_UBYTOVANI}
    Element Should Be Visible    ${NAV_FOTOGALERIE}
    Element Should Be Visible    ${NAV_VIDEA}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-001.png
    Close Browser


#  robot -o "TC001-001 - Output" -r "TC001-001 - Report" -l "TC001-001 - Log" "TC001-001.robot"