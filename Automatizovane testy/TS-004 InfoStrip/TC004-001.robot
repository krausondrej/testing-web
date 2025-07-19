*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}          https://pozlovice.cz/
${INFO_STRIP}             id=info-strip
${INFO_CONTACT_TEXT}      INFO: +420 577 113 071 | mestys@pozlovice.cz

*** Test Cases ***

TC004-001: Zobrazení kontaktu – telefon a e-mail
    [Documentation]    Ověří, že v horním proužku stránky se zobrazí správný telefon a e-mail.
    Wait Until Element Is Visible    ${INFO_STRIP}    10s
    Element Should Contain           ${INFO_STRIP}    ${INFO_CONTACT_TEXT}

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC004-001.png
    Close Browser

# robot -o "TC004-001-Output.xml" -r "TC004-001-Report.html" -l "TC004-001-Log.html" TC004-001.robot