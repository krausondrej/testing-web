*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}              Chrome
${URL_TEST_PAGE}        https://pozlovice.cz/
${URL_EXPECTED}         https://pozlovice.cz/obec/videa

${MENU_BURGER}              css=#menu
${LINK_VIDEA}               xpath=//div[@class='sidebar']//a[normalize-space()='Videa']
${LINK_VIDEA_PRISPEVKY}     xpath=//div[@class='sidebar']//a[normalize-space()='Videa z příspěvků']

*** Test Cases ***

TC001-006: Kliknutí v menu na „Videa“ a pak „Videa z příspěvků“
    [Documentation]    Ověří, že po kliknutí v postranním menu na „Videa“ a následně na „Videa z příspěvků“
    ...                se uživatel přesměruje na správnou stránku.

    # Otevřít burger menu
    Click Element    ${MENU_BURGER}
    Wait Until Element Is Visible    xpath=//div[@class='sidebar']//nav    timeout=5s

    # Rozbalit položku „Videa“
    Wait Until Element Is Visible    ${LINK_VIDEA}    timeout=5s
    Click Element                    ${LINK_VIDEA}

    # Kliknout na „Videa z příspěvků“
    Wait Until Element Is Visible    ${LINK_VIDEA_PRISPEVKY}    timeout=5s
    Click Element                    ${LINK_VIDEA_PRISPEVKY}

    # Ověření správné URL
    Wait Until Location Contains     /obec/videa    timeout=10s
    Location Should Be               ${URL_EXPECTED}

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC001-006.png
    Close Browser

#  robot -o "TC001-006 - Output" -r "TC001-006 - Report" -l "TC001-006 - Log" "TC001-006.robot"