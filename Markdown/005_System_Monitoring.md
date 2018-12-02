# System Monitoring

::: notes

https://www.digitalocean.com/community/tutorials/how-to-use-top-netstat-du-other-tools-to-monitor-server-resources

:::

## Introduction

- In order to achieve the best possible availability proper administration and monitoring
  are crutial.
- Keeping an eye on how your system is running will help you discover issues and resolve them
  quickly.
- There are plenty of command line tools created for this purpose.
- There are also automated Monitoring Systems like [Icinga2](www.icinga.com)

## How Do I Monitor Process Utilization?

::: notes

- Top portion has some system statistics
  - load average (1m, 5m, 15m)
  - Memory + Swap usage
  - Count of various process states.

- Bottom Portion has every process on the system
  - Organized by top users of resources
  - List is updated in real time.

:::

### `top`

- The most common tool, everywhere installed by default.
  - Provides a simple, real-time table of the procceses
  - largest consumers on top.

- Live Demo

## How Do I Monitor Process Utilization?

### `htop`

::: notes

- Top portion is much easier to read
- Bottom is organized in a more clear fashion
- Useful hotkeys:
  - `M`: Sort processes by memory usage
  - `P`: Sort processes by processor usage
  - `?`: Access help
  - `k`: Kill current/tagged processes
  - `F2`: Setup
  - `/$searchterm`: Search processes (like with `less` or `vi`)

:::

- Needs to be installed
- Has similar output like `top`
  - is colorized and more interactive

- Live Demo

## How Do I Find Out Which Program Is Using My Bandwidth?

### `nethogs`

::: notes

- Only a few available commands:
  - `m`: Change between kb/s, kb, b and mb
  - `r`: Sort by received.
  - `s`: Sort by sent.
  - `q`: quit.

:::

- Needs to be installed

```
NetHogs version 0.8.0

  PID USER     PROGRAM                      DEV        SENT      RECEIVED
3379  root     /usr/sbin/sshd               eth0       0.485       0.182 KB/sec
820   root     sshd: root@pts/0             eth0       0.427       0.052 KB/sec
?     root     unknown TCP                             0.000       0.000 KB/sec

  TOTAL                                                0.912       0.233 KB/sec
```

## How Do I Find Out Which Program Is Using My Bandwidth?

### `netstat`

- By default, `netstat` prints a list of open sockets.
- If we add `-a`, it will list all ports, listening and non-listening.
- If you just want to see TCP or UDP connections, add `-t` or `-u`.
- See statistics with `-s`
- Continuously update output with `-c`

## How Do I Find Out How Much Disk Space I Have Left?

### `df`

::: notes

- Output without `-h` is in bytes, with `-h` it's __human readable__
- With `--total` you can see total disk space available on all Filesystems

:::

- Quick overview of how much disk space you have left on your drives.

- Live Demo

## How Do I Find Out How Much Disk Space I Have Left?

### `du`

::: notes

- `du`
- `du -h`
- `du -sh`
- `du -c` <- Total at bottom

:::

- Gives a better picture of **what** is taking up the space.
- Will analyze usage for the current directory and any subdirectories

- Live Demo

## How Do I Find Out How Much Of My Memory Is In Use?

### `free`

::: notes

- `free`
- `free -m` <- Output in Megabyte

- Mem-Line <- Nice way to confuse yourself when using a monitoring System

:::

- Easiest way for finding out the current memory usage on your system.

- Live Demo
  - Middle line, marked `-/+ buffers/cache`, will show the actual memory used
    by applications.
  - `Mem` line includes the memory used for buffering and caching
    - freed up as soon as needed for other purposes

## Sources and Further Reading

- [Source](https://www.digitalocean.com/community/tutorials/how-to-use-top-netstat-du-other-tools-to-monitor-server-resources)
