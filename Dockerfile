ARG VERSION=0.20.5
ARG PLATFORM=linux
ARG ARCHITECTURE=amd64

FROM alpine:3.19.0 as downloader

RUN apk add --no-cache \
    unzip \
    ca-certificates

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_${PLATFORM}_${ARCHITECTURE}.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

FROM alpine:3.19.0

COPY --from=downloader /pb/pocketbase /usr/local/bin/pocketbase

EXPOSE 8080

CMD ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8080"]
