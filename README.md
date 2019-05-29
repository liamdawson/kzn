# kzn

## OS

Built against macOS Mojave, Fedora 29 Cinnamon

## Prerequisites

* Linuxbrew/homebrew

## Initial Build

```shell
mkdir ~/.kzn
curl -sSL https://github.com/liamdawson/kzn/archive/master.tar.gz | tar -xz --directory="$HOME/.kzn" --strip-components=1
~/.kzn/kzn cycle
```

## Env Specific Notes

### LightDM (Cinnamon)

#### ~/.pam_environment

`~/.pam_environment` is not read by default according to https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2010-4708.
On a trusted single-user machine, re-enable this by deleting the line

```text
auth       required    pam_env.so
```

and adding the following line:

```diff
+ session    required    pam_env.so user_readenv=1
session    include     postlogin

```

## Deliberately manual steps

### macos

* Enable coredns: `sudo brew services start coredns`
