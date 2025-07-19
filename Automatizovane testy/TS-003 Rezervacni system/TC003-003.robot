*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${RESERVATION_URL}       https://pozlovice.rezervace.online/cs/place/viceucelove-hriste-u-ms-26542/2025-07-16;viewMode=7-days
${AVAILABLE_SLOT}        xpath=//td[contains(@class, "cell") and contains(@class, "is-available")]
${RESERVATION_FORM}      xpath=//form | //input[@type="text"] | //button[contains(text(), "Rezervovat")]

*** Test Cases ***

TC003-003: Výběr volného termínu – zobrazení rezervačního formuláře
    [Documentation]    Ověří, že po kliknutí na volný termín (zelené pole) se zobrazí formulář.

    Wait Until Page Contains Element     xpath=//div[contains(@class, "terms-view-container")]    20s
    Wait Until Page Contains Element     ${AVAILABLE_SLOT}    20s
    Scroll Element Into View             ${AVAILABLE_SLOT}
    Click Element                        ${AVAILABLE_SLOT}
    Wait Until Page Contains Element     ${RESERVATION_FORM}    10s
    Page Should Contain Element          ${RESERVATION_FORM}

*** Keywords ***

Pre-conditions
    Open Browser    ${RESERVATION_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC003-003.png
    Close Browser

# robot -o "TC003-003-Output.xml" -r "TC003-003-Report.html" -l "TC003-003-Log.html" TC003-003.robot