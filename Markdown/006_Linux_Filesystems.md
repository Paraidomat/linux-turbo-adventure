# Linux Filesystems

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

## ext4 basics

- Ext4 is the evolution of the most used Linux filesystem, Ext3.
- Ext4 modifies important data structures of the filesystem such as the ones
  destined to store the file data.
- It is a stable, reliable and good performing filesystem.
- Ext4 is the default filesystem on most Linux distributions.

## xfs basics

- XFS is a high-performance journaling filesystem
- It is fast and proficient at parallel I/O
  - allocation group based design
- XFS is extremly scalable and usable
- Default filesystem on CentOS/RedHat

## comparison

- In normal day usage there is no real differnce
  - Except XFS cannot be reduced in size
- XFS is better in handling large files and parallel I/O operations
- Ext4 is better in handling small files

## File permissions

> Filesystems use **permissions** and **attributes** to regulate the level of
> interaction with that system processes can have with files and directories.

> **Warning:** When used for security purposes, permissions and attributes only
> defend against attacks launched from the booted system. To protect the stored
> data from attackers with physical access to the machine, one must also 
> implement **disk encryption**.

## Viewing Permissions / Owner / Group

- `ls -la`

::: notes

- Explain the different outputs.

:::

## Change owner / group

- `chown $user:$group $filename`
- Example: `chown root:wheel $filename`

## Changing permissions

- `chmod $who=$permissions $filename`
- Possible who's:
  - `u`: **U**ser (or owner) of the file.
  - `g`: All users in the same **g**roup as the file.
  - `o`: The **o**ther users, i.e. everyone else.
  - `a`: **a**ll of the above; use this instead of `ugo`

## Changing permissions 2

- Possible $permissions:
  - `r`: **r**ead
  - `w`: **w**rite
  - `x`: e**x**ecute
- Example: `chmod go=rx $filename`

## Changing permissions 3

- Permissions can also be displayed as a numerical value
- `chmod $permissions $filename`
- Possible permissions:
  - `4`: **r**ead
  - `2`: **w**rite
  - `1`: e**x**ecute

## Changing permissions 4

- These values have to be added to the fitting permissions
  - First value: **u**ser
  - Second value: **g**roup
  - Third value: **o**ther
- Example:
  - `7`: **r** **w** **x**
  - `5`: **r** **x**
  - `6`: **r** **w**
  - `chmod 755 $file`
  - `chmod 644 $file`

## Partitioning

> Physical drives need to be partitioned before they can be used.

> We will use one drive with one partition in this example.

## Installing software

- First install parted
  - `sudo apt-get install parted`
  - `sudo yum install parted`
  
## Find new or unpartitioned disk

- Use parted to search for unpartitioned disks
  - `sudo parted -l | grep Error`
- Or use lsblk to search for correct disk size
  - `sudo lsblk`
  
## Select partition standard

- There are two standards
  - GPT
  - MBR
- GPT is the "new" one, MBR the "old" one
- To keep it simple we will usw MBR
  - `sudo parted /dev/sdc mklabel msdos`
  
## Create partition on disk

- We create a Ext4 partition using the whole drive
  - `sudo parted /dev/sda mkpart primary ext4 0% 100%`
  - This only **specifies** the follwing filesystem
- To verify this use `lsbk`
  - `/dev/sdc1 will appear`
  
## Create Filesystem

> After partitioning a filesystem needs to be created. Otherwise
> the new partition is useless and files cannot be stored.
  
## Create the filesystem /dev/sdc

- We choose Ext4 as filesystem and test4 as the label
  - `sudo mkfs.ext4 -L test4 /dev/sdc1`
- Check new filesystem
  - `sudo lsblk --fs`
  
## Mounting partitions

> New filesystems need to be mounted before they can be used.
> This is done in `/etc/fstab`. The simple use of `mount` will not
> be permanent.

## Mounting temporary

- Create mountpoint
  - `sudo mkdir -p /mnt/data`
- Mount temporary
  - `sudo mount -o defaults /dev/sda1 /mnt/data`
  
## Mounting permanent

- Create mountpoint
  - `sudo mkdir -p /mnt/data`
- Get UUID of the partition
  - `sudo lsblk --fs`
- Edit `/etc/fstab` and add mount
  - `UUID=xxxx /mnt/data ext4 default 0 2`
- Test mount before reboot
  - `sudo mount -a`
  - `sudo df -h`
  
## Local Volume Manager ( LVM )

> Local Volume Manager ( LVM ) is a toolset to simplify storage management with different
> types of storages. It breaks physical barriers and organizes storage in a logical way.
> The main advantages of LVM are increased abstraction, flexibility, and control

> Use LVM when installing Linux!

## Physical volumes ( PV )

- Physical volumes are block devices or other storage-like hardware.
  - SSDs
  - HDDs
  - RAID-Devices
- LVM utility
  - `pvs`
  - `pvscan`
  - `pvdisplay`
  
## Volume Group ( VG )

- PVs are grouped in volume groups ( VGs )
- Different storage types appearing as one pool
- LVM utility
  - `vgs`
  - `vgscan`
  - `vgdisplay`
  
## Logical Volume ( LV )

- VGs are sliced into multiple logical volumes ( LVs )
- LVs are similar to partitions on physical harddisks
- A filesystems runs on top of a LV
- LVM utility
  - `lvs`
  - `lvdisplay`
  - `lvmdiskscan`
  
## Use LVM

> We will create a volume group out of two physical volumes
> with three logical volumes in different sizes.

::: notes

After that a lab will be nice!

:::

## Use LVM / create PV

- Create PVs
  - `sudo pvcreate /dev/sda /dev/sdb`
- Check PVs
  - `sudo pvs`

## Use LVM / add to VG

- Create VG with new PVs
  - `sudo vgcreate VolGroup /dev/sda /dev/sdb`
- Check VG
  - `sudo vgs`
  
## Use LVM / create LGs

- Create some LGs
  - `sudo lvcreate -L 10G -n test1 VolGroup`
  - `sudo lvcreate -L 3G -n test2 VolGroup`
  - `sudo lvcreate -L 25G -n test3 VolGroup`
  - `sudo lvcreate -l 100%FREE -n work VolGroup`
- Check LGs
  - `sudo lvs`
  
## Create the filesystem LVs

- LVs can be found in two places
  - `/dev/volume_group_name/logical_volume_name`
  - `/dev/mapper/volume_group_name-logical_volume_name`
- We choose Ext4 as well
  - `sudo mkfs.ext4 /dev/VolGroup/test1`
  - `sudo mkfs.ext4 /dev/VolGroup/test2`
  - `sudo mkfs.ext4 /dev/mapper/VolGroup-test3`
  - `sudo mkfs.ext4 /dev/mapper/VolGroup-work`
  
## Mount filesystems temporary

- Create mountpoints
  - `sudo mkdir -p /mnt/{test1,test2,test3,work}`
- Mount temporary
  - `sudo mount /dev/VolGroup/test1 /mnt/test1`
  - `sudo mount /dev/VolGroup/test2 /mnt/test2` 
  - `sudo mount /dev/mapper/VolGroup-test3 /mnt/test3`
  - `sudo mount /dev/mapper/VolGroup-work /mnt/work`
  
## Mount filesystems permanent

- Simply add them to `/etc/fstab`
  
## Use LVM / advanced options

- LVs can be created as different types
  - linear ( default )
  - striped ( RAID 0 )
  - raid1
  - raid5
  - raid6
  
## Use LVM / extend

- One of LVM greatest possibilites is the simple extension / resize of storage
- It is possible to grow and shrink LVs

- Extend LV and filesystem
  - `sudo lvresize -L +5G VolGroup/test1`
  - `sudo resize2fs /dev/VolGroup/test1`
  
## Use LVM / shrink

- Check for minimal disk space need
  - `df -h`
- Unmount volume
  - `umount /dev/VolGroup/test1`
- Run filesystem check to verify there are no errors
  - `sudo fsck -t ext4 -f /dev/VolGroup/test1`
- Resize filesystem to minimal value
  - `sudo resize2fs -p /dev/VolGroup/test1 3G`
- Resize LV
  - `sudo lvresize -L 3G VolGroup/test1`
- Mount the filesystem again

## Use LVM / delete LV

- Unmount LV
- Remove it
  - `sudo lvremove VolGroup/test1`

## Use LVM / remove VG

- Unmount all LVs
- Remove it
  - `sudo vgremove VolGroup`
  
## Use LVM / remove PV

- Remove one PV
  - `sudo pvremove /dev/sda`
- Remove one of two PVs
  - `sudo pvmove /dev/sda`
  - `sudo vgreduce VolGroup /dev/sda`

## Sources

- [Source 1](https://wiki.archlinux.org/index.php/File_systems)
- [Source 2](https://wiki.archlinux.org/index.php/Ext4)
- [Source 3](https://wiki.archlinux.org/index.php/Xfs)
- [Source 4](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions)
- [Source 5](https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux)
- [Source 6](https://www.digitalocean.com/community/tutorials/an-introduction-to-lvm-concepts-terminology-and-operations)
