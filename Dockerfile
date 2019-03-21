FROM fpco/stack-build:lts-13

RUN apt-get update
RUN apt-get install -y clang

WORKDIR /app

RUN git clone https://github.com/carp-lang/carp .
RUN stack build
RUN stack install


CMD ["bash"]
