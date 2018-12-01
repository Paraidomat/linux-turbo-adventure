# Package Management Basics

> apt, yum, dnf, pkg
::: notes

https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg

:::

## Introduction

- Most modern Linux OS's offer a centralized mechanism for finding and 
  installing software.
- Software is distributed in the form of **packages**.
- Packages are kept in **repositories**.
- Working with packages is known as **package management**.
- Packages provide the basic components of the OS, shared libraries,  
  applications, services and documentation.

## Introduction 2

- The package management system does much more than one-time installation of
  software.
  - It also provides tools for upgrading already-installed packages.
- Repositories help to ensure that code has been vetted for use on your system,
  and that the installed versions of software have been approved by developers
  and package maintainers.

## Brief Overview over the Systems

- Most system are built around collection of package files.
- Package file is usually an **archive** which contains **compiled binaries** 
  and other resources making up the software, along with **installation 
  scripts**.
  - Also contains valuable metadata, like **dependencies**!

## Brief Overview over the System 2

| Operating System | Format | Tool(s)                               |
| ---------------- | ------ | ------------------------------------- |
| Debian           | .deb   | `apt`, `apt-cache`, `apt-get`, `dpkg` |
| Ubuntu           | .deb   | `apt`, `apt-cache`, `apt-get`, `dpkg` |
| Raspian          | .deb   | `apt`, `apt-cache`, `apt-get`, `dpkg` |
| CentOS           | .rpm   | `yum`                                 |

## Update Package Lists 

| System           | Command                                  |
| ---------------- | ---------------------------------------- |
| Debian / Ubuntu  | `sudo apt-get update`, `sudo apt update` |
| CentOS           | `yum check-update`                       |

## Upgrade Installed Packages Debian/Ubuntu

| Command                     | Notes                                                   |
| --------------------------- | ------------------------------------------------------- |
| `sudo apt-get upgrade`      | Only upgrades installed packages, where possible.       |
| `sudo apt-get dist-upgrade` | May add or remove packages to satisfy new dependencies. |
| `sudo apt upgrade`          | Like apt-get upgrade.                                   |
| `sudo apt full-upgrade`     | Like apt-get dist-upgrade.                              |

## Upgrade Installed Packages CentOS

| Command                     |
| --------------------------- |
| `sudo yum update`           |

## Find Packages Ubuntu/Debian

| Command                           | Notes                                       |
| --------------------------------- | ------------------------------------------- |
| `apt-cache search $search_string` |                                             |
| `apt search $search_string`       |                                             |

## Find Packages CentOS

| Command                           | Notes                                       |
| --------------------------------- | ------------------------------------------- |
| `yum search $search_string`       |                                             |
| `yum search all $search_string`   | Searches all fields, including description. |

## View Info About a Specific Package Debian/Ubuntu

| Command                   | Notes                                            | 
| ------------------------- | ------------------------------------------------ |
| `apt-cache show $package` | Shows locally-cached info about a package.       |
| `apt show $package`       |                                                  |
| `dpkg -s $package`        | Shows the current installed status of a package. |

## View Info About a Specific Package CentOS

| Command                   | Notes                                            | 
| ------------------------- | ------------------------------------------------ |
| `yum info $package`       |                                                  |
| `yum deplist $package`    | Lists dependencies for a package.                |

## Install a Package from Repositories Debian/Ubuntu

| Command                                       | Notes                                                   |
| --------------------------------------------- | ------------------------------------------------------- |
| `sudo apt-get install $package`               |                                                         |
| `sudo apt-get install $package1 $package2`    | Installs all listed packages.                           |


## Install a Package from Repositories Debian/Ubuntu 2

| Command                                       | Notes                                                   |
| --------------------------------------------- | ------------------------------------------------------- |
| `sudo apt-get install -y $package`            | Assumes yes where apt would usually prompt to continue. |
| `sudo apt install $package`                   | Displays a colored progress bar.                        |

## Install a Package from Repositories CentOS

| Command                                  | Notes                                                   |
| ---------------------------------------- | ------------------------------------------------------- |
| `sudo yum install $package`              |                                                         |
| `sudo yum install $package1 $package2`   | Installs all listed packages.                           |
| `sudo yum install -y $package`           | Assumes yes where yum would usually prompt to continue. |

## Install a Package from the Local Filesystem on Debian/Ubuntu

| Command | Notes |
| ------- | ----- |
| `sudo dpkg -i $package.deb` | |
| `sudo apt-get install -y gdebi && sudo gdebi $package.deb` | Installs and uses `gdebi` to install $package.deb and retriefe any missing dependencies. |

## Install a Package from the Local Filesystem on CentOS

| Command | Notes |
| ------- | ----- |
| `sudo yum install $package.rpm` | |

## Remove One or More Installed Packages on Debian/Ubuntu

| Command | Notes |
| ------- | ----- |
| `sudo apt-get remove $package` | |
| `sudo apt remove $package` | |
| `sudo apt-get autoremove` | Removes undeeded packages. |

## Remove One or More Installed Packages on CentOS

| Command | Notes |
| ------- | ----- |
| `sudo yum remove $package` | |

## The `apt` Command

- `apt` is a simplified interface, designed for interactive use.

| Traditional Command | `apt` Equivalent |
| ------------------- | ---------------- |
| `apt-get update` | `apt update` |
| `apt-get dist-upgrade` | `apt full-upgrade` |
| `apt-cache search $string` | `apt search $string` |
| `apt-get install $package` | `apt install $package` |
| `apt-get remove $package` | `apt remove $package` |
| `apt-get purge $package` | `apt purge $package` |

## Sources / References:

- [Source](https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg)
- [Further Reading Ubuntu/Debian](https://www.digitalocean.com/community/tutorials/ubuntu-and-debian-package-management-essentials)
- [Further Reading CentOS](https://www.centos.org/docs/5/html/yum/)
