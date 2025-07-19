*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}           https://pozlovice.cz/
${SLIDER_SECTION}          id=eventsSlider
${NEXT_ARROW}              css=a.slider-navigation-right-arrow
${SLIDE_FIRST}             xpath=(//div[@class='slider-page'])[1]

*** Test Cases ***

TC002-008: Posun slideru událostí – ověření změny pozice slide
    [Documentation]    Ověří, že se po kliknutí na šipku vpravo změní pozice (transformace) slideru.

    Scroll Element Into View         ${SLIDER_SECTION}
    Wait Until Element Is Visible    ${NEXT_ARROW}    10s

    ${before}=    Get Element Attribute    ${SLIDE_FIRST}    style
    Click Element                      ${NEXT_ARROW}
    Sleep                              2s
    ${after}=     Get Element Attribute    ${SLIDE_FIRST}    style

    Log    Before: ${before}
    Log    After: ${after}
    Should Not Be Equal               ${before}    ${after}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SLIDER_SECTION}    10s

Post-conditions
    Capture Page Screenshot    TC002-008.png
    Close Browser

# robot -o "TC002-008-Output.xml" -r "TC002-008-Report.html" -l "TC002-008-Log.html" TC002-008.robot