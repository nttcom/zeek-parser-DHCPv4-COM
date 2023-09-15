spicy_add_analyzer(
    NAME DHCPV4
    PACKAGE_NAME zeek-parser-DHCPv4-COM
    SOURCES dhcpv4.spicy dhcpv4.evt zeek_dhcpv4.spicy
    SCRIPTS __load__.zeek main.zeek dpd.sig
)
