ARG STACK_VERSION=lts-13
FROM fpco/stack-build:$STACK_VERSION as builder

WORKDIR /app

RUN apt-get update && apt-get install -y clang --no-install-recommends \
    && git clone https://github.com/carp-lang/carp . \
    && stack build && stack install && stack clean \
    && mv /root/.local/bin /app/bin \
    && rm -rf /app/.stack-work/install \
    && rm -rf /var/lib/apt/lists/*


FROM debian:latest

COPY --from=builder /app /opt/carp

ENV CARP_DIR=/opt/carp/
ENV PATH=$PATH:"${CARP_DIR}bin"

RUN apt-get update \
    && apt-get install -y clang libgmp10 libtinfo5 libncurses-dev --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /mnt/app

CMD ["carp"]
