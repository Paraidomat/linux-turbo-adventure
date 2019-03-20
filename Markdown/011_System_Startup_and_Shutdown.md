# System Startup + Shutdown

::: notes

https://jlk.fjfi.cvut.cz/arch/manpages/man/boot.7

:::

## Boot Process

- Varies in details among different systems, can be roughly divided into 
  phases controlled by the following components:
  1. Hardware
  1. Operating System (OS) loader
  1. Kernel
  1. root user-space process (`init` and `inittab`)
  1. Boot scripts

## Boot Process - Hardware

- After power-on or hard reset, control is given to a program stored in 
  read-only memory (normally PROM); often called BIOS.
- BIOS performs a basic self-test of the machine and accesses nonvolatile
  memory to read further parameters.
- This memory in the PC is battery-backed CMOS memory, so most people refer to
  it as "the **CMOS**" or **NVRAM**.
- Parameters stored in NVRAM vary among systems, but as a minimum should 
  specify where to find **boot device**. 
- The hardware boot stage loads the OS loader from a fixed position on the 
  boot device, and then transfers control to it.

## Boot Process - OS Loader

- Main job: locate the kernel on some device, load it, and run it.
- OS loaders allow interactive use, in order to enable specification of 
  alternative kernel and to pass optional parameters to the kernel.
- For a traditional PC the OS loader is located in the initial 512-byte block
  of the boot device (the **MBR** [master boot record])
- Most systems split the role of loading the OS between a primary OS loader
  and a secondary OS loader
  - Secondary OS loader may be located within a larger portion of persistent 
    storage, such as a disk partition.
- In Linux the OS loader usually is `grub` or `lilo`

## Boot Process - Kernel

- When the kernel is loaded &rarr; initialize various components of computer
  and OS
  - Software doing this is called a **driver**
- Kernel starts virtual memory swapper (`kswapd`) and mounts some 
  filesystem at the root path `/`.
- Kernel creates the initial userland processes (`/sbin/init`), which is given 
  the number 1 as its **PID**. 
- `init` then initializes the system using **systemd**, Upstart or SysVinit
- All major distributions have moved to **systemd**.

## systemd Features

- Boots faster than previous systems.
- Provides aggressive parallelization capabilities.
- Offers on-demand starting of deamons.
- Interaction with systemd via `systemctl`

## `systemctl` TL;DR

```
$ systemctl [options] command [name]

# To show status of everything systemd controls: 
systemctl

# Show all available services: 
systemctl list-units -t service --all

# Show active services: 
systemctl list-units -t service`

# To start units: 
systemctl start ${foo}
systemctl start /path/to/foo.service

# To stop: 
systemctl stop foo.service

# To enable or disable a service:
systemctl enable sshd.service
systemctl disable sshd.service

```
## Reboot/Shutdown

- `shutdown`:
  - Brings system down in a secure way
  - All users are notified of the pending shutdown
- Legacy commands `reboot`, `halt`, `poweroff` are still frequently used.
