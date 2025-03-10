FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main  # Notice the change here
RUN ls /app  # Add this to verify the file exists

# final stage with distroless image

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
