*** Settings ***
Library           SeleniumLibrary    run_on_failure=Capture Page Screenshot

Suite Setup       Pre-conditions
Suite Teardown    Post-conditions

*** Variables ***
${BROWSER}                   Chrome
${START_URL}                https://pozlovice.cz/obec/obcan

# XPathy na konkrétní odkazy ve stránce Občan (přesné)
${LINK_AKTUALITY}           xpath=//*[@id="cnt"]/div/div/div[2]/div[2]/nav/ul[1]/li[1]/a
${LINK_URAD_MESTYSE}        xpath=//*[@id="cnt"]/div/div/div[2]/div[2]/nav/ul[2]/li[1]/a
${LINK_MISTNI_POPLATKY}     xpath=//*[@id="cnt"]/div/div/div[2]/div[2]/nav/ul[3]/li[1]/a
${LINK_REALIZOVANE}         xpath=//*[@id="cnt"]/div/div/div[2]/div[2]/nav/ul[4]/li[1]/a
${LINK_ZASTUPITELSTVO}      xpath=//*[@id="cnt"]/div/div/div[2]/div[2]/nav/ul[5]/li[1]/a

*** Test Cases ***
TC007-001: Ověření hlavního obsahu na stránce Občan
    [Documentation]    Ověří, že stránka „Občan“ obsahuje důležité sekce a odkazy.

    Scroll Element Into View    ${LINK_AKTUALITY}
    Element Should Be Visible   ${LINK_AKTUALITY}

    Scroll Element Into View    ${LINK_URAD_MESTYSE}
    Element Should Be Visible   ${LINK_URAD_MESTYSE}

    Scroll Element Into View    ${LINK_MISTNI_POPLATKY}
    Element Should Be Visible   ${LINK_MISTNI_POPLATKY}

    Scroll Element Into View    ${LINK_REALIZOVANE}
    Element Should Be Visible   ${LINK_REALIZOVANE}

    Scroll Element Into View    ${LINK_ZASTUPITELSTVO}
    Element Should Be Visible   ${LINK_ZASTUPITELSTVO}

*** Keywords ***
Pre-conditions
    Open Browser    ${START_URL}    ${BROWSER}
    Maximize Browser Window

Post-conditions
    Capture Page Screenshot    TC007-001.png
    Close Browser

# robot -o "TC007-001-Output.xml" -r "TC007-001-Report.html" -l "TC007-001-Log.html" TC007-001.robot
