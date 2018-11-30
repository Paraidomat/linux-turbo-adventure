# Processes

::: notes 

https://www.tldp.org/LDP/tlk/kernel/processes.html
Lizenz: https://www.tldp.org/LDP/tlk/misc/copyright.html

http://linux-training.be/sysadmin/ch01.html <- no copyright information

:::

## Introduction 

- What a procecss and how does the Linux kernel create, manage and deletes 
  the processes in the system.
- Processes carry out tasks within the operating system.
- A program is a set of machine code instruction and data stored in an 
  executable image on a disk and is, as such, a passive entity.
  - A process can be thought of as computer program in action.

## What is a Process

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

## `task_struct` Areas

- **State** 
  - As a process executes it changes __state__ according to its circumstances.
  - Possible States: Running, Waiting, Stopped, Zombie.
- **Scheduling Information**
  - Scheduler needs this information in order to fairly decide which process
    in the system most deserves to run
- **Identifiers**
  - Every process in the system has a process identifier (PID).
  - The process identifier is not an index into the `task` vector, it is simply
    a number.
  - Each proess also has user and group identifiers (used to control this
    processes access to the files and devices in the system).

## `task_struct` Areas 2

- **Inter-Process Communication**
  - Linux supports classic Unix IPC mechanisms (signals, pipes, semaphores)
- **Links**
  - With Linux system no process is independent of any other process.
  - Each process in the system (except the init process).
  - New processes are not created, they are copied (cloned / forked) from 
    previous processes.
  - Every `task_struct` representing a process keeps pointers to:
    - Its parent
    - Silblings (=processes with the same parent process)
    - Childs
  - Relationships can be seen by using `pstree`

## `task_struct` Areas 3

- **Times and Timers**
  - Kernel keeps track of a processes creation time as well as the CPU time
    that it consumes.
  - Each clock tick, the kernel updates the amount of time in `jiffies` that
    the current process has spent in system and in user moder.
  - Linux also supports process specific __interval__ timers.
    - Processes can use system calls to set up timers to send signals to 
      themselves when the timer expire. 
    - Can be single-shot or periodic timers.
- **File system**
  - Processes can open and close files as they wish
  - `task_struct` contains pointers to descriptors for each open file.

## `task_struct` Areas 4
- **Virtual memory**
  - Most processes have some virtual memory (kernel threads and deamons do not)
    and the Linux kernel must track how that virtual memory is mapped onto the 
    system's physical memory.
- **Processor Specific Context**
  - Whenever a process is running it is using the processor's registers, stacks
    and so on.
  - This is the processes context and, when a process is suspended, all of that
    CPU specific context must be saved in the `task_struct` for the process.
  - When a process is restarted by the scheduler its context is restored from
    here.

