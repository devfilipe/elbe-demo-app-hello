# elbe-demo-app-hello

Minimal C application used as a demo payload for the ELBE embedded Linux
build pipeline. Its sole purpose is to illustrate how a custom application can
be compiled, packaged as a Debian `.deb`, added to a local APT repository, and
installed into a root filesystem built by ELBE.

## Contents

| File | Description |
|---|---|
| `hello.c` | Single-file C program that prints a greeting and exits |
| `Makefile` | Standard `all` / `install` / `clean` targets |

## Build

```bash
make
./hello        # ELBE Demo says Hello!
```

Cross-compilation is supported via the standard `CC` and `CFLAGS` variables:

```bash
make CC=arm-linux-gnueabihf-gcc
```

## Install

```bash
make install PREFIX=/usr DESTDIR=/path/to/staging
# installs to /path/to/staging/usr/bin/hello
```

## Relationship to other repositories

This source is not packaged directly. The companion repository
[`elbe-demo-pkg-hello`](https://github.com/devfilipe/elbe-demo-pkg-hello)
contains the `debian/` directory that builds a `.deb` from this source, and
[`elbe-demo-apt-repository`](https://github.com/devfilipe/elbe-demo-apt-repository)
hosts the resulting package in a local APT repository that ELBE can consume
during a rootfs build.

The full pipeline is:

```
elbe-demo-app-hello  (source)
        |
        v
elbe-demo-pkg-hello  (dpkg-buildpackage)
        |
        v
elbe-demo-apt-repository  (flat APT repo served over HTTP)
        |
        v
elbe-demo-projects  (ELBE XML references the repo + package name)
        |
        v
ELBE initvm  (builds the rootfs with the package installed)
```

## License

See the [LICENSE](LICENSE) file.
