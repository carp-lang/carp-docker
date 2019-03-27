# carp-docker

A Dockerfiles for Carp development, and trying out Carp without installing!
- [carplang/carp:latest](Dockerfile) - *native executable/c builder*
- [carplang/carp:emcc](Dockerfile.emcc) *same as above + WASM/ASM.js compiler*

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

in the REPL. Nothing will happen, but if you build it using `:bx`, `hi` should
be printed to your screen! Amazing, right?

## Use it!

### As a base image:

You can also use this image as a base image for your Carp-related Docker
projects. This is as simple as starting your Dockerfile with:

```
FROM carplang/carp:latest
```

Or package only your app:

``` bash
FROM carplang/carp:latest as builder

COPY example/hello_world.carp /mnt/app/

RUN carp -b hello_world.carp

FROM scratch

COPY --from=builder /mnt/app/out/HelloWorld /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/HelloWorld"]

```

Build: `docker build -t hello_carp -f <DOCKERFILE_NAME> .` and run: `docker run --rm hello_carp`

### As a carp builder:

#### First run(from this repo root) to build `.c` files:
``` bash
docker run -v $(pwd)/example:/mnt/app \
           --user 1000:1000 \
           --rm \
           carplang/carp:latest \
           carp -b hello_world.carp
```

####  Then you can run resulting executable from the host(If it's x64glibc Linux)
``` bash
./example/out/HelloWorld
```

#### Or with a browser(WASM/ASM.JS):

##### Generate web files:
``` bash
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

##### Serve:
``` bash
docker run -v $(pwd)/example/out/:/mnt/app \
           --rm \
           -ti \
           --net=host \
           carplang/carp:emcc \
           emrun --no_browser \
                 --port 8080 \
                 hello.html
```
**Go to http://localhost:8080/hello.html (browser must support WASM)**


<hr/>

Have fun!
