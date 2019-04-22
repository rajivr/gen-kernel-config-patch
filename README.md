# gen-kernel-config-patch

This branch uses the Yocto Kernel infrastructure to generate the
`zynqmp_aarch64-dom0` flavor `.config` file and an integrated patch that
can be applied against upstream kernel.

To get started, build the `gen-kernel-config-patch` docker image.

```
$ cd gen-kernel-config-patch/

$ docker build -t gen-kernel-config-patch .
```

Once the image is built &ndash;

```
$ cd gen-kernel-config-patch/

$ docker run --rm -ti -v /tmp:/tmp -v $(pwd):/root/src \
    gen-kernel-config-patch /root/src/run
```

In `/tmp` two files are generated.

* `config-zynqmp_aarch64-dom0.aarch64`

* `generated-kernel-patch.patch`
