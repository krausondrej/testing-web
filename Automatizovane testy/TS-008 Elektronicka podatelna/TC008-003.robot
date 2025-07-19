*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library           BuiltIn

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}        Chrome
${START_URL}      https://pozlovice.cz/obec/formulare/podatelna

${FIELD_NAME}              id=frm-podatelnaForm-name
${FIELD_PHONE}             id=frm-podatelnaForm-tel
${FIELD_EMAIL}             id=frm-podatelnaForm-email
${FIELD_SUBJECT}           id=frm-podatelnaForm-subject
${FIELD_BODY}              id=frm-podatelnaForm-body
${SUBMIT_BUTTON}           xpath=//input[@type='submit' and @value='Odeslat']

*** Test Cases ***
TC008-003: Ověření validace pole Jméno a příjmení (chybí)
    [Documentation]    Ověří, že formulář nepovolí odeslání bez vyplnění jména a příjmení (HTML5 validace).

    Go To    ${START_URL}
    Wait Until Element Is Visible    ${FIELD_PHONE}    10s
    Scroll Element Into View         ${FIELD_PHONE}

    # Vynecháme jméno – záměrně
    Input Text    ${FIELD_PHONE}        123456789
    Input Text    ${FIELD_EMAIL}        uzivatel@test.cz
    Input Text    ${FIELD_SUBJECT}      Test bez jména
    Input Text    ${FIELD_BODY}         Obsah bez jména

    ${is_valid}=    Execute JavaScript    return document.getElementById("frm-podatelnaForm-name").checkValidity();
    Run Keyword If    ${is_valid}    Fail    Očekává se, že pole jmeno nebude validní, ale je.

    ${validation_message}=    Execute JavaScript    return document.getElementById("frm-podatelnaForm-name").validationMessage;
    Should Contain    ${validation_message}    Vyplňte prosím

*** Keywords ***
Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC008-003.png
    Close Browser

# robot -o "TC008-003-Output.xml" -r "TC008-003-Report.html" -l "TC008-003-Log.html" TC008-003.robot