# Zeek-Parser-DHCPv4-COM

English is [here](https://github.com/nttcom/zeek-parser-DHCPv4-COM/blob/main/README_en.md)

## 概要

Zeek-Parser-DHCPv4-COMとはZeekオリジナルのDHCPv4(Dynamic Host Configuration Protocol for IPv4)プラグインを参考にして作成したプラグインです。

## 使い方

### マニュアルインストール

本プラグインを利用する前に、Zeek, Spicyがインストールされていることを確認します。
```
# Zeekのチェック
~$ zeek -version
zeek version 5.0.0

# Spicyのチェック
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# 本マニュアルではZeekのパスが以下であることを前提としています。
~$ which zeek
/usr/local/zeek/bin/zeek
```

本リポジトリをローカル環境に `git clone` します。
```
~$ git clone https://github.com/nttcom/zeek-parser-DHCPv4-COM.git
```

ソースコードをコンパイルして、オブジェクトファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-DHCPv4-COM/analyzer
~$ spicyz -o mydhcp.hlto mydhcp.spicy zeek_mydhcp.spicy mydhcp.evt
# mydhcp.hltoが生成されます
~$ cp mydhcp.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

同様にZeekファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-DHCPv4-COM/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/MYDHCP.zeek
```

最後にZeekプラグインをインポートします。
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
...省略...
@load MYDHCP
```

本プラグインを使うことで `mydhcp.log` が生成されます。
```
~$ cd ~/zeek-parser-DHCPv4-COM/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/MYDHCP.zeek
```

## ログのタイプと説明
本プラグインはdhcpv4の全ての関数を監視して`mydhcp.log`として出力します。

| フィールド | タイプ | 説明 |
| --- | --- | --- |
| ts | time | 通信した時のタイムスタンプ |
| SrcIP | addr | 送信元IPアドレス |
| SrcMAC | string | 送信元MACアドレス |
| Hostname | string | ホストの名前 |
| ParameterList | vector[count] | DHCPクライアントとDHCPサーバ間でやり取りされるメッセージ内の設定情報 |
| ClassId | string | デバイスのタイプやバージョン情報 |


`mydhcp.log` の例は以下のとおりです。
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

## 関連ソフトウェア

本プラグインは[OsecT](https://github.com/nttcom/OsecT)で利用されています。

## 関連リポジトリ

* [spicy-dhcp](https://github.com/zeek/spicy-dhcp) - ZeekオリジナルのSpicyに基づいたDHCPv4(Dynamic Host Configuration Protocol for IPv4)プラグインです。

### ログの差分(DHCPv4-COMとZeekオリジナル)

| フィールド | DHCPv4-COM | Zeekオリジナル | 説明 |
| --- | --- | --- | --- |
| ts | ◯ | ◯ | 通信した時のタイムスタンプ |
| SrcIP | ◯ |  ◯ (client_addr) | 送信元IPアドレス |
| SrcMAC | ◯ | ◯ (mac) | 送信元MACアドレス |
| Hostname | ◯ | ◯ (host_name) | ホストの名前 |
| ParameterList | ◯ | x | DHCPクライアントとDHCPサーバ間でやり取りされるメッセージ内の設定情報 |
| ClassId | ◯ | x | デバイスのタイプやバージョン情報 |
| uids | x | ◯ | 通信に付けられた一意の識別子 |
| server_addr | x | ◯ | DHCPサーバのIPアドレス |
| client_fqdn | x | ◯ | DHCPクライアントの完全修飾ドメイン名 |
| domain | x | ◯ | DHCPクライアントが所属するドメイン名 |
| requested_addr | x | ◯ | DHCPクライアントが要求したIPアドレス |
| assigned_addr | x | ◯ | DHCPサーバによってクライアントに割り当てられたIPアドレス|
| lease_time | x | ◯ | DHCPクライアントに割り当てられたIPアドレスのリース時間 |
| client_message | x | ◯ | DHCPクライアントのメッセージ |
| server_message | x | ◯ | DHCPサーバのメッセージ |
| msg_types | x | ◯ | メッセージのタイプ |
| duration | x | ◯ | 通信の継続時間 |
