*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}              Chrome
${GALLERY_URL}          https://pozlovice.cz/obec/fotogalerie
${YEAR_CHANGE_BUTTON}   xpath=//*[@id="photos-parent"]/div[1]/div/div[2]/a[2]
${EXPECTED_URL_PART}    year=2024

*** Test Cases ***

TC005-003: Ověření přesměrování po kliknutí na „Změnit rok“
    [Documentation]    Ověří, že po kliknutí na tlačítko „Změnit rok“ dojde k přesměrování na URL obsahující parametry roku (např. year=2024).

    Wait Until Element Is Visible     ${YEAR_CHANGE_BUTTON}    10s
    Scroll Element Into View          ${YEAR_CHANGE_BUTTON}
    Click Element                     ${YEAR_CHANGE_BUTTON}

    Wait Until Location Contains      ${EXPECTED_URL_PART}    10s
    Location Should Contain           ${EXPECTED_URL_PART}

*** Keywords ***

Pre-conditions
    Open Browser    ${GALLERY_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains         Fotogalerie    10s

Post-conditions
    Capture Page Screenshot    TC005-003.png
    Close Browser

# robot -o "TC005-003-Output.xml" -r "TC005-003-Report.html" -l "TC005-003-Log.html" TC005-003.robot