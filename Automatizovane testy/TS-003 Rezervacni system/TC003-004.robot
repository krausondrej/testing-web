*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${RESERVATION_URL}       https://pozlovice.rezervace.online/cs/place/viceucelove-hriste-u-ms-26542/2025-07-16;viewMode=7-days
${AVAILABLE_SLOT}        xpath=//td[contains(@class, "cell") and contains(@class, "is-available")]
${LOGIN_PROMPT_BUTTON}   xpath=//a[contains(@class, "btn-success") and contains(text(), "Přihlásit se")]
${EMAIL_INPUT}           id=login-email-input
${PASSWORD_INPUT}        id=login-password-input
${LOGIN_SUBMIT_BUTTON}   xpath=//button[contains(text(), "Přihlásit se")]

*** Test Cases ***

TC003-004: Ověření zobrazení login formuláře po výběru termínu
    [Documentation]    Ověří, že po kliknutí na volný termín se zobrazí výzva k přihlášení a následně login formulář.

    Wait Until Page Contains Element     xpath=//div[contains(@class, "terms-view-container")]    20s
    Wait Until Page Contains Element     ${AVAILABLE_SLOT}    20s
    Scroll Element Into View             ${AVAILABLE_SLOT}
    Click Element                        ${AVAILABLE_SLOT}

    Wait Until Element Is Visible        ${LOGIN_PROMPT_BUTTON}    10s
    Click Element                        ${LOGIN_PROMPT_BUTTON}

    Wait Until Page Contains Element     ${EMAIL_INPUT}    10s
    Page Should Contain Element          ${EMAIL_INPUT}
    Page Should Contain Element          ${PASSWORD_INPUT}
    Page Should Contain Element          ${LOGIN_SUBMIT_BUTTON}

*** Keywords ***

Pre-conditions
    Open Browser    ${RESERVATION_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC003-004.png
    Close Browser

# robot -o "TC003-004-Output.xml" -r "TC003-004-Report.html" -l "TC003-004-Log.html" TC003-004.robot
