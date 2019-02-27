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

## Hardware

- After power-on or hard reset, control is given to a program stored in 
  read-only memory (normally PROM); often called BIOS.
- BIOS performs a basic self-test of the machine and accesses nonvolatile
  memory to read further parameters.
- This memory in the PC is battery-backed CMOS memory, so most people refer to
  it as "the **CMOS**"; outside of the the PC world, it's usually called 
  **NVRAM**.
- Parameters stored in NVRAM vary among systems, but as a minimum they should 
  specify which devices can supply an OS loader, or at least which devices may
  be proved for one; such a device is know as the **boot device**. 
- The hardware boot stage loads the OS loader from a fixed position on the 
  boot device, and then transfers control to it.

## OS Loader

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

## Kernel

- When the kernel is loaded, it initialized various components of the computer
  and OS
- Each portion of software responsible for such a task is usually considered
  a **driver** for the applicable component.
- Kernel starts the virtual memory swapper (it is a kernel process called 
  `kswapd`), and mounts some filesystem at the root path `/`.
- Then the kernel creates the initial userland processes, which is given the
  number 1 as its **PID**. 
- Traditionally, this process executes the program `/sbin/init`, to which are 
  passed the parameters that haven't already been handled by the kernel.

## Root user-space process

- __Here needs to be some text about [systemd](https://jlk.fjfi.cvut.cz/arch/manpages/man/bootup.7.en)__
