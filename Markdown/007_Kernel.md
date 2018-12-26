# Kernel

::: notes

https://wiki.archlinux.org/index.php/Kernel

:::

## What is a Kernel?

> The **Linux Kernel** is an open-source monolithic Unix-like computer 
> operating system kernel.

## What is a Kernel? 2

> The **kernel** is a computer program that is the core of a computer's 
> operating system, with complete control over everything in the system.

## What is a Kernel? 3

- On most systems, it is one of the first programs loaded on start-up (after
  the bootloader).
- It handles the rest of start-up as well as input/output requests from 
  software, translating them into data-processing instructions for the CPU.
- It handles memory and peripherals like keyboards, monitors, printers, etc...

## What is a Kernel? 4

![Kernel Diagram](https://upload.wikimedia.org/wikipedia/commons/8/8f/Kernel_Layout.svg)

## What is the job of a Kernel?

- Mediate access to resources like
  - CPU (What should run at which point in time?)
  - RAM (Where should which data placed in RAM or swap?)
  - I/O devices (What should access which device?)

## What is the job of a Kernel? 2

- Resource Management
  - Definition of an execution domain (address space)
  - Protection mechanisms used to media access to the resources within a domain
  - Provide methods for synchronization and inter-process communications

## What is the job of a Kernel? 3

- Memory management
  - Kernel has full access to systems's memory and must allow processes to 
    safely access this memory as they require it.
  - First step: virtual addressing (achieved by paging and/or segmentation)

## Virtual Memory

- Virtual addressing allows the kernel to make a given physical address 
  appear to be another address.
- Virtual address spaces may be different for different processes

> The memory that one process accesses at a particular (virtual) address may be
> different memory from what another process accesses at the same addresses.

## Virtual Memory 2

- This allows every programm to behave as if it is the only one (apart from the
  kernel) running
- This prevents applications from crashing each other.

## What is the job of a Kernel? 4

- Device management
  - Processes need to access the peripherals connected to the computer
  - Devices are controlled by the kernel through **drivers**.

## Drivers

- A device driver is a program that enables the operating system to 
  interact with a hardware device. 
- Provides the OS with information of how to control and communicate with 
  a certain piece of hardware.
- Goal of a driver: **abstraction**.
  - Translate the OS-mandated function calls (programming calls) into 
    device-specific calls

## What is the job of a Kernel? 5

- System calls
  - In computing a system call is how a process requests a service from the
    kernel that it does not normally have permission to run.
  - provide interface between a process and the OS
  - Most operations interacting with the system require permissions not 
    available to a user level process.
    - I/O performed with a device present on the system
    - Any form of communication with other processes


## What are Kernel Modules?

::: notes

https://wiki.archlinux.org/index.php/Kernel_module

:::

> Kernel Modules are pieces of code that can be loaded and unloaded into the
> kernel upon demand. They extend the functionality of the kernel without the
> need to reboot the system.

## Obatining information about Kernel Modules

- Modules are stored in `/usr/lib/modules/${kernel-release}`
- To get your current `${kernel-release}` you can use `uname -r`.
- To show what kernel modules are currently loaded: `lsmod`
- To shoud information about a module: `modinfo ${module_name}`

## Manual module handling

- To load a module: `modprobe ${module-name}`
- To load a module by filename (i.e. one that is not installed in 
  `/usr/lib/modules/$(uname -r)/`):
  - `insmod ${filename} [args]`
- To unload a module: `modprobe -r ${module-name}`
- Or, alternatively: `rmmon ${module-name}`

## Example: Disable the PC Beep-Speaker

- PC speaker can be disabled by unloading the `pcspkr` kernel module:
  - `rmmod pcspkr`
- Blacklisting the `pcspkr` module will prevent `udev` from loading it at boot:
  - `echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf`
