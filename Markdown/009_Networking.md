# Networking

::: notes

https://wiki.archlinux.org/index.php/Network_configuration

:::

## Check the connection

1. Your network interface is listed and enabled.
1. You are connected to the network. (Cabling / Wireless connection)
1. Your network interface has an IP address.
1. Routing table is set up correctly.
1. You can ping your default gateway (and other gateways)
1. You can ping a public IP address (if you have access to the internet)
1. Check if you can resolve domain names.

## Is the network interface listed and enabled.

```
user@host:~$ ip link show
2: enp3s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 54:e1:ad:aa:aa:aa brd ff:ff:ff:ff:ff:ff
3: enxe04f43aaaaaa: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether e0:4f:43:aa:aa:aa brd ff:ff:ff:ff:ff:ff
4: wlp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DORMANT group default qlen 1000
    link/ether d4:6a:6a:aa:aa:aa brd ff:ff:ff:ff:ff:ff
```

- Enable / Disable using: `ip link set interface up|down`

## You network interface has an IP address

- List IP addresses `ip address show` (`ip add sho` / `ip add show ${interface-name}`)

```
user@host:~$ ip add sho wlp5s0
4: wlp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether d4:6a:6a:aa:aa:aa brd ff:ff:ff:ff:ff:ff
    inet 192.168.178.48/24 brd 192.168.178.255 scope global dynamic noprefixroute wlp5s0
       valid_lft 847113sec preferred_lft 847113sec
    inet6 2001:16b8:22c:f400:d99b:56e0:8aba:63e7/64 scope global temporary dynamic
       valid_lft 6741sec preferred_lft 3141sec
    inet6 2001:16b8:22c:f400:4d45:e31a:a51d:8387/64 scope global dynamic mngtmpaddr noprefixroute
       valid_lft 6741sec preferred_lft 3141sec
    inet6 fe80::1092:bcb0:1cb3:55ac/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

## You network interface has an IP address 2

- Add an IP address to an interface:
  - `ip address add ${address}/${prefix_len} broadcast + dev ${interface-name}`
    - address is given in CIDR notation
    - `+` is a special symbol that makes `ip` derive the boroadcast address
      from IP + subnet mask
- Delete an IP address from an interface:
  - `ip address del ${address}/${prefix_len} dev ${interface}`
- Delete **all** addresses matching a criteria (e.g. of a specific interface):
  - `ip address flush dev ${interface}`

## Bonus

- IP addresses can be calculated with `ipcalc`

## Routing table is set up correctly

- The routing table is used to determine if you can reach an IP address
  directly of what gateway (router) you should use.
- If no other route mathces the IP address, the __default gateway__ is used.
- `${prefix} is either a CIDR notation or `default` for the default gateway.
- List routes: `ip route show`
- Add a route: `ip route add ${prefix} via ${address} dev ${interface}`
- Delete a route `ip route del ${prefix} via ${address} dev ${interface}`

## Set the hostname

- __Hostname__ is a unique name created to identify a machine on a network,
  configured in `/etc/hostname`
- File can contain system's domain name, if any. 
- To edit hostname persistently edit `/etc/hostname`

## Resolve hostnames

```
user@host:~$ nslookup
> dns.google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	dns.google.com
Address: 172.217.19.78
Name:	dns.google.com
Address: 2a00:1450:4005:80b::200e
```

## Resolve hostnames 2

```
user@host:~$ dig dns.google.com

; <<>> DiG 9.11.3-1ubuntu1.3-Ubuntu <<>> dns.google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47586
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.com.			IN	A

;; ANSWER SECTION:
dns.google.com.		10	IN	A	172.217.19.78

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Wed Jan 02 16:49:58 CET 2019
;; MSG SIZE  rcvd: 59
```

## Where is the configuration file?

- The configuration file is located at `/etc/sysconfig/network`.
- Further information can be found [here](https://www.computernetworkingnotes.com/rhce-study-guide/network-configuration-files-in-linux-explained.html#:~:text=To%20store%20IP%20addresses%20and,files%20starts%20with%20the%20ifcfg%2D.)
