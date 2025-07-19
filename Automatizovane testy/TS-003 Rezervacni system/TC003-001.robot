*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_REZERVACE}           https://pozlovice.cz/obec/rezervacni-system
${REENIO_IFRAME}           xpath=//div[contains(@class,"reenio-iframe")]/iframe

*** Test Cases ***

TC003-001: Ověření existence iframe rezervačního systému
    [Documentation]    Ověří, že iframe rezervačního systému je na stránce přítomen, viditelný a má vyplněný atribut `name`.

    Scroll Element Into View         ${REENIO_IFRAME}
    Wait Until Element Is Visible    ${REENIO_IFRAME}    10s

    ${iframe_name}=    Get Element Attribute    ${REENIO_IFRAME}    name
    Log    Iframe name: ${iframe_name}
    Should Not Be Empty              ${iframe_name}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_REZERVACE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${REENIO_IFRAME}    10s

Post-conditions
    Capture Page Screenshot    TC003-001.png
    Close Browser

# robot -o "TC003-001-Output.xml" -r "TC003-001-Report.html" -l "TC003-001-Log.html" TC003-001.robot