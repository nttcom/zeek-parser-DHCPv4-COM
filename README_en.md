# Zeek-Parser-DHCPv4-COM

## Overview

Zeek-Parser-DHCPv4-COM is a plug-in created by referring to Zeek's original DHCPv4 (Dynamic Host Configuration Protocol for IPv4) plug-in.

## Usage

### Manual Installation

Before using this plug-in, please make sure Zeek, Spicy has been installed.

````
# Check Zeek
~$ zeek -version
zeek version 5.0.0

# Check Spicy
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# As a premise, the path of zeek in this manual is as below
~$ which zeek
/usr/local/zeek/bin/zeek
````

Use `git clone` to get a copy of this repository to your local environment.
```
~$ git clone https://github.com/nttcom/zeek-parser-DHCPv4-COM.git
```

Compile source code and copy the object files to the following path.
```
~$ cd ~/zeek-parser-DHCPv4-COM/analyzer
~$ spicyz -o dhcpv4.hlto dhcpv4.spicy zeek_dhcpv4.spicy dhcpv4.evt
# dhcpv4.hlto will be generated
~$ cp dhcpv4.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

Then, copy the zeek file to the following paths.
```
~$ cd ~/zeek-parser-DHCPv4-COM/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/MYDHCP.zeek
```

Finally, import the Zeek plugin.
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
... Omit ...
@load DHCPV4
```

This plug-in generates a `mydhcp.log` by the command below:
```
~$ cd ~/zeek-parser-DHCPv4-COM/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/MYDHCP.zeek
```

## Log type and description
This plug-in monitors all functions of mydhcp and outputs them as `mydhcp.log`.

| Field | Type | Description |
| --- | --- | --- |
| ts | time | timestamp of the communication |
| SrcIP | addr | source IP address |
| SrcMAC | string | source MAC address |
| Hostname | string | name of the host |
| ParameterList | vector[count] | configuration information in messages exchanged between DHCP client and DHCP server |
| ClassId | string | device type and version information |

An example of `mydhcp.log` is as follows:
```
#separator \x09
#set_separator	,
#empty_field	(empty)
#unset_field	-
#path	mydhcp
#open	2023-09-13-05-55-51
#fields	ts	SrcIP	SrcMAC	Hostname	ParameterList	ClassId
#types	time	addr	string	string	vector[count]	string
1539480862.362578	0.0.0.0	32:05:33:83:b1:e7	DESKTOP-QVGI2E4	1,3,6,15,31,33,43,44,46,47,119,121,249,252	MSFT 5.0
1539567778.980630	192.168.0.28	32:05:33:83:b1:e7	DESKTOP-QVGI2E4	1,3,6,15,31,33,43,44,46,47,119,121,249,252	MSFT 5.0
#close	2023-09-13-05-55-55
```

## Related Software

This plug-in is used by [OsecT](https://github.com/nttcom/OsecT).

## Related Work

* [spicy-dhcp](https://github.com/zeek/spicy-dhcp) - Another Spicy-based DHCPv4 plug-in for Zeek.

### Log Difference (DHCPv4-COM vs Zeek Original Log)

| Field | DHCPv4-COM | Zeek Original Log | Description |
| --- | --- | --- | --- |
| ts | ◯ | ◯ | timestamp of the communication |
| SrcIP | ◯ |  ◯ (client_addr) | source IP address |
| SrcMAC | ◯ | ◯ (mac) | source MAC address |
| Hostname | ◯ | ◯ (host_name) | name of the host |
| ParameterList | ◯ | x | configuration information in messages exchanged between DHCP client and DHCP server |
| ClassId | ◯ | x | device type and version information |
| uids | x | ◯ | unique identifier assigned to the communication |
| server_addr | x | ◯ | IP address of the DHCP server |
| client_fqdn | x | ◯ | fully qualified domain name (FQDN) of the DHCP client |
| domain | x | ◯ | domain name to which the DHCP client belongs |
| requested_addr | x | ◯ | IP address requested by the DHCP client |
| assigned_addr | x | ◯ | IP address assigned to the client by the DHCP server |
| lease_time | x | ◯ | lease time of the IP address assigned to the DHCP client |
| client_message | x | ◯ | message from the DHCP client |
| server_message | x | ◯ | message from the DHCP server |
| msg_types | x | ◯ | type of the message |
| duration | x | ◯ | duration of the communication |
