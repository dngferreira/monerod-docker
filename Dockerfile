FROM arm32v7/debian:buster-slim

# Confirm on your own that version/hash is correct
ENV MONERO_VERSION 0.12.0.0
ENV MONERO_HASH 30d4d2c96cb56aae6b56b0f9978427346d48403b0da2acba91b8fb06e949ac35

WORKDIR /root
RUN apt-get update && apt-get install -y bzip2 &&\
    wget https://downloads.getmonero.org/cli/monero-linux-armv7-v${MONERO_VERSION}.tar.bz2 &&\
    echo "${MONERO_HASH}  monero-linux-armv7-v${MONERO_VERSION}.tar.bz2" | sha256sum -c &&\
    tar -xjvf monero-linux-armv7-v${MONERO_VERSION}.tar.bz2 && \
    rm monero-linux-armv7-v${MONERO_VERSION}.tar.bz2 && \
    cp ./monero-v${MONERO_VERSION}/monerod . && \
    rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
