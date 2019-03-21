# carp-docker

A Dockerfile for Carp development, and trying out Carp without installing!

## Try it!

If you have [Docker](https://www.docker.com/) installed, playing around with
Carp is as easy as doing:

```
# this will run for a bit
docker build .

# it will finally tell you something like:
#
# Successfully built 33ca4c7f7d32
#
# after which you can do:
docker run -it 33ca4c7f7d32 carp
```

This will give you a shell in which you can play around with Carp. To verify
Carp works as intended, you can try typing:

```clojure
(defn main [] (IO.println "hi"))
```

in the REPL. Nothing will happen, but if you build it using `:bx`, `hi` should
be printed to your screen! Amazing, right?

<hr/>

Have fun!
