*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

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
${CHECKBOX_COPY}           id=frm-podatelnaForm-isCopy
${SUBMIT_BUTTON}           xpath=//input[@type='submit' and @value='Odeslat']

*** Test Cases ***
TC008-004: Ověření funkčnosti checkboxu „Poslat kopii e-mailu“
    [Documentation]    Ověří, že checkbox „Poslat kopii e-mailu“ lze zaškrtnout a jeho stav je správně detekován.

    Go To    ${START_URL}
    Wait Until Element Is Visible    ${FIELD_NAME}    10s
    Scroll Element Into View         ${FIELD_NAME}

    Input Text    ${FIELD_NAME}         Test Tester
    Input Text    ${FIELD_PHONE}        777888999
    Input Text    ${FIELD_EMAIL}        test@example.cz
    Input Text    ${FIELD_SUBJECT}      Testování checkboxu
    Input Text    ${FIELD_BODY}         Test obsahu pro kontrolu checkboxu

    Click Element    ${CHECKBOX_COPY}

    ${checked}=    Execute JavaScript    return document.getElementById("frm-podatelnaForm-isCopy").checked;
    Should Be True    ${checked}

*** Keywords ***
Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC008-004.png
    Close Browser

# robot -o "TC008-004-Output.xml" -r "TC008-004-Report.html" -l "TC008-004-Log.html" TC008-004.robot
