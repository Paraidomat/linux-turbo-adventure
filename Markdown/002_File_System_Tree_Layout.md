# Filesystem Tree Layout

::: notes

https://www.digitalocean.com/community/tutorials/how-to-understand-the-filesystem-layout-in-a-linux-vps#an-overview-of-the-linux-filesystem-layout

:::

- If you're new to Linux the basic way to navigate your OS can seem confusing.
- The filesystem layout my differ slightly between different distributions.

## History of the Linux Filesystem

- Linux inherits many concepts from its Unix predecessors.
- The Linux Filesystem Hierarchy Standard (FHS) is a prescriptive standard
  - Maintained by Linux Foundation
  - establishes organizational layout that Linux distros should uphold
- Used for
  - interoperability
  - ease of administration
  - ability to implement cross-distro applications reliably

## History of the Linux Filesystem 2

> Linux implements just about everything as a file!

- A text file is a file.
- A directory is a file (simply a lst of other files).
- A printer is represented by a file (device drivers send everything written 
  to the printer file to the physical printer)

## History of the Linux Filesystem 3

- Oversimplification.
- Approach the designers encourages:

> passing text and bytes back and forth and being able to apply similar
> strategies for editing and accessing diverse components.

## Overview of the Filesystem Layout

- Linux filesystem is contained within a single tree
  - Regardless of how many devices are incorporated
  - All components accessible to the OS are represented somewhere in filesystem
- In Windows each storage space is represented as its own filesystem
  - Labeled with letter designations (C:, D:)

## Overview of the Filesystem Layout 2

- Every file and device on the system resides under the "root" directory `/`.

> The root directory is not to be confused with default administrative root
> user. It is also different from the default administraive user's home 
> directory (`/root`)

## Overview of the Filesystem Layout 2

```
user@host:/$ ls
bin    dev   initrd.img      lib64       mnt   root  snap  tmp  vmlinuz
boot   etc   initrd.img.old  lost+found  opt   run   srv   usr  vmlinuz.old
cdrom  home  lib             media       proc  sbin  sys   var
```

- Every file, device, directory, or application is located under this one
  directory.

## `/bin`

::: notes

- `cd` command is actually built into the shell (bash), which is in `bin` too

:::

- Contains basic commands and programs that are needed to achieve a minimal
  working environment upon booting.
- Kept separate from some of the other programs on the system 
  - allows booting the system for maintainance 
  - even if other parts of the filesystem may be damaged or unavailable
- In this directory, you will find tools like `ls` and `pwd`

## `/boot`

- Contains the core components that actually allow the system to boot.
  - Actual files, images and kernels necessary to boot the system.
- If you need to modify the bootloader on your system, or want to see the 
  kernel files and inital ramdisk (`initrd`), you can find here.
- Must be accessible to the system very early on.

## `/dev`

- Houses the files that represent devices on your system.
- Every hard drive, terminal device, input or output device available to the
  system is represented by a file here.
- Depending on device, you can operate on the devices in different ways.
- For instance:
  - A device represents a hard drive, like `/dev/sda`, is mountable to the
    filesystem, in order to be accessible.
  - A file that represents a line printer like `/dev/lpr`, one can write 
    directly to it to send the information to the printer.

## `/etc`

- One will spend a lot of time in this directory, when you're working as a
  system administrator.
- A configuration directory for various system-wide services.
- Contains many files and subdirectories.
  - Configuration files for most of the activities on the system
- If more than one configuration file is needed, many times an 
  application-specific subdirectory is created to hold these files.
- When attempting to configure a service or program for the entire system,
  this is the first place to look.

## `/home`

- Contains the **home directory** of all the users on the system (except root)
- When a user is created, a directory matching their username will typically
  be created under this directory.
- Inside, the associated user has has write access.
- Regular users only have write access to their own home directory.
- This helps keep the file system clean

## `/home` 2

- Ensures that not just anyone can change important configuration files.
- Within the home directory, that are often hidden files and directories
  (**represented by a starting dot**)
  - Allow for user-specific configuration of tools.
  - One can set system defaults in the `/etc` directory, and then each user
    can override them as necessary in their own home directory.

## `/lib`

- Used for all the shared system **libraries** that are required by the `/bin` 
  and `/sbin` directories.
- These files basically provide functionality to the other programs on the 
  system. 
- This is one of the directories that one won't have to access often.

## `/list+found`

- Special directory that contains files recovered by `/fsck`, the Linux
  filesystem repair program. 
- If the filesystem is damaged and recovery is undertaken, sometimes files are
  found but the reference to their location is lost. 
- In this case, the system will place them in this directory.
- In most cases, this directory will remain empty. 
  - If you experience corruption or any similar problems and are forced to
    perform recovery operations, it's a good idea to check this location
    when you are finished. 

## `/media`

- Typically empty at boot.
- Its real purpose is simply to provide a location to mount removeable media
  (like CDs).
- In a server environment, this won't be used. 
- If Linux ever mounts a media disk and you are unsure of where it placed it,
  this is a safe bet.

## `/mnt`

::: notes

What is a VPS?
A virtual private server you can rent.

:::

- Directory is similar to the `/media` directory in that it exists only to
  serve as a organization mount point for devices.
- This location is usually used to mount filesystems like external hard drives,
  etc.
- This directory is often used in a VPS environment for mounting network 
  accessible drivers.
- If you have a filesystem on a remote system that you would like to mount
  on your server, this is a good place to do that.

## `/opt`

- Usage is rather ambiguous.
- Used by some distributions, but ignored by others.
- Typically, it is used to store optional packages.
- This usually means packages and applications that were not installed from
  the repositories.

## `/opt` 2

- Example:
  - Your distribution typically provides the packages through a package 
    manager like `apt` or `yum`
  - You installed programm X from source, then this directory would be a good
    location for that software.
  - Another popular option for software of this nature is `/usr/local`

## `/proc`

- Actually more than just a regular directory. 
- It is actually a pseudo-filesystem of its own that is mounted to that 
  directory.
- The proc filesystem does no contain real files.
  - Instead dynamically generated to reflect the interal state of the Linux
    kernel.

## `/proc` 2

- This means that we can check and modify different information from the 
  kernel itself in real time.
  - Like detailed information about memory usage by typing `cat /proc/meminfo`

## `/root`

- Home directory of the administrative user (root). 
- Functions exactly like the normal home directory, but is housed here instead.

## `/run`

- For the OS to write temporary runtime information during early stage of the
  boot process.
- In general, you should not have to worry about much of the information in 
  this directory.

## `/sbin`

- Much like `/bin` directory.
- Contains programs deemed essential for using the operating system.
- Distinction is usually that `/sbin` contains commands that are to available
  to the system administrator
- Other directory contains programs for all of the users of the system.

## `/selinux`

- This directory contains information involving security enhanced Linux.
- This is a **kernel module** that is used to provide access control to the
  operating system.
- For the most part this can be ignored.

## `/srv`

- This directory is used to contain data files for services provided by the 
  computer.
- In most cases, this directory is not used too much because its functionality
  can be implemented elsewhere in the filesystem.

## `/tmp`

- Used to store temporary files on the system.
- It is writeable by anyone on the computer and does not presist upon reboot.
- This means that any files that you need just for a little bit can be put
  here.
- They will be automatically deleted once the system shuts down.

## `/usr`

- One of the largest directories on the system.
- It basically includes a set of folders that look similar to those in `/`
  - Such as `/usr/bin` and `/usr/lib`
- This location is basically used to store all non-essential programs,
  their documentation, libraries, and other data that is not required for the
  most minimal usage of the system.

## `/usr` 2

- This is where most of the files on the system will be stored.
  - Some important directories are `/usr/local`, which is an alternative to 
    `/opt` for storing locally compiled programs.
  - Another interesting thing to check out is `/usr/share`
    - Contains documentation, configuration files, and other useful files.

## `/var`

- Supposed to contain variable data.
- In practice, it is used to contain information or directories that you
  expect to grow as the system is used.
  - Like system logs, backups, and web content when operating a web server.

## Conclusion

::: notes

Out of this one can create a lab.

:::

- Details of where things are stored can vary from distro to distro.
- The best way of exploring the filesystem is simply to traverse the various
  directories and try to find out what the files inside are for.
- You will begin to be able to associate different directories with 
  different functions and be able to guess where to go for specific tasks.

## Conclusion 2

- If you need a quick reference for what each directory is for, you can use the
  built-in manual pages by typing:

  ```
  man hier
  ```
  - This will give you an overview of a typical filesystem layout and the
    purposes of each location.

## Sources / Further Reading

- [Source](https://www.digitalocean.com/community/tutorials/how-to-understand-the-filesystem-layout-in-a-linux-vps#an-overview-of-the-linux-filesystem-layout)
