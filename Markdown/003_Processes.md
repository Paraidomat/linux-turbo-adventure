# Processes

::: notes 

https://www.tldp.org/LDP/tlk/kernel/processes.html
Licence: https://www.tldp.org/LDP/tlk/misc/copyright.html

http://linux-training.be/sysadmin/ch01.html <- no copyright information

https://www.digitalocean.com/community/tutorials/how-to-use-ps-kill-and-nice-to-manage-processes-in-linux

:::

## Introduction 

- What is a procecss and how does the Linux kernel create, manage and deletes 
  the processes in the system?
- Processes carry out tasks within the operating system.
- A program is a set of machine code instruction and data stored in an 
  executable image on a disk and is, as such, a passive entity.

## What is a Process

> A process can be thought of as computer program in action.

- Is a dynamic entity, constantly changing as the machine code instructions
  are exectued by the processor.
- As well as the program's instructions instructions and data, the process
  also includes the **programm counter** and all the the CPU's **registers**
  as well as the process **stacks** containing temporary data such as route 
  parameters, return addresses and saved variables.
- The current executing program, or process, includes all of the current
  activity in the microprocessor.

## Processes basics

- **Linux is a multiprocessing operating system.**
- Processes are separate tasks each with their own rights and responsibilities.
- If one process crashes it will not cause another process in the system to 
  crash.
  - Unlike with monolithic OS (Cisco IOS, Windows 95)
- Each individual process runs in its own virtual address space and is not
  capable of interacting with another process except through secure, kernel
  managed mechanisms.
  - Interprocess Communications (IPC)

## Process Lifetime

- During the lifetime of a process it will use many system resources:
  - CPU (to run its instructions and the system's)
  - Physical memory (to hold it and its data)
  - It will open and use files within the filesystem
  - It will may use directly or indirectly use phyisical devices
- Linux must keep track of the process itself and of the system resources that
  it has so that it can manage it and the other processes in the system fairly.
- It would not be fair to the other processes in the system if one process
  monipolized most of the system's physical memory or its CPUs.

## Multiprocessing

- Most precious resource in the system is the CPU
- Linux is a multiprocessing operating system
  - Its objective is to have a process running on each CPU in the system at all
    times, to maximize CPU utilization.
  - If there are more processes than CPUs (and there usually are), the rest of
    the processes must wait before a CPU becomes free until they can be run.
- Multiprocessing is a simple idea
  - A process is executed until it must wait (usually for some system resource)
  - When it has this resource, it may run again.

## Multiprocessing 2

- In a uniprocessing system (`DOS`), the CPU would simply sit idle and the 
  waiting time would be wasted.
- In a multiprocessing system many processes are kept in memory at the same
  time.
  - Whenever a process has to wait the operationg system takes the CPU away
    from that process and gives it to another, more deserving process.
- It is the **scheduler** which chooses which is the most appropriate process
  to run next and Linux uses a number of scheduling strategies to ensure 
  fairness.

## Linux Processes

- Each process is represented by a `task_struct` data structure (task and 
  process are terms that Linux uses interchangeably).
- The `task` vector is an array of pointers to every `task_struct` data 
  structure in the system.
- This means that the maximum number of processes is limited by the size of
  the `task` vector.
- As processes are created, a new `task_struct` is allocated from system memory
  and added into the `task` vector.

## Linux Processes 2

- To make it easy to find, the current, running, process is pointed to by the
  `current` pointer  # TODO: How is this implemented with Multi-CPU Servers?
- Linux supports real time processes just as well.
  - Real time processes have to react very quickly to external events.
  - They are treated differently from normal user processes by the scheduler.
  - Although `task_struct` is complex, the fields can be divided into a number
    of functional areas.

## Process IDs

- Each process is assigned a **process ID** or **PID**
- This is how the OS identifies and keeps track of processes.

## The `init` process

- The first process spawned at boot is called __init__.
- __init__ always has PID 1.
- It is responsible for spawning every other process on the system.
- Later processes are given larger PID numbers.
- A process's __parent__ is the process that was responsible for spawning it.
  - Each process (except init) has a parent PID __PPID__.

## Parent-Child Relationships

- Creating a child process happens in two steps:
  - `fork()`, which creates new address space and copies the resources owned by
    the parent via copy-on-write to be available to the child process.
  - `exec()`, which loads an executable into the address space and executes it.

## Zombies

- In the event that a child process dies before its parent, the child becomes a
  zombie
  - until parent has collected information about it or indicated to the kernel,
    that it doesn't need that information.
  - The resources from the child process will then be freed.
  - If the parent process dies before the child, the child will be adopted by
    init
    - It can also be reassigned to another process.

## How to send signals to processes

- All processes respond to __signals__ in one way or another.
- __Signals__ are the OS way of telling programs to terminate or modify their
  behavior.

## `kill`

- Most common way: `kill ${pid}`
  - Attempts to kill process.
  - Sends the `TERM` signal.
  - Tells process to **please** terminate.
  - Allows program to perform clean-up operations and exit smoothly.

## `kill` 2

- `kill -KILL ${pid}`
  - Sends the `KILL` signal.
  - If the programm is misbehaving and does not exit with `TERM` signal.
  - Special signal that is not sent to the program, but to the kernel.
    - Kernel then shuts down the process.
  - Used to bypass programs that ignore the signals sent to them.

## Other Purposes

- Signals are not only used to shut down programs.
- Deamons will restart when given `HUP` (hang-up) signal: `kill -HUP ${pid}`
- List all signals possible: `kill -l`

## Send Signals to Processes by Name

- Use `pkill ${process_name}`
  - Works the same way as `kill` but operate with process name.
- `killall ${process_name}
  - Sends a signal to every instance of a certain process.

## Process Management

- `top` - Display Linux processes
- `htop`- Interactive process viewer
- `ps` - Report a snapshot of the current processes
- `pgrep` - Look up processes based on name and other attributes
- `kill` - Sends a signal to a process by PID.
- `pkill` - Sends a signal to a processes with name = x.
- `killall` - Sends s signal to **all** processes with name = x.

## Sources / Further Reading

- [Source 1](https://www.tldp.org/LDP/tlk/kernel/processes.html)
- [Source 2](https://www.digitalocean.com/community/tutorials/how-to-use-ps-kill-and-nice-to-manage-processes-in-linux)
