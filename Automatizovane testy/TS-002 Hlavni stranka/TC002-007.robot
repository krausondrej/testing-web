*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}             Chrome
${URL_TEST_PAGE}       https://pozlovice.cz/
${POST_LINK}           xpath=(//a[contains(@class, 'content-main-box')])[1]
${EXPECTED_URL_PART}   /obec/p1148-udalosti-29-tydne

*** Test Cases ***

TC002-007: Kliknutí na příspěvek – ověření URL
    [Documentation]    Ověří, že po kliknutí na první příspěvek dojde k přesměrování na stránku s detaily příspěvku

    Scroll Element Into View         ${POST_LINK}
    Wait Until Element Is Visible    ${POST_LINK}    5s
    Click Element                    ${POST_LINK}

    Wait Until Location Contains     ${EXPECTED_URL_PART}    timeout=10s
    Location Should Contain          ${EXPECTED_URL_PART}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${POST_LINK}    timeout=10s

Post-conditions
    Capture Page Screenshot    TC002-007.png
    Close Browser

# robot -o "TC002-007-Output.xml" -r "TC002-007-Report.html" -l "TC002-007-Log.html" TC002-007.robot
