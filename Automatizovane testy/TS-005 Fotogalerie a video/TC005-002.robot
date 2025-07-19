*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}              Chrome
${GALLERY_URL}          https://pozlovice.cz/obec/fotogalerie
${ALL_FILTER_LINK}      xpath=//*[@id="photos-parent"]/div[1]/div/div[1]/div/a
${CATEGORY_FIREMEN}     xpath=//div[@class="title-selector-inner"]//a[contains(text(), "Hasiči")]
${GALLERY_SECTION}      id=photos

*** Test Cases ***

TC005-002: Ověření přepnutí galerie podle kategorie (např. „Hasiči“)
    [Documentation]    Ověří, že po kliknutí na „Hasiči“ v seznamu kategorií se galerie správně načte.

    Wait Until Element Is Visible     ${ALL_FILTER_LINK}    10s
    Scroll Element Into View          ${ALL_FILTER_LINK}
    Click Element                     ${ALL_FILTER_LINK}

    Wait Until Element Is Visible     ${CATEGORY_FIREMEN}    10s
    Scroll Element Into View          ${CATEGORY_FIREMEN}
    Click Element                     ${CATEGORY_FIREMEN}

    Wait Until Location Contains      orgId=58    10s
    Wait Until Element Is Visible     ${GALLERY_SECTION}    10s
    Page Should Contain Element       ${GALLERY_SECTION}

*** Keywords ***

Pre-conditions
    Open Browser    ${GALLERY_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains         Fotogalerie    10s

Post-conditions
    Capture Page Screenshot    TC005-002.png
    Close Browser

# robot -o "TC005-002-Output.xml" -r "TC005-002-Report.html" -l "TC005-002-Log.html" TC005-002.robot