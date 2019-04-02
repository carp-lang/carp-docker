# carp-docker

Dockerfiles for Carp development, and trying out Carp without installing!

The following Dockerfiles are provided:

- [carplang/carp:latest](Dockerfile) — *a native executable or C build host*
- [carplang/carp:emcc](Dockerfile.emcc) — *a WASM/ASM.js build host*

## Try it!

If you have [Docker](https://www.docker.com/) installed, playing around with
Carp is as easy as running:

```
docker run -it --rm carplang/carp
```

This will give you a shell in which you can play around with Carp. To verify
Carp works as intended, you can try typing:

```clojure
(defn main [] (IO.println "hi"))
```

in the REPL. Nothing will happen, but if you build it by typing `:bx`, `hi`
should be printed to your screen! Amazing, right?

## Use it!

### As a base image:

You can also use this image as a base image for your Carp-related Docker
projects. This is as simple as starting your Dockerfile with:

```
FROM carplang/carp:latest
```

Or package only your app:

```bash
FROM carplang/carp:latest as builder

COPY example/hello_world.carp /mnt/app/

RUN carp -b hello_world.carp

FROM scratch

COPY --from=builder /mnt/app/out/HelloWorld /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/HelloWorld"]
```

You can then build your program using `docker build -t hello_carp -f
<DOCKERFILE_NAME> .` and run it using `docker run --rm hello_carp`!

### As a build host

To build `.c` files and compile them to a native executable, first run the
following from the repository root:

```bash
docker run -v $(pwd)/example:/mnt/app \
           --user 1000:1000 \
           --rm \
           carplang/carp:latest \
           carp -b hello_world.carp
```

Then you can run the resulting executable from the host, if it's x64 Linux with
glibc:

```bash
./example/out/HelloWorld
```

### As a WASM/ASM.js build host

To generate the web files, run the following after executing the build step that
produces the `.c` files from above:

```bash
docker run -v $(pwd)/example/out/:/mnt/app \
            --rm \
            -ti \
            carplang/carp:emcc \
            emcc main.c \
                 -s WASM=1 \
                 -I/opt/carp/core \
                 -o hello.html \
                 --emrun
```

Alternatively you can serve the website directly from Docker!

```bash
docker run -v $(pwd)/example/out/:/mnt/app \
           --rm \
           -ti \
           --net=host \
           carplang/carp:emcc \
           emrun --no_browser \
                 --port 8080 \
                 hello.html
```

The above will open port `8080` and serve the produced files there. This means
that you should be able to go to `http://localhost:8080/hello.html` and see your
app if your browser supports WASM!

<hr/>

Have fun!
