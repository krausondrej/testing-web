*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                 Chrome
${URL_TEST_PAGE}           https://pozlovice.cz/

${MAP_WRAPPER}             id=map
${MAP_TILE}                xpath=//div[@id="map"]//img[contains(@class, "leaflet-tile")]
${ZOOM_IN_BUTTON}          css=a.leaflet-control-zoom-in
${TILE_CONTAINER}          xpath=//div[contains(@class, "leaflet-tile-container")]

*** Test Cases ***

TC002-012: Ověření načtení mapy a funkce zoom
    [Documentation]    Ověří, že se mapa zobrazí, načtou se dlaždice a že tlačítko pro přiblížení (zoom +) funguje.

    Scroll Element Into View         ${MAP_WRAPPER}
    Wait Until Element Is Visible    ${MAP_WRAPPER}    10s

    ${tiles}=    Get WebElements    ${MAP_TILE}
    ${count}=    Get Length    ${tiles}
    Log    Počet načtených dlaždic: ${count}
    Should Be True    ${count} > 0    msg=Mapa nebyla načtena – žádné dlaždice!

    ${src}=    Get Element Attribute    ${tiles[0]}    src
    Log    První dlaždice src: ${src}
    Should Contain    ${src}    mapy.cz

    Wait Until Element Is Visible    ${ZOOM_IN_BUTTON}    5s
    ${before}=    Get Element Attribute    ${TILE_CONTAINER}    style
    Click Element                    ${ZOOM_IN_BUTTON}
    Sleep                            2s
    ${after}=    Get Element Attribute    ${TILE_CONTAINER}    style

    Log    Before Zoom: ${before}
    Log    After Zoom: ${after}
    Should Not Be Equal              ${before}    ${after}

*** Keywords ***

Pre-conditions
    Open Browser       ${URL_TEST_PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${MAP_WRAPPER}    10s

Post-conditions
    Capture Page Screenshot    TC002-012.png
    Close Browser

# robot -o "TC002-012-Output.xml" -r "TC002-012-Report.html" -l "TC002-012-Log.html" TC002-012.robot
