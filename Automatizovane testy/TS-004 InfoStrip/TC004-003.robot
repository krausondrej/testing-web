*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}          https://pozlovice.cz/
${FACEBOOK_LINK}          xpath=//a[contains(@href, "facebook.com")]
${INSTAGRAM_LINK}         xpath=//a[contains(@href, "instagram.com")]

*** Test Cases ***

TC004-003: Ověření odkazů na sociální sítě – Facebook a Instagram
    [Documentation]    Ověří, že existují správné odkazy na Facebook a Instagram.
    Wait Until Page Contains Element    ${FACEBOOK_LINK}    10s
    Wait Until Page Contains Element    ${INSTAGRAM_LINK}   10s

    ${fb_href}=    Get Element Attribute    ${FACEBOOK_LINK}    href
    ${ig_href}=    Get Element Attribute    ${INSTAGRAM_LINK}   href

    Should Contain    ${fb_href}    facebook.com
    Should Contain    ${ig_href}    instagram.com

*** Keywords ***

Pre-conditions
    Open Browser    ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC004-003.png
    Close Browser

# robot -o "TC004-003-Output.xml" -r "TC004-003-Report.html" -l "TC004-003-Log.html" TC004-003.robot