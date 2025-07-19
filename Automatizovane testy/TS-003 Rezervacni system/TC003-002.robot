*** Settings ***
Library           SeleniumLibrary

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}             Chrome
${BASE URL}            https://pozlovice.rezervace.online
${HŘIŠTĚ_TITUL}        xpath=//span[contains(text(), "Víceúčelové hřiště u MŠ")]
${REZERVAČNÍ_BOX}      xpath=//div[contains(@class, "place-detail") or contains(@class, "calendar") or contains(text(), "Rezervace")]

*** Test Cases ***

TC003-002: Přímá rezervace – Víceúčelové hřiště
    [Documentation]    Klikne na „Víceúčelové hřiště u MŠ“ a ověří, že se zobrazí rezervační stránka.

    Go To    ${BASE URL}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HŘIŠTĚ_TITUL}    10s

    Scroll Element Into View    ${HŘIŠTĚ_TITUL}
    Click Element               ${HŘIŠTĚ_TITUL}

    Wait Until Page Contains Element    ${REZERVAČNÍ_BOX}    10s
    Page Should Contain Element         ${REZERVAČNÍ_BOX}

    Log    Načtena stránka detailu Víceúčelového hřiště s možností rezervace.

*** Keywords ***

Pre-conditions
    Open Browser    about:blank    ${BROWSER}

Post-conditions
    Capture Page Screenshot    TC003-002.png
    Close Browser

# robot -o "TC003-002-Output.xml" -r "TC003-002-Report.html" -l "TC003-002-Log.html" TC003-002.robot