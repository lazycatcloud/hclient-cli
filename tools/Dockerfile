FROM alpine:3.21.3

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

RUN echo "Building for platform: $TARGETPLATFORM" && \
    echo "Target OS: $TARGETOS" && \
    echo "Target Arch: $TARGETARCH"

ARG tag=20250514

WORKDIR /app
VOLUME ["/app/cfg"]

RUN wget https://gitee.com/lazycatcloud/hclient-cli/releases/download/${tag}/hclient-cli-linux-${TARGETARCH} -O /app/hclient-cli && chmod +x /app/hclient-cli
ADD ./cmd.sh /app/cmd.sh

CMD ["/app/hclient_cli"]