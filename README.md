# carp-docker

A Dockerfile for Carp development, and trying out Carp without installing!

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

### As a carp builder:

``` bash
# from this repo root:
docker run -v $(pwd)/example:/mnt/app \
           --user 1000:1000 \
           --rm \
           carplang/carp:latest \
           carp -b hello_world.carp

# You can run resulting executable from the host(If you run x64 glibc Linux)
./example/out/HelloWorld
```

<hr/>

Have fun!
