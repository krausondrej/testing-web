*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${GALLERY_URL}           https://pozlovice.cz/obec/fotogalerie-a-video
${VIDEOS_BUTTON}         xpath=//a[contains(@class, "btn-rounded") and contains(., "Videa z příspěvků")]
${EXPECTED_URL_PART}     /obec/videa

*** Test Cases ***

TC005-004: Ověření odkazu „Videa z příspěvků“ – přesměrování
    [Documentation]    Ověří, že tlačítko „Videa z příspěvků“ přesměruje na správnou stránku s videi.

    Wait Until Element Is Visible     ${VIDEOS_BUTTON}    10s
    Scroll Element Into View          ${VIDEOS_BUTTON}
    Click Element                     ${VIDEOS_BUTTON}

    Wait Until Location Contains      ${EXPECTED_URL_PART}    10s
    Location Should Contain           ${EXPECTED_URL_PART}

*** Keywords ***

Pre-conditions
    Open Browser    ${GALLERY_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains         Fotogalerie    10s

Post-conditions
    Capture Page Screenshot    TC005-004.png
    Close Browser

# robot -o "TC005-004-Output.xml" -r "TC005-004-Report.html" -l "TC005-004-Log.html" TC005-004.robot
