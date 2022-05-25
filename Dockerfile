FROM golang:alpine AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build

RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct

# 复制项目中的 go.mod 和 go.sum文件并下载依赖信息
COPY go.mod .
COPY go.sum .
RUN go mod download

# 将代码复制到容器中
COPY . .

# 将我们的代码编译成二进制可执行文件 mooncakes
RUN go build -o main .

FROM scratch

COPY ./static /static

# 从builder镜像中把/dist/app 拷贝到当前目录
COPY --from=builder /build/main /

# 声明服务端口
EXPOSE 8080

# 需要运行的命令
ENTRYPOINT ["/main"]
