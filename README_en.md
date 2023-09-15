# Zeek-Parser-DHCPv4-COM

## Overview

Zeek-Parser-DHCPv4-COM is a Zeek plug-in that can analyze communication using DHCP4（Dynamic Host Configuration Protocol for IPv4）.

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
~$ git clone https://github.com/nttcom/zeek-parser-MYDHCP.git
```

Compile source code and copy the object files to the following path.
```
~$ cd ~/zeek-parser-MYDHCP/analyzer
~$ spicyz -o mydhcp.hlto mydhcp.spicy zeek_mydhcp.spicy mydhcp.evt
# mydhcp.hlt will be generated
~$ cp mydhcp.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

Then, copy the zeek file to the following paths.
```
~$ cd ~/zeek-parser-MYDHCP/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/
```

Finally, import the Zeek plugin.
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
... Omit ...
@load MYDHCP
```

This plug-in generates a `mydhcp.log` by the command below:
```
~$ cd ~/zeek-parser-MYDHCP/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/main.zeek
```

## Log type and description
This plug-in monitors all functions of mydhcp and outputs them as `mydhcp.log`.

| Field | Type | Description |
| --- | --- | --- |
| ts | time | timestamp of the communication |
| SrcIP | addr | source IP address  |
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


