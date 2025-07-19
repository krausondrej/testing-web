*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${MAIN_URL}              https://pozlovice.cz/
${INSTAGRAM_SECTION}     id=module-instagram
${INSTAGRAM_IFRAME}      xpath=//section[@id="module-instagram"]//iframe

*** Test Cases ***

TC002-013: Ověření zobrazení sekce Instagram na hlavní stránce
    [Documentation]    Ověří, že se na hlavní stránce nachází sekce s Instagramem a obsahuje vložené příspěvky (iframe).

    Wait Until Element Is Visible     ${INSTAGRAM_SECTION}    10s
    Scroll Element Into View          ${INSTAGRAM_SECTION}
    Wait Until Element Is Visible     ${INSTAGRAM_IFRAME}     10s
    Page Should Contain Element       ${INSTAGRAM_IFRAME}

# robot -o "TC002-013-Output.xml" -r "TC002-013-Report.html" -l "TC002-013-Log.html" TC002-013.robot

*** Keywords ***

Pre-conditions
    Open Browser    ${MAIN_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC002-013.png
    Close Browser

# robot -o "TC002-013-Output.xml" -r "TC002-013-Report.html" -l "TC002-013-Log.html" TC002-013.robot