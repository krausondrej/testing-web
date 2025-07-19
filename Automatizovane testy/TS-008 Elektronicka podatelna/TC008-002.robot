*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot
Library           BuiltIn

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}        Chrome
${START_URL}      https://pozlovice.cz/obec/formulare/podatelna

# Selektory formulářových polí
${FIELD_NAME}              id=frm-podatelnaForm-name
${FIELD_PHONE}             id=frm-podatelnaForm-tel
${FIELD_EMAIL}             id=frm-podatelnaForm-email
${FIELD_SUBJECT}           id=frm-podatelnaForm-subject
${FIELD_BODY}              id=frm-podatelnaForm-body
${SUBMIT_BUTTON}           xpath=//input[@type='submit' and @value='Odeslat']

*** Test Cases ***
TC008-002: Ověření validace pole Email (špatný formát)
    [Documentation]    Ověří, že formulář nepovolí odeslání s neplatnou e-mailovou adresou (HTML5 validace).

    Go To    ${START_URL}
    Wait Until Element Is Visible    ${FIELD_NAME}    10s
    Scroll Element Into View         ${FIELD_NAME}

    Input Text    ${FIELD_NAME}         Testovací Uživatel
    Input Text    ${FIELD_PHONE}        123456789
    Input Text    ${FIELD_EMAIL}        neplatny-email   # chybný formát
    Input Text    ${FIELD_SUBJECT}      Neplatný email
    Input Text    ${FIELD_BODY}         Test obsahu dopisu

    # Zkusíme formulář odeslat skrze JS – a zkontrolujeme, zda email je validní
    ${is_valid}=    Execute JavaScript    return document.getElementById("frm-podatelnaForm-email").checkValidity();
    Run Keyword If    ${is_valid}    Fail    Očekává se, že pole e-mail nebude validní, ale je.


    ${validation_message}=    Execute JavaScript    return document.getElementById("frm-podatelnaForm-email").validationMessage;
    Should Contain    ${validation_message}    email

*** Keywords ***
Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC008-002.png
    Close Browser

# robot -o "TC008-002-Output.xml" -r "TC008-002-Report.html" -l "TC008-002-Log.html" TC008-002.robot