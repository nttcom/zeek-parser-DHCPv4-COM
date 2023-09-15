# @TEST-DOC: Test Zeek parsing a trace file through the DHCPV4 analyzer.
#
# @TEST-EXEC: zeek -Cr ${TRACES}/udp-port-12345.pcap ${PACKAGE} %INPUT >output
# @TEST-EXEC: btest-diff output
# @TEST-EXEC: btest-diff dhcpv4.log

# TODO: Adapt as suitable. The example only checks the output of the event
# handlers.

event DHCPV4::message(c: connection, is_orig: bool, payload: string)
    {
    print fmt("Testing DHCPV4: [%s] %s %s", (is_orig ? "request" : "reply"), c$id, payload);
    }
