# Troubleshooting and System Rescue

::: notes

https://wiki.archlinux.org/index.php/General_troubleshooting

:::

## General procedures

- **Attention to detail** - In order to resolve an issue that you're having it
  is crucial to have a firm basic understanding of how that specific subsystem
  functions.
- **Questions/checklist**:
  1. __What is the issue?__ Be precise as possible.
  1. __Are there error messages?__ Copy and paste **full output** that contain
     error messages related to your issue into a separate file such as 
     `$HOME/issue.log`
  1. __Can you reproduce the issue?__ Give **exact** step-by-step 
     instructions/commands needed to do so.
  1. __When did you first encounter the issues and what changed between then
     and when the system was operating without error?__ e.g. when it occured
     right after an update then list all packages that were updated. Include
     version numbers, etc.

## General procedues 2

- **Approach** - Approach issus by stating __Application X produces Y error(s)
  when performing Z tasks under conditions A and B.__ Instead of __Application
  X does not work.__

## Boot problems

- **Console messages** - After the boot, the screen is cleared and the login
  prompt appears, leaving user unable to read `init` output and error messages.
  - Kernel messages can be displayed for inspection after booting by using
    `dmesg` or all logs from the current boot with `journalctl -b`.
- **Debug output** - Most kernel messages are hidden during boot. You can see
  more of these messages by adding different kernel parameters. (`debug`, 
  `ignore_loglevel`)
- **Recovery Shells** - Getting an interactive shell at some stage in the boot
  process can help you pinpoint exactly where and why something is failing. 
  - There are several kernel parameters for doing so (`resuce`, `emergency`, 
  `init=/bin/sh`)
