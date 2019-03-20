# User and Group Account Management

::: notes

https://wiki.archlinux.org/index.php/users_and_groups

:::

## Users and Groups

- Users and groups are used on GNU/Linux for access control.
  - Access control: to control access to system's files, directories, and
    peripherals.
- Linux offers simple/coarse access control mechanisms by default.

## Overview

- A __user__ is anyone who uses a computer. 
- A user is represented by a unique user name.
- Some system services also run using restricted or privileged user accounts.
- Managing users is done for the purpose of security by limiting access in 
  specific ways.
- Users may be grouped together into a __group__, and users may be added to an
  existing group to utilize the privileged access it grants.

## The Superuser

- The **superuser** (`root`) has complete access to the operating system and
  its configuration.
  - **It is intended for administrative use only!**
  - Unprivileged users can use the `su` and `sudo` programs for controlled 
    privilege escalation.

## Important Files

| File            | Purpose                                              |
| --------------- | ---------------------------------------------------- |
|  `/etc/shadow`  | Secure user account information                      |
|  `/etc/passwd`  | User account information                             |
|  `/etc/gshadow` | Contains the shadowed information for group accounts |
|  `/etc/group`   | Defines the groups to which users belong             |
|  `/etc/sudoers` | List of who can run what by sudo                     |
|  `/home/*`      | Home directories                                     |

## User management

- To list users currently logged on to the system: `who`
- To list all existing user accounts including their properties: `passwd -Sa`
  - See `passwd(1)` for the description of the output format.

## Add a new user

```
useradd -m -g ${initial-group} -G ${additional-groups} -s ${login-shell} 
${username}
```

- `-m`/`--create-home` creates the user home directory as `/home/${username}`.
  - Within their home directory, a non-root user can write files, delete them,
    and so on.

## Add a new user 2

```
useradd -m -g ${initial-group} -G ${additional-groups} -s ${login-shell} 
${username}
```

- `-g`/`--gid` defines the group name or number of the user's initial login
  group.
  - If specified, the group name must exist; if a group number is provided, it
    must refer to an already existing group.
  - If not specified the default behaviour is to create a group with the same
    name as the username, with `GID` equal to `UID`.

## Add a new user 3

```
useradd -m -g ${initial-group} -G ${additional-groups} -s ${login-shell} 
${username}
```

- `-G`/`--group` introduces a list of supplementary groups which the user is
  also a member of. 
  - Each group is separated from the next by a comma, with no intervening 
    spaces.
  - The default is for the user to belong only to the initial group.

## Add a new user 4

```
useradd -m -g ${initial-group} -G ${additional-groups} -s ${login-shell} 
${username}
```

- `-s`/`-shell` defines the path and file name of the user's default login 
  shell.
  - After the boot process is complete, the default login shell is the one
    specified here.

## Add a new user 5

> **WARNING:** In order to be able to log in, the login shell must be one of
> those listed in `/etc/shells`, otherwise the `PAM` module `pam_shell` will 
> deny the login request. 

> **Note:** The password for the newly created user must then be defined, using
> `passwd`.

- When the login shell is intended to be non-functional, for example when the
  user account is created for a specific service, `/usr/bin/nologin` may be 
  specified in place of a regular shell to politely refuse a login (see 
  `nologin(8)`).

## Other examples of user management

- Add a user to other groups:
  - `usermod -aG ${additional-groups} ${username}
  - **Warning:** If the `-a` is ommited in the `usermod` command above, the 
    user is removed from all groups not listed in `${additional-groups}`.
- To enter user information for the GECOS comment (e.g. the full user name),
  type:
  - `chfn ${username}`
- To mark a user's password as expired, requiring them to create a new password
  the first time they log in, type:
  - `chage -d 0 ${username}`

## Other examples of user management 2

- User accounts may be deleted with the following command:
  - `userdel -r ${username}`
  - The `-r` option specifies that the user's home directory and mail spool 
    should also be deleted.
- To change the user's login shell:
  - `usermod -s /bin/bash ${username}`

> **Tip:** The `adduser` script allows carrying out the jobs of `useradd`,
> `chfn` and `passwd` interactively.

## User database

- Local user information is stored in the plain-text `/etc/passwd` file
- Each line represents a user account, and has seven fields:

> `account:password:UID:GID:GECOS:directory:shell`

| Field        | Purpose                                                                     |
| ------------ | --------------------------------------------------------------------------- |
|  `account`   | is the user name; can not be blank                                          |
|  `password`  | used to be the user password; is now shadowed; see `/etc/shadow`            |
|  `UID`       | the numerical user ID; root UID: 0; standard UIDs > 1000                    |
|  `GID`       | the numerical primary group ID for the user; values listed in `/etc/groups` |
|  `GECOS`     | optional field for informational purposes                                   |
|  `directory` | used by the login command to set `$HOME` environment variable               |
|  `shell`     | is the path to the user's default __command shell__. Default: `/bin/bash`   |

## Example

> `jack:x:1001:100:Jack Smith,some comment here,,:/home/jack:/bin/bash`

## Verify integrity of `/etc/passwd`

- `pwck` can be used to verify the integrity of the user database.
  - It can sort the user list by GID at the same time, which can be helpful for
    comparison using `-s`

## Group management

- `/etc/group` is the file that defines the groups on the system (see 
  `group(5)` for details).
- Display group membership with the `groups` command: `groups ${user}`
  - If `${user}` is ommited, the current user's group name are displayed.
- The `id` command provides additional detail, such as the user's UID and
  associated GIDs: `id ${user}`
- To list all groups on the system: `cat /etc/group`

## Group management 2

- Create new groups with: `groupadd ${group}`
- Add users to a group with: `gpasswd -a ${user} ${group}`
- Modify existing group; rename `${old}` to `${new}`, preserving gid, all files
  previously owned by `${old} will be owned by `${new}:
  - `groupmod -n ${new} ${old}`

## Group management 3

- Delete existing groups: `groupdel ${group}`
- To remove users from a group: `gpasswd -d ${user} ${group}`
  - If the user is currently logged in, he must log out and in again for the 
    change to take effect.
- `grpck` command can be used to verify the integrity of the system's group
  file.
