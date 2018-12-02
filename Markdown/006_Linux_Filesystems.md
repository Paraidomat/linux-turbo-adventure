# Linux Filesystems

::: notes

https://wiki.archlinux.org/index.php/File_systems

:::

## Introduction

> A Filesystem controls how data is stored and retrieved. Without a filesystem,
> information placed in a storage medium would be one large body of data with
> no way to tell where one piece of information stops and the next begins. By
> separating the data into pieces and giving each piece a name, the information
> is easily isolated and identified.

## Journaling

- provides fault-resilience by logging changes before they are commited to the
  file system
- In event of system crash or power failure, such file systems are faster to
  bring back online and less likely to become corrupted.
- Logging takes place in a dedicated area of the filesystem.

## ext4 and xfs basics

- Ext4 if the evolution of the most used Linux filesystem, Ext3.
- Ext4 modifies important data structures of the filesystem such as the ones
  destined to store the file data.

::: notes

https://wiki.archlinux.org/index.php/Ext4

https://wiki.archlinux.org/index.php/XFS

:::

## File permissions

> Filesystems use **permissions** and **attributes** to regulate the level of
> interaction with that system processes can have with files and directories.

> **Warning:** When used for security purposes, permissions and attributes only
> defend against attacks launched from the booted system. To protect the stored
> data from attackers with physical access to the machine, one must also 
> implement **disk encryption**.

::: notes

https://wiki.archlinux.org/index.php/File_permissions_and_attributes

https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions

::: 

## File permissions 2

### Viewing Permissions

- `ls -la`

::: notes

- Explain the different outputs.

:::

## File permissions 3

### Changing permissions

- `chmod $who=$permissions $filename`
- Possible who's:
  - `u`: **U**ser (or owner) of the file.
  - `g`: All users in the same **g**roup as the file.
  - `o`: The **o**ther users, i.e. everyone else.
  - `a`: **a**ll of the above; use this instead of `ugo`

## File permissions 4

### Changing permissions

- Possible permissions:
  - `r`: **r**ead
  - `w`: **w**rite
  - `x`: e**x**ecute
- Example: `chmod go=rx $file`

## lvm

::: notes

https://www.digitalocean.com/community/tutorials/an-introduction-to-lvm-concepts-terminology-and-operations

https://www.digitalocean.com/community/tutorials/how-to-use-lvm-to-manage-storage-devices-on-ubuntu-16-04

:::

## Application (partitioning / formatting)

https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux


