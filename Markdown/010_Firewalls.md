# Firewalls

## `iptables`

::: notes

https://wiki.archlinux.org/index.php/Iptables

:::

- a command line utility for configuring Linux Kernel firewall
- can be configured directly with `iptables` or by using one of the many
  console and graphical front-ends.
- `iptables` used for IPv4
- `ip6tables` used for IPv6
- Both have the same syntax, but some options are version-specific

## Basic Concepts

- `iptables` is used to inspect, modify, forward, redirect, and/or drop IP
  packets.
- Code for filtering is already built into the kernel
  - Organized into a collection of __tables__, each with a specific purpose
- Tables are made up of predefined __chains__, which contain rules which are
  traversed in order.
- Each rule consists of a predicate of potential matches and a corresponding
  action (called a __target__) which is executed if the predicate is true.
- `iptables` is the user utility which allows you to work with these chains.

## &nbsp; {data-background-image="https://www.frozentux.net/iptables-tutorial/images/tables_traverse.jpg" data-background-size="contain")

::: notes

- Lowercase word on top is the table
- Upper case word below is the chain
- Every IP packet that comes in on **any** network interface passes through
  this flowchart
- Common Source of confusion: internal and internet facing interfaces are 
  handled the same
- It's up to the administrator to define rules that treat them differently
- In most cases, you won't need `raw`, `mangle`, or `security` at all.

:::

## Table types

1. `raw`: only used for configuring packets so that they are exempt from 
   connection tracking.
1. `filter`: default table, where all the actions are typically associated with
   a firewall take place.
1. `nat`: used for NAT/port forwarding
1. `mangle`: used for specialized packet alterations.
1. `security`: used for __Mandatory Access Control__ (selinux)

::: notes

- In most case you will only use `filter` and `nat`.

:::

## Chains

- Tables consist of __chains__, which are lists of rules which are followed in
  order.
- The default table, `filter`, contains three built-in chains: `INPUT`, 
  `OUTPUT` and `FORWARD` which are activated at different points of the packet
  filtering process
- `nat` table includes: `PREROUTING`, `POSTROUTING` and `OUTPUT`.
- By default, non of the chains contain any rules.

## Chains 2

- Chains **do** have a default policy, which is generally set to `ACCEPT`!
  - Can be reset to drop, just to make sure.
- Default policy always applies at the end of a chain only.

## Rules

- Packet filtering is based on rules, which are specified by multiple
  __matches__, and one __target__.

## Rule matches

- The typical things a rule might match on are 
    - what interface the packet came in on (e.g. enp3s0 or wlp5s0)?
    - what type of packet it is (ICMP, TCP, UDP?)
    - the destination port of the packet (80, 443, 666)

## Rule targets

- Targets are specified using the `-j` or `--jump` option.
- Targets can be ...
  - ... user-defined chains
    - i.e. if these conditions are matched, jump to the following user defined
      chain and continue processing there
  - ... one of the special built-in targets
    - `ACCEPT`, `DROP`, `QUEUE`, `RETURN`
  - ... a target extension
    - `REJECT`, `LOG`

## Backup and Restore

- After adding rules via CLI, the configuration files are not changed
  automatically - to save manually:
  - `iptables-save > ${path}/${filename}`
- To reload a file:
  - `iptables-restore < ${path}/${filename}`

## Commands

- Check current ruleset and number of hits per rule by:
  ```
  user@host~# iptables -nvL
  Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
   pkts bytes target     prot opt in     out     source               destination
  
  Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
   pkts bytes target     prot opt in     out     source               destination
  
  Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
   pkts bytes target     prot opt in     out     source               destination
  ```

## Commands 2

- Flush (-F) and reset iptables to default using:
  ```
  iptables -F
  iptables -X
  iptables -t nat -F
  iptables -t nat -X
  iptables -t mangle -F
  iptables -t mangle -X
  iptables -t raw -F
  iptables -t raw -X
  iptables -t security -F
  iptables -t security -X
  iptables -P INPUT ACCEPT
  iptables -P FORWARD ACCEPT
  iptables -P OUTPUT ACCEPT
  ```

## Commands 3

- To disable `FORWARD`, since a computer is not a router:
  - `iptables -P FORWARD DROP`
- To reject Dropbox LAN-Sync packets:
  - `iptables -A INPUT -p tcp --dport 17500 -j REJECT 
    --reject-with icmp-port-unreachable`
- We use `REJECT` and not `DROP` since RFC 1122 requires hosts to return ICMP
  errors whenever possible.

## Effect

```
iptables -nvL --line-numbers
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
1        0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:17500 reject-with icmp-port-unreachable

Chain FORWARD (policy DROP 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
```

## Commands 4

- We installed Dropbox and want to use LAN-Sync with one specfic host in our
  network:
  - `iptables -R INPUT 1 -p tcp --dport 17500 ! -s 10.0.0.85 -j REJECT 
    --reject-with icmp-port-unreachable`

## Effect

```
iptables -nvL --line-numbers
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
1        0     0 REJECT     tcp  --  *      *      !10.0.0.85            0.0.0.0/0            tcp dpt:17500 reject-with icmp-port-unreachable

Chain FORWARD (policy DROP 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
```

## Commands 5

- To allow immediatly without further inspection by any other rule:
  - `iptables -I INPUT -p tcp --dport 17500 -s 10.0.0.85 -j ACCEPT 
    -m comment --comment "Friendly Dropbox"`
- Replace second rule with one that rejects everything on port 17500:
  - `iptables -R INPUT 2 -p tcp --dport 17500 -j REJECT 
    --reject-with icmp-port-unreachable`

## Effect

```
user@host~# iptables -nvL --line-number
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
1        0     0 ACCEPT     tcp  --  *      *       10.0.0.85            0.0.0.0/0            tcp dpt:17500 /* Friendly Dropbox */
2        0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:17500 reject-with icmp-port-unreachable

Chain FORWARD (policy DROP 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
```






## Firewall-Deamon
