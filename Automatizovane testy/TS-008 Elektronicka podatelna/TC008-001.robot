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
${SUBMIT_BUTTON}           xpath=//input[@type='submit' and @value='Odeslat']

*** Test Cases ***
TC008-001: Ověření existence a funkčnosti formuláře elektronické podatelny
    [Documentation]    Ověří, že formulář na stránce Elektronická podatelna obsahuje povinná pole a lze do nich zapisovat.

    Go To    ${START_URL}
    Wait Until Page Contains Element    ${FIELD_NAME}    10s
    Scroll Element Into View            ${FIELD_NAME}

    Element Should Be Visible           ${FIELD_NAME}
    Element Should Be Visible           ${FIELD_PHONE}
    Element Should Be Visible           ${FIELD_EMAIL}
    Element Should Be Visible           ${FIELD_SUBJECT}
    Element Should Be Visible           ${FIELD_BODY}
    Element Should Be Visible           ${SUBMIT_BUTTON}

    Input Text    ${FIELD_NAME}         Testovací Uživatel
    Input Text    ${FIELD_PHONE}        123456789
    Input Text    ${FIELD_EMAIL}        test@example.com
    Input Text    ${FIELD_SUBJECT}      Dotaz ohledně podatelny
    Input Text    ${FIELD_BODY}         Toto je testovací zpráva přes podatelnu.

    # POZNÁMKA: Test nekončí klikem na "Odeslat", aby nedošlo k reálnému odeslání dat.
    # Kliknutí můžeš odkomentovat pro test v izolovaném prostředí:
    # Click Button    ${SUBMIT_BUTTON}


*** Keywords ***
Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC008-001.png
    Close Browser

# robot -o "TC008-001-Output.xml" -r "TC008-001-Report.html" -l "TC008-001-Log.html" TC008-001.robot