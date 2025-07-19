*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}           https://pozlovice.cz/
${MAP_WRAPPER}             id=map
${MAP_TILE}                xpath=//div[@id="map"]//img[contains(@class, "leaflet-tile")]

*** Test Cases ***

TC002-012: Ověření načtení mapy – viditelnost a dlaždice
    [Documentation]    Ověří, že mapa (Mapy.cz, Leaflet) se na stránce načte a zobrazí s načtenými dlaždicemi.

    Scroll Element Into View         ${MAP_WRAPPER}
    Wait Until Element Is Visible    ${MAP_WRAPPER}    10s

    ${tiles}=    Get WebElements    ${MAP_TILE}
    ${count}=    Get Length    ${tiles}
    Log    Počet načtených dlaždic: ${count}
    Should Be True    ${count} > 0    msg=Mapa nebyla načtena – žádné dlaždice!

    ${src}=    Get Element Attribute    ${tiles[0]}    src
    Log    První načtená dlaždice: ${src}
    Should Contain    ${src}    mapy.cz

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${MAP_WRAPPER}    10s

Post-conditions
    Capture Page Screenshot    TC002-011.png
    Close Browser

# robot -o "TC002-011-Output.xml" -r "TC002-011-Report.html" -l "TC002-011-Log.html" TC002-011.robot
