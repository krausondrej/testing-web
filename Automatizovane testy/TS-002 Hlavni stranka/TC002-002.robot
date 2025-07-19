*** Settings ***
Library    SeleniumLibrary    run_on_failure=Nothing

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/

${LINK_OBCAN}              xpath=//a[@class='hbi-item' and contains(@href, '/obec/obcan')]
${LINK_SPOLKY}             xpath=//a[@class='hbi-item' and contains(@href, '/spolky-instituce')]
${LINK_TURISTA}            xpath=//a[@class='hbi-item' and contains(@href, '/obec/turista-a-volny-cas')]
${LINK_UBYTOVANI}          xpath=//a[@class='hbi-item' and contains(@href, '/obec/ubytovani-a-sluzby')]
${LINK_REZERVACE}          xpath=//a[@class='hbi-item' and contains(@href, '/obec/rezervacni-system')]
${LINK_FOTOGALERIE}        xpath=//a[@class='hbi-item' and contains(@href, '/obec/fotogalerie-a-video')]

*** Test Cases ***

TC002-002: Kontrola přítomnosti odkazů ve spodní části headline
    [Documentation]    Ověří, že se na hlavní stránce zobrazují všechny odkazy: Občan, Spolky, Turista, Ubytování, Rezervace, Fotogalerie

    Wait Until Element Is Visible    ${LINK_OBCAN}        timeout=5s
    Wait Until Element Is Visible    ${LINK_SPOLKY}       timeout=5s
    Wait Until Element Is Visible    ${LINK_TURISTA}      timeout=5s
    Wait Until Element Is Visible    ${LINK_UBYTOVANI}    timeout=5s
    Wait Until Element Is Visible    ${LINK_REZERVACE}    timeout=5s
    Wait Until Element Is Visible    ${LINK_FOTOGALERIE}  timeout=5s

    [Teardown]    Post-conditions

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-002.png
    Close Browser

# robot -o "TC002-002 - Output.xml" -r "TC002-002 - Report.html" -l "TC002-002 - Log.html" TC002-002.robot

