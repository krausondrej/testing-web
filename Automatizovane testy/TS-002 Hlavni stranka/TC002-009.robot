*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}           https://pozlovice.cz/
${NEWSPAPER_SECTION}       id=module-newspaper
${SLIDER_FIRST}            xpath=(//div[@id="newspaper-swiper"]//a[contains(@class, "swiper-slide")])[1]
${SLIDER_NEXT_XPATH}       xpath=/html/body/section[2]/div[2]/div[3]
${IMAGE_SECOND_XPATH}      xpath=/html/body/section[2]/div[2]/div[1]/a[2]/div/img
${SLIDER_WRAPPER}    xpath=//div[@id="newspaper-swiper"]/div[contains(@class, "swiper-wrapper")]

*** Test Cases ***

TC002-009: Posun slideru zpravodaje – ověření změny pozice slide
    [Documentation]    Ověří, že se po kliknutí na šipku vpravo změní transformace wrapperu slideru.

    Scroll Element Into View         ${NEWSPAPER_SECTION}
    Wait Until Element Is Visible    ${SLIDER_NEXT_XPATH}    10s

    ${before}=    Get Element Attribute    ${SLIDER_WRAPPER}    style
    Click Element                      ${SLIDER_NEXT_XPATH}
    Sleep                              2s
    ${after}=     Get Element Attribute    ${SLIDER_WRAPPER}    style

    Log    Before transform: ${before}
    Log    After transform: ${after}
    Should Not Be Equal               ${before}    ${after}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${NEWSPAPER_SECTION}    10s

Post-conditions
    Capture Page Screenshot    TC002-009.png
    Close Browser

# robot -o "TC002-009-Output.xml" -r "TC002-009-Report.html" -l "TC002-009-Log.html" TC002-009.robot