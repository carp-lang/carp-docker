# carp-docker

A Dockerfile for Carp development, and trying out Carp without installing!

## Try it!

If you have [Docker](https://www.docker.com/) installed, playing around with
Carp is as easy as running:

```
docker run -it carplang/carp
```

This will give you a shell in which you can play around with Carp. To verify
Carp works as intended, you can try typing:

```clojure
(defn main [] (IO.println "hi"))
```

in the REPL. Nothing will happen, but if you build it using `:bx`, `hi` should
be printed to your screen! Amazing, right?

## Use it!

You can also use this image as a base image for your Carp-related Docker
projects. This is as simple as starting your Dockerfile with:

```
FROM carplang/carp:latest
```

<hr/>

Have fun!
