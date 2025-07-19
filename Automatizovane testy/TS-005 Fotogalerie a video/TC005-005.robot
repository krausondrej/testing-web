*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${VIDEOS_PAGE_URL}       https://pozlovice.cz/obec/videa
${VIDEO_THUMB}           xpath=//div[contains(@class, "video-thumb")]
${VIDEO_ELEMENT}         xpath=//video[contains(@class, "lg-video-object") and @src]

*** Test Cases ***

TC005-005: Ověření spuštění videa – aktivace přehrávače
    [Documentation]    Ověří, že po kliknutí na náhled videa se zobrazí HTML5 video přehrávač s atributem `src`.

    Wait Until Element Is Visible     ${VIDEO_THUMB}    10s
    Scroll Element Into View          ${VIDEO_THUMB}
    Click Element                     ${VIDEO_THUMB}

    Wait Until Page Contains Element  ${VIDEO_ELEMENT}    10s
    Page Should Contain Element       ${VIDEO_ELEMENT}

*** Keywords ***

Pre-conditions
    Open Browser    ${VIDEOS_PAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains     Videa z příspěvků    10s

Post-conditions
    Capture Page Screenshot    TC005-005.png
    Close Browser

# robot -o "TC005-005-Output.xml" -r "TC005-005-Report.html" -l "TC005-005-Log.html" TC005-005.robot
