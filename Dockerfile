FROM debian:latest

RUN apt-get -y update \
	&& apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
			build-essential ca-certificates wget bash libfuse-dev \
			ocaml-nox camlidl camlp5 ocaml-native-compilers ocaml-findlib \
			ghc cabal-install c2hs haskell-devscripts

ENV VERSION "8.7.0" 
RUN cd /tmp \
  && mkdir /fscq \
  && wget https://coq.inria.fr/distrib/V$VERSION/files/coq-$VERSION.tar.gz \
  && tar zxvf coq-$VERSION.tar.gz \
  && rm -rf coq-$VERSION.tar.gz \
  && cd coq-$VERSION \
  && ./configure -prefix /usr/local \
  && make \
  && make install \
  && cd .. \
  && rm -rf coq-$VERSION

ENTRYPOINT [ "/usr/bin/coqtop" ]
