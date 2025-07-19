*** Settings ***
Library    SeleniumLibrary

Suite Setup     Pre-conditions
Suite Teardown  Post-conditions

*** Variables ***
${BROWSER}         Chrome
${URL}             https://pozlovice.cz/
${EXPECTED_URL}    https://pozlovice.cz/obec/ubytovani-a-sluzby
${LINK_UBYTOVANI}  xpath=//div[@class="headline-bottom-items"]//a[normalize-space()="Ubytování a služby"]

*** Test Cases ***
TC002-003: Přesměrování na „Ubytování a služby“
    [Documentation]    Ověří, že po kliknutí na „Ubytování a služby“ dojde k přesměrování na správnou URL.
    
    Wait Until Element Is Visible    ${LINK_UBYTOVANI}    timeout=5s
    Click Element                    ${LINK_UBYTOVANI}
    Wait Until Location Contains     /obec/ubytovani-a-sluzby    timeout=10s
    Location Should Be              ${EXPECTED_URL}

*** Keywords ***
Pre-conditions
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-003.png
    Close Browser

# robot -o "TC002-003 - Output.xml" -r "TC002-003 - Report.html" -l "TC002-003 - Log.html" TC002-003.robot
