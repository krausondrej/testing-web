*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}          https://pozlovice.cz/
${INFO_STRIP}             id=info-strip
${TODAY_LABEL}            Dnes je
${WEATHER_ICON}           xpath=//img[contains(@src, 'weathericon') and contains(@alt, '')]

*** Test Cases ***

TC004-002: Zobrazení datumu, svátku a počasí
    [Documentation]    Ověří, že se v info-strip zobrazí datum, svátek a ikona počasí.
    Wait Until Element Is Visible    ${INFO_STRIP}    10s
    Element Should Contain           ${INFO_STRIP}    ${TODAY_LABEL}
    Page Should Contain Element      ${WEATHER_ICON}

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC004-002.png
    Close Browser

# robot -o "TC004-002-Output.xml" -r "TC004-002-Report.html" -l "TC004-002-Log.html" TC004-002.robot