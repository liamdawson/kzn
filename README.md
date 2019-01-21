
## The .kzn Cycle

```diagram

+-------------+    +------------------------+    +-----------+
|             |    |                        |    |           |
| Install OS  +--->| Install Prerequisites  +--->| kzn build |
|             |    |                        |    |           |
+-------------+    +------------------------+    +-----------+

```

### OS

Built against macOS Mojave, Ubuntu 18.10.

### Prerequisites

* Linuxbrew/homebrew

### Initial Build

```shell
mkdir ~/.kzn
curl -sSL https://github.com/liamdawson/kzn/archive/master.tar.gz | tar -xz --directory="$HOME/.kzn" --strip-components=1
~/.kzn/kzn build
```

