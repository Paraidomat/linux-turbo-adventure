# Man pages

## Get Help

<img src="https://media.giphy.com/media/3oz8xvZDRBvZUce6wo/giphy.gif"></img>

## `man` pages

::: notes 

https://wiki.archlinux.org/index.php/Man_page

::: 

- `man` pages are the form of documentation that is available on almonst all
  UNIX-like operating systems
- In spite of their scope, man pages are designed to be self-contained 
  documents, consequentially limiting themselves to referring to other 
  man pages when discussing related subjects.

## Accessing `man` pages

- To read a man page, simply enter: `man ${page_name}`
- Manuals are sorted into several sections.
- Man pages are usually referred to by their name, followed by their section 
  number in parentheses. `man 5 passwd`

## Searching manuals

- `man` utility allows users to display man pages, and search their contents
- Problem: What if I don't know **exactly** what I'm looking for?
  - Solution: Use the `-k` or `--apropos` options to search the man page 
    descriptions for instances of a given keyword.

## Example searches in manuals

- To search for man pages related to "password": `man -k password`
  - Equivalent to `man --apropos password` 
  - Equivalent to `apropos password`

## Getting one-line descriptions with `whatis`

```
$whatis ls
ls (1p)              - list directory contents
ls (1)               - list directory contents
```

## Noteworthy manpages

- [ASCII (7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/ascii.7), [boot (7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/boot.7), [charsets (7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/charsets.7), [chmod](https://jlk.fjfi.cvut.cz/arch/manpages/man/chmod.1), [hier(7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/hier.7), [systemd](https://jlk.fjfi.cvut.cz/arch/manpages/man/systemd.1), [regex(7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/regex.7), [signal(7)](https://jlk.fjfi.cvut.cz/arch/manpages/man/signal.7)
- More generally, have a look at all category 7 (miscellaneous) pages:
  - `man -s 7 -k ".*"



