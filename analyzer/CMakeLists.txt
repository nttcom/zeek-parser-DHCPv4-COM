spicy_add_analyzer(
    NAME MYDHCP
    PACKAGE_NAME zeek-parser-DHCPv4-COM
    SOURCES mydhcp.spicy mydhcp.evt zeek_mydhcp.spicy
    SCRIPTS __load__.zeek main.zeek dpd.sig
)
