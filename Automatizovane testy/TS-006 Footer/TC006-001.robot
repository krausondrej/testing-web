*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}               Chrome
${HOMEPAGE_URL}         https://pozlovice.cz/
${FOOTER_SECTION}       css=footer.footer
${FOOTER_LINKS}         xpath=//footer//a
${LOGO_IMG}             xpath=//footer//img

*** Test Cases ***

TC006-001: Ověření přítomnosti log a odkazů v patičce
    [Documentation]    Ověří, že se v patičce nachází loga (img) a odkazy (a), které vedou na externí stránky partnerů.

    Wait Until Page Contains Element    ${FOOTER_SECTION}    10s
    Scroll Element Into View            ${FOOTER_SECTION}
    Page Should Contain Element         ${LOGO_IMG}
    Page Should Contain Element         ${FOOTER_LINKS}

    ${href1}=    Get Element Attribute    xpath=(//footer//a)[1]    href
    Should Contain    ${href1}    projekty

    ${href2}=    Get Element Attribute    xpath=(//footer//a)[2]    href
    Should Contain    ${href2}    visitczechrepublic

    ${href3}=    Get Element Attribute    xpath=(//footer//a)[3]    href
    Should Contain    ${href3}    vychodni-morava

*** Keywords ***

Pre-conditions
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC006-001.png
    Close Browser

# robot -o "TC006-001-Output.xml" -r "TC006-001-Report.html" -l "TC006-001-Log.html" TC006-001.robot
