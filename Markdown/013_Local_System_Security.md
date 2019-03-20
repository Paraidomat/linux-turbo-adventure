# Local System Security

::: notes

https://wiki.archlinux.org/index.php/Security

:::

## Basic concepts

- Secure the system without overdoing it. 
  - It is possible to tighten the security so much as to make the system 
    unusable.
- There are many other things that can be done to heighten security.
  - Biggest Thread is, and will always be, the **user**!
- Be a little paranoid. It helps. And be suspicious. 
  - If anything sounds too good to be true, it probably is.
- **Principle of least privilege** - Each part of a system should only be able
  to access what is required to use it, and nothing more.

## Passwords

- Passwords are the main way a computer chooses to trust the person using it.
- A big part of Security is just picking secure passwords and then protecting
  them.

## What makes a good password?

- Passwords must be complex enough to not be easily guessed from e.g. 
  personal information, or cracked using methods like brute-force attacks.
- The tenets of strong passwords are based on __length__ and __randomness__.
- In cryptography the quality of a password is referred to as its entropic
  security.

## How to choose an unsecure password?

- Password contains:
  - personally identifiable informations (dog's name, date of birth, area code)
  - Simple character substitutions on words (`l33t5p34k`)
  - Root "words" or common strings followed or preceded by added numbers, 
    symbols, or characters (e.g. `DG091101%`)
  - Common phrases or short phrases of gramatically related words (e.g.
    `all of the lights`), even with character substitution

## How to choose a good password?

- A long password (8-20 characters, depending on importance)
- Seemingly completely random.
- Build secure, seemingly random passwords based on characters from every
  word in a sentence.
  - `The girl is walking down the rainy street`
  - `t6!WdtR5` or `t&6!Rrlw@dtR,57`

## How to choose a good password? 2

- Generate pseudo-random passwords like `pwgen`
- Example technique for memorization for often typed passwords:
  - Generate a long password and memorize a minimally secure number of
    characeters, **temporarily** writing down the full generated string.
  - Over time increase the number of characters typed - until the password
    is ingrained in muscle memory and need not be remembered.
  - This technique is more difficult, but can provide confidence that a 
    password will not turn up in wordlists or "intelligent" brute force
    attacks.

## Maintaining passwords

- Use the memorization technique to remember a complex password for a
  **password manager**.
- This password must never be transmitted over any kind of network.
- Additional Information from Bruce Schneier:
  - [Choosing Secure Passwords](https://www.schneier.com/blog/archives/2014/03/choosing_secure_1.html)

## Maintaining passwords 2

- Once you have strong password, be sure to keep it safe.
- Watch out for keyloggers (hard- and software), social engineering, shoulder
  surfing
- Avoid reusing passwords, so insecure servers can't leak more information
  than necessary.
- When using password managers and use copy-paste for stored passwords, make
  sure to clear the copy buffer every time, and ensure that they are not saved
  in any kind of log.
  - Do not paste them in plain terminal commands, which would store them in 
    files like `.bash_history`)

<!-- Here could be something about Password hashes from 
https://wiki.archlinux.org/index.php/Security
-->


