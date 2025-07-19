*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                Chrome
${START_URL}             https://pozlovice.cz/obec/fotogalerie-a-video
${GALLERY_BUTTON}        xpath=//a[contains(@class, "btn-rounded") and contains(., "Fotogalerie")]
${PHOTOS_BLOCK}          id=photos
${PHOTO_LINKS}           css=#photos a

*** Test Cases ***

TC005-001: Ověření načtení galerie – blok s fotkami
    [Documentation]    Ověří, že po kliknutí na "Fotogalerie" se načte blok s fotkami a obsahuje alespoň 1 fotku.

    Wait Until Element Is Visible     ${GALLERY_BUTTON}    10s
    Scroll Element Into View          ${GALLERY_BUTTON}
    Click Element                     ${GALLERY_BUTTON}

    Wait Until Page Contains Element  ${PHOTOS_BLOCK}    10s
    Scroll Element Into View          ${PHOTOS_BLOCK}
    Page Should Contain Element       ${PHOTO_LINKS}

*** Keywords ***

Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains         Fotogalerie    10s

Post-conditions
    Capture Page Screenshot    TC005-001.png
    Close Browser

# robot -o "TC005-001-Output.xml" -r "TC005-001-Report.html" -l "TC005-001-Log.html" TC005-001.robot